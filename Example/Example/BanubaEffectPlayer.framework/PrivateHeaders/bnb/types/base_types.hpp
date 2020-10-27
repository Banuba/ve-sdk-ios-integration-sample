//
// Created by Lechenko on 9/1/17.
//

#pragma once

#include <vector>
#include <chrono>
#include <cstdint>
#include <cstring>
#include <memory>
#include <functional>

namespace bnb
{
    /**
     * @defgroup types Types
     * @{
     */

    /// camera image layout is top-left, 0 orientation is portrait, rotation is counterclockwise
    enum class camera_orientation : unsigned int
    {
        deg_0 = 0,
        deg_90 = 1,
        deg_180 = 2,
        deg_270 = 3,
    };

    using color_plane_data_t = std::uint8_t;
    using color_plane = std::shared_ptr<color_plane_data_t>;

    inline color_plane color_plane_vector(std::vector<color_plane_data_t> vector)
    {
        // please, don't do stuff like ->> again..  //return color_plane(vector.data(), [v =
        // std::move(vector)](color_plane_data_t*) {}) are you REALLY sure no one is going to copy
        // this deleter internally? (like shared_ptr does)
        auto* ptr = new std::vector<color_plane_data_t>(std::move(vector));
        return color_plane(ptr->data(), [ptr](color_plane_data_t*) { delete ptr; });
    }

    inline color_plane color_plane_char_arr(char* ptr, size_t size)
    {
        std::vector<color_plane_data_t> plane(size);
        memcpy(plane.data(), reinterpret_cast<color_plane_data_t*>(ptr), size);
        return color_plane_vector(plane);
    }

    inline color_plane color_plane_weak(const color_plane_data_t* ptr)
    {
        return color_plane(const_cast<color_plane_data_t*>(ptr), [](color_plane_data_t*) { /* DO NOTHING */ });
    }

    using high_res_timer = std::chrono::high_resolution_clock;
    using time_stamp_t = std::chrono::time_point<std::chrono::high_resolution_clock>;

    union point2d
    {
        struct
        {
            float x, y;
        };
        float data[2];

        float sum()
        {
            return x + y;
        }

        point2d sqr() const noexcept
        {
            return *this * *this;
        }

        point2d operator/(const point2d& p) const noexcept
        {
            return point2d{x / p.x, y / p.y};
        }

        point2d operator/(float f) const noexcept
        {
            return point2d{x / f, y / f};
        }

        point2d operator*(const point2d& p) const noexcept
        {
            return point2d{x * p.x, y * p.y};
        }

        point2d operator-(const point2d& p) const noexcept
        {
            return point2d{x - p.x, y - p.y};
        }

        point2d operator+(const point2d& p) const noexcept
        {
            return point2d{x + p.x, y + p.y};
        }
    };

    union point3d
    {
        struct
        {
            float x, y, z;
        };
        float data[3];
    };

    struct size
    {
        uint32_t width;
        uint32_t height;
    };

    struct data_t
    {
        using type = uint8_t[];
        using pointer = uint8_t*;
        using uptr = std::unique_ptr<type, std::function<void(pointer)>>;
        uptr data;
        size_t size;
    };

    /** @} */ // endgroup types
} // namespace bnb
