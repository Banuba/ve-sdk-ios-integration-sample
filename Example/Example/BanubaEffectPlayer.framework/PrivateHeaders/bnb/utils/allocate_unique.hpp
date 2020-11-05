#pragma once

#include <memory>

namespace bnb
{
    /**
     * @addtogroup utils
     * @{
     */

    template<typename T, typename Alloc, typename D, typename... Args>
    inline std::unique_ptr<T, D> allocate_unique(Alloc alloc, Args&&... args)
    {
        using traits = std::allocator_traits<Alloc>;
        auto ptr = traits::allocate(alloc, 1);
        try {
            traits::construct(alloc, ptr, std::forward<Args>(args)...);
        } catch (...) {
            traits::deallocate(alloc, ptr, 1);
            throw;
        }


        return std::unique_ptr<T, D>(
            ptr,
            [alloc = std::move(alloc)](auto p) mutable {
                auto ptr = const_cast<T*>(reinterpret_cast<const T*>(p));
                traits::destroy(alloc, ptr);
                traits::deallocate(alloc, ptr, 1);
            });
    }

    /** @} */ // endgroup utils
} // namespace bnb
