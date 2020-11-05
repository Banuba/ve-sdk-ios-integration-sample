#pragma once

#include <bnb/types/base_types.hpp>
#include <bnb/utils/event.hpp>
#include <bnb/utils/stack_pimpl.hpp>
#include <bnb/types/pixel_rect.hpp>
#include <bnb/types/interfaces/transformation.hpp>
#include <bnb/types/interfaces/point2d.hpp>

#include <memory>
#include <array>
#include <optional>

namespace bnb
{
    /**
     * @addtogroup types
     * @{
     */

    enum class rect_fit_mode : uint8_t
    {
        fit_width,  //!< Always fit to width, rect_scale = w_t / w_f
        fit_height, //!< Always fit to height, rect_scale = h_t / h_f
        fit_inside, //!< Fit all source inside target = fit to min rect_scale of width and height modes
        fit_outside //!< Fit to fill all target = fit to max rect_scale of width and height modes
    };

    //! Adjust rects to have the same aspect ratio as if fitting source_rect into target_rect according to mode,
    //! return source_rect, target_rect have the same (+-rounding) aspect ratio,
    //! and are always not exceeding corresponding input rect, preserving original centers.
    //! May do some per-axis scale adjustments within small margin for fast, integral and/or pixel-perfect scaling between pixel rects
    void fit_rects_aspect_ratio(pixel_rect& source_rect, pixel_rect& target_rect, rect_fit_mode mode = rect_fit_mode::fit_inside);

    void fill_exterior(uint8_t* pixels, uint32_t width, uint32_t height, uint32_t channels, pixel_rect rect, uint8_t color, bool edge_repeat = false);


    //! This class implements affine or perspective 2d transformations
    //! Standard usage implies transformation from common basis into other(common, image or standard) basis
    //! (e.g. written as (common -> image) in documentation)
    //!
    //!
    //! Frequently used basises are:
    //! <f ^f >f vf: direction of face-up vector left, up, right, down
    //!
    //! standard basis:
    //! ^ y
    //! | ^f
    //! .--> x
    //!
    //! common basis =
    //! image(buffer) basis:
    //! .--> x
    //! | ^f
    //! v y
    //!
    class transformation : public interfaces::transformation
    {
    public:
        static const int mat_s = 3;

        /// 3x3 row-maj transform matrix
        using mat_t = std::array<float, mat_s * mat_s>;

        /// Rotation is counter clockwise(only in standart basis):
        /// - Rotating vector(1,0) (= x basis vector) by 90deg
        ///   results in vector(0,1) (= y basis vector)
        /// - In image buffer basis(y points down) the rotation would go clockwise
        enum class rotate_t : uint32_t
        {
            deg_0 = 0,
            deg_90 = 90,
            deg_180 = 180,
            deg_270 = 270
        };

        struct affine_coeffs_t
        {
            float scale_x = 1.0f, scale_y = 1.0f;
            float trans_x = 0.0f, trans_y = 0.0f;
            rotate_t rotate = rotate_t::deg_0;
            bool flip_x = false, flip_y = false;

            //approximate comparison for float components
            bool operator==(const affine_coeffs_t& t) const noexcept;
        };

        /// Constructs identity transform
        transformation();

        /// Constructs from mat_t
        explicit transformation(const mat_t& mat);
        explicit transformation(mat_t::const_pointer mat);

        /// Constructs rotate transformation
        explicit transformation(rotate_t rotate);

        /// Constructs affine transformation
        explicit transformation(float scale_x, float scale_y = 1.f, float t_x = 0, float t_y = 0, rotate_t rotate = rotate_t::deg_0, bool flip_x = false, bool flip_y = false);

        /// Constructs affine transformation
        explicit transformation(affine_coeffs_t coeffs);

        /// Constructs transformation from source to target rectangle
        /// Rotation and flips are around rectangles' center
        explicit transformation(pixel_rect source_rect, pixel_rect target_rect, rotate_t rotate = rotate_t::deg_0, bool flip_x = false, bool flip_y = false);

        ~transformation();

        transformation(transformation&& t) noexcept;
        transformation& operator=(transformation&& t) noexcept;

        /// Applies transform t after this
        /// e.g. {rotate >> translate;} rotates first: (initial -> rotated) >> (rotated -> translated) = (initial -> translated)
        transformation operator>>(const transformation& t) const noexcept;

        /// Apply transform to point
        point2d operator*(const point2d& point) const noexcept;

        bool operator==(const transformation& t) const noexcept;

        /**
         * Get the inverse of the transformation
         * @throw std::logic_error when matrix is singular
         */
        transformation inverse() const;

        /// Clone the transformation
        transformation clone() const noexcept;

        /// Pointer to matrix data in memory (row major)
        mat_t::const_pointer data() const noexcept;

        /// Returns 3x3 row-maj transform matrix
        mat_t get_mat() const noexcept;

        /// Returns transposed matrix data (column major, opengl)
        mat_t transposed_data() const noexcept;

        /// Cast to string for debug purposes
        std::string to_string() const noexcept;

        /// Checks if last row is [0, 0, 1] up to float precision
        bool is_affine() const noexcept;

        /// Normalizes transform to be exactly affine.
        /// Results are invalid in case last row is not [~0, ~0, C]
        void normalize_affine() noexcept;

        /// Tries to extract affine coefficients from transformation
        std::optional<transformation::affine_coeffs_t> extract_affine_coeffs() const;

        /// Get reference to static flip-only transform
        static const transformation& get_flip_instance(bool flip_x, bool flip_y);

        //iface
        std::shared_ptr<interfaces::transformation> chain_right(const std::shared_ptr<interfaces::transformation>& t) const override
        {
            return std::make_shared<transformation>(*this >> static_cast<transformation&>(*t));
        }
        interfaces::point2d transform_point(const interfaces::point2d& p) const override;
        interfaces::pixel_rect transform_rect(const interfaces::pixel_rect& rect) const override;
        bool equals(const std::shared_ptr<interfaces::transformation>& t) const override
        {
            return *this == static_cast<transformation&>(*t);
        }
        std::shared_ptr<interfaces::transformation> inverse_j() const override
        {
            return std::make_shared<transformation>(inverse());
        }
        std::shared_ptr<interfaces::transformation> clone_j() const override
        {
            return std::make_shared<transformation>(clone());
        }
        std::vector<float> get_mat_j() const override
        {
            auto m = get_mat();
            return {m.begin(), m.end()};
        }

    private:
        struct impl;

        using impl_t = stack_pimpl<impl, 36, 4>;
        impl_t m_impl;
    };


    template<typename T>
    struct transformable_event : public base_event<T>
    {
        /// (common -> some event data basis) transformation
        transformation basis_transform;
        /// rectangle area in common basis that encloses all valid & usable data
        pixel_rect full_roi;
    };

    /**
     * Transform src image to dst
     * params src, src_w, src_h source image buffer, width and height
     * params dst, dst_w, dst_h destination image buffer, width and height
     * param channels number of channels per pixel
     * param t transformation (src -> dst) to apply
     */
    void transform(const uint8_t* src, uint32_t src_w, uint32_t src_h, uint8_t* dst, uint32_t dst_w, uint32_t dst_h, uint32_t channels, const transformation& t);

    /**
     * Transform src image to dst through common basis
     * NOTE: both transformations should be (common -> image)
     * @param src, src_w, src_h source image buffer, width and height
     * @param dst, dst_w, dst_h destination image buffer, width and height
     * @param channels number of channels per pixel
     * @param from,to transformations (common -> image) to apply by formula (from -> common -> to)
     */
    inline void transform(const uint8_t* src, uint32_t src_w, uint32_t src_h, uint8_t* dst, uint32_t dst_w, uint32_t dst_h, uint32_t channels, const transformation& from, const transformation& to)
    {
        transform(src, src_w, src_h, dst, dst_w, dst_h, channels, from.inverse() >> to);
    }

    /**
     * Transform src image to dst
     * param src, dst source, destination image buffers
     * param w, h source, destination width and height
     * param channels number of channels per pixel
     * param t transformation (src -> dst) to apply
     */
    inline void transform1x1(const uint8_t* src, uint8_t* dst, uint32_t w, uint32_t h, uint32_t channels, const transformation& t)
    {
        return transform(src, w, h, dst, w, h, channels, t);
    }


    /**
     * Apply transformation to point
     * @param point 2D point to transform
     * @param t transformation to apply
     * @return result 2D point
     */
    point2d transform(const point2d& point, const transformation& t);

    /**
     * Transform point through common basis
     * Apply transformation to point from some basis to another one through common basis
     * NOTE: both transformations should be (common -> image)
     * param point 2D point to transform
     * param from,to transformations (common -> image) to apply by formula (from -> common -> to)
     * return result 2D point
     */
    inline point2d transform(const point2d& point, const transformation& from, const transformation& to)
    {
        return transform(point, from.inverse() >> to);
    }

    /**
     * Apply transformation to rect
     * Result is normalized wrt. flips/rotates so that w > 0 && h > 0
     * @param rect pixel_rect to transform
     * @param t transformation to apply
     * @return result pixel_rect
     */
    pixel_rect transform(const pixel_rect& rect, const transformation& t);


    inline interfaces::point2d transformation::transform_point(const interfaces::point2d& p) const
    {
        auto pt = bnb::transform(point2d{{p.x, p.y}}, *this);
        return {pt.x, pt.y};
    }
    inline interfaces::pixel_rect transformation::transform_rect(const interfaces::pixel_rect& rect) const
    {
        return bnb::transform({rect}, *this).get_iface();
    }

    /** @} */ // endgroup types

} // namespace bnb
