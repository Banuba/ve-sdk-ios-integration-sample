#pragma once

#include <bnb/types/interfaces/pixel_format.hpp>
#include <bnb/types/base_types.hpp>
#include <bnb/types/transformation.hpp>
#include <bnb/utils/event.hpp>
#include <bnb/utils/defs.hpp>

#include <type_traits>

namespace bnb
{
    /**
     * @addtogroup types
     * @{
     */

    struct BNB_EXPORT image_format
    {
        uint32_t width = 0;
        uint32_t height = 0;
        std::optional<float> fov = std::nullopt;

        camera_orientation orientation = camera_orientation::deg_270;

        bool require_mirroring = false;
        int face_orientation = 0;

        uint32_t size() const noexcept;

        /// return how relative X-coordinates from FRX are scaled in respect to original image(X_frx = X_orig * scale + offset).
        float x_scale() const;

        image_format() = default;

        image_format(uint32_t width, uint32_t height, camera_orientation orientation, bool require_mirroring, int face_orientation, std::optional<float> fov = std::nullopt);
    };


    class BNB_EXPORT base_image_t
    {
    public:
        image_format get_format() const;

    protected:
        explicit base_image_t(const image_format& format);

        const image_format m_format;
    };


    class BNB_EXPORT bpc8_image_t BNB_FINAL : public base_image_t
    {
    public:
        using pixel_format_t = bnb::interfaces::pixel_format;

        bpc8_image_t(bpc8_image_t&&) = default;
        bpc8_image_t& operator=(bpc8_image_t&& other) = delete; // `pixel_format_t` has no move assignment operator

        bpc8_image_t(color_plane data, pixel_format_t type, const image_format& format);

        pixel_format_t get_pixel_format() const noexcept;

        uint8_t* get_data() const noexcept;

        bpc8_image_t clone() const;

        static uint8_t bytes_per_pixel(pixel_format_t fmt);
        static std::tuple<int, int, int> rgb_offsets(pixel_format_t fmt);

    private:
        const pixel_format_t m_pixel_format;
        color_plane m_data;
    };

    class BNB_EXPORT yuv_image_t BNB_FINAL : public base_image_t
    {
    public:
        color_plane y_plane;
        color_plane uv_plane;

        yuv_image_t(color_plane y_plane, color_plane uv_plane, const image_format& format)
            : base_image_t(format)
            , y_plane(std::move(y_plane))
            , uv_plane(std::move(uv_plane))
        {
        }

        size_t y_size() const noexcept;
        size_t uv_size() const noexcept;

        uint8_t y_pixel_at(uint32_t yi, uint32_t xi) const noexcept;

        uint8_t uv_pixel_at(uint32_t yi, uint32_t xi, uint32_t offset) const noexcept;

        uint8_t u_pixel_at(uint32_t yi, uint32_t xi) const noexcept;
        uint8_t v_pixel_at(uint32_t yi, uint32_t xi) const noexcept;

        yuv_image_t() = delete;
        yuv_image_t(yuv_image_t&&) = default;
        yuv_image_t& operator=(yuv_image_t&& other) = delete;

        yuv_image_t(const yuv_image_t&) = delete;
        yuv_image_t& operator=(const yuv_image_t&) = delete;

        yuv_image_t clone() const;
    };

    /// basis is the base basis:
    /// for y/rgb basis use .basis or get_subchannel_basis_transform(1);
    /// for uv basis use get_subchannel_basis_transform(2);
    class BNB_EXPORT full_image_t : public transformable_event<full_image_t>
    {
    public:
        static full_image_t load(const std::string& path);

        full_image_t();
        explicit full_image_t(bpc8_image_t image);
        explicit full_image_t(yuv_image_t image);

        full_image_t(const full_image_t&) = delete;
        full_image_t(full_image_t&&) noexcept;

        ~full_image_t() override;

        full_image_t& operator=(full_image_t&& other) noexcept;
        full_image_t& operator=(const full_image_t&) = delete;
        full_image_t clone() const;


        image_format get_format() const;

        bnb::transformation get_subchannel_basis_transform(float inv_scale = 1.f) const
        {
            return basis_transform >> bnb::transformation(1.f / inv_scale, 1.f / inv_scale);
        }

        bnb::transformation image_basis() const
        {
            using rot_t = transformation::rotate_t;
            return bnb::transformation(full_roi, full_roi, rot_t::deg_0, get_format().require_mirroring) >> basis_transform;
        }

        template<typename T>
        const T& get_data() const noexcept;

        template<typename T>
        bool has_data() const noexcept;


    private:
        struct image_data;
        std::unique_ptr<image_data> m_image_data;

        template<typename T>
        const T& _get_data() const noexcept;

        template<typename T>
        bool _has_data() const noexcept;

        void update_basis_transform();
    };

    template<typename T>
    inline const T& bnb::full_image_t::get_data() const noexcept
    {
        static_assert(std::is_base_of<base_image_t, T>::value, "Type is not image_t");
        return _get_data<T>();
    }

    template<typename T>
    inline bool full_image_t::has_data() const noexcept
    {
        static_assert(std::is_base_of<base_image_t, T>::value, "Type is not image_t");
        return _has_data<T>();
    }

    /** @} */ // endgroup types

} // namespace bnb
