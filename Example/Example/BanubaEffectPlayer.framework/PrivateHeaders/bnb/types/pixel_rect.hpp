#pragma once

#include <bnb/types/interfaces/pixel_rect.hpp>

#include <algorithm>

namespace bnb
{
    /**
     * @addtogroup types
     * @{
     */

    struct pixel_rect
    {
        int32_t x = 0, y = 0;
        int32_t w = 0, h = 0;

        bool is_valid() const
        {
            return w > 0 && h > 0;
        }

        void transpose()
        {
            std::swap(x, y);
            std::swap(w, h);
        }

        pixel_rect intersect(const pixel_rect& rect) const
        {
            auto newtlx = std::max(x, rect.x);
            auto newtly = std::max(y, rect.y);
            auto newbrx = std::min(x + w, rect.x + rect.w);
            auto newbry = std::min(y + h, rect.y + rect.h);

            if (newbrx < newtlx || newbry < newtly)
                return pixel_rect();

            return pixel_rect{newtlx, newtly, newbrx - newtlx, newbry - newtly};
        }

        bool operator==(const pixel_rect& cmp) const noexcept
        {
            return w == cmp.w && h == cmp.h && x == cmp.x && y == cmp.y;
        }
        bool operator!=(const pixel_rect& cmp) const noexcept
        {
            return !(*this == cmp);
        }

        pixel_rect(int32_t _x, int32_t _y, int32_t _w, int32_t _h)
            : x(_x)
            , y(_y)
            , w(_w)
            , h(_h)
        {
        }

        pixel_rect(int32_t _w, int32_t _h)
            : x(0)
            , y(0)
            , w(_w)
            , h(_h)
        {
        }

        pixel_rect()
            : x(0)
            , y(0)
            , w(0)
            , h(0)
        {
        }

        pixel_rect(const interfaces::pixel_rect& rect)
            : x(rect.x)
            , y(rect.y)
            , w(rect.w)
            , h(rect.h)
        {
        }

        interfaces::pixel_rect get_iface() const
        {
            return interfaces::pixel_rect{x, y, w, h};
        }
    };

} // namespace bnb
