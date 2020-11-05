#pragma once

#include <bnb/utils/concurrency.hpp>

#include <array>
#include <algorithm>
#include <new>

namespace bnb
{
    /**
     * @addtogroup utils
     * @{
     */

    template<typename T, size_t MAX_ELEMENTS>
    alignas(T) inline static unsigned char static_pool[sizeof(T) * MAX_ELEMENTS];

    /**
     * Doesn't support N allocs (std::vector)
     */
    template<typename T, size_t MAX_ELEMENTS>
    struct static_pool_allocator
    {
    public:
        using value_type = T;

        static_pool_allocator() = default;

        template<class U>
        inline constexpr explicit static_pool_allocator(const static_pool_allocator<U, MAX_ELEMENTS>& u) noexcept
        {
        }

        template<class U>
        struct rebind
        {
            using other = static_pool_allocator<U, MAX_ELEMENTS>;
        };

        T* allocate(std::size_t n);
        T* allocate(std::size_t n, const std::nothrow_t&) noexcept;

        void deallocate(T* p, std::size_t n);

        bool is_mine(T* p);

    private:
        T* _allocate() noexcept;
        bool _have_free() noexcept;

        using free_slots_t = std::array<size_t, MAX_ELEMENTS>;

        static struct static_data_t
        {
            static_data_t();

            free_slots_t free_slots;
            typename free_slots_t::iterator free_slots_end;
            std::atomic_flag pool_lock;
            unsigned char (&pool)[sizeof(T) * MAX_ELEMENTS];
        } static_data;
    };


    template<typename T, size_t MAX_ELEMENTS, template<typename> class Alloc_fallback = std::allocator>
    class static_pool_allocator_fallback : public static_pool_allocator<T, MAX_ELEMENTS>
    {
        Alloc_fallback<T> alloc;

    public:
        T* allocate(std::size_t n)
        {
            if (T* p = static_pool_allocator<T, MAX_ELEMENTS>::allocate(n, std::nothrow); p != nullptr) {
                return p;
            } else {
                return alloc.allocate(n);
            }
        }
        void deallocate(T* p, std::size_t n)
        {
            if (static_pool_allocator<T, MAX_ELEMENTS>::is_mine(p)) {
                static_pool_allocator<T, MAX_ELEMENTS>::deallocate(p, n);
            } else {
                alloc.deallocate(p, n);
            }
        }
    };


    template<typename T, size_t MAX_ELEMENTS>
    static_pool_allocator<T, MAX_ELEMENTS>::static_data_t::static_data_t()
        : pool(bnb::static_pool<T, MAX_ELEMENTS>)
    {
        int i = 0;
        std::generate(free_slots.begin(), free_slots.end(), [i]() mutable { return i++; });
        free_slots_end = free_slots.end();
        pool_lock.clear();
    }


    template<typename T, size_t MAX_ELEMENTS>
    inline T* static_pool_allocator<T, MAX_ELEMENTS>::allocate(std::size_t n)
    {
        spin_lock l(static_data.pool_lock);

        if (!_have_free() || n > 1)
            throw std::bad_alloc();

        return _allocate();
    }

    template<typename T, size_t MAX_ELEMENTS>
    inline T* static_pool_allocator<T, MAX_ELEMENTS>::allocate(std::size_t n, const std::nothrow_t&) noexcept
    {
        spin_lock l(static_data.pool_lock);

        if (!_have_free() || n > 1)
            return nullptr;

        return _allocate();
    }

    template<typename T, size_t MAX_ELEMENTS>
    inline T* static_pool_allocator<T, MAX_ELEMENTS>::_allocate() noexcept
    {
        --static_data.free_slots_end;
        const size_t slot = *static_data.free_slots_end;

        void* mem = &static_data.pool[slot * sizeof(T)];

        return reinterpret_cast<T*>(mem);
    }

    template<typename T, size_t MAX_ELEMENTS>
    inline void static_pool_allocator<T, MAX_ELEMENTS>::deallocate(T* p, std::size_t n)
    {
        (void) n;
        spin_lock l(static_data.pool_lock);

        const size_t slot = (reinterpret_cast<unsigned char*>(p) - reinterpret_cast<unsigned char*>(static_data.pool)) / sizeof(T);
        *static_data.free_slots_end = slot;
        ++static_data.free_slots_end;
    }

    template<typename T, size_t MAX_ELEMENTS>
    inline bool static_pool_allocator<T, MAX_ELEMENTS>::_have_free() noexcept
    {
        if (static_data.free_slots_end == static_data.free_slots.begin())
            return false;
        return true;
    }

    template<typename T, size_t MAX_ELEMENTS>
    inline bool static_pool_allocator<T, MAX_ELEMENTS>::is_mine(T* p)
    {
        if (reinterpret_cast<char*>(p) < reinterpret_cast<char*>(static_data.pool) || reinterpret_cast<char*>(p) > reinterpret_cast<char*>(static_data.pool) + sizeof(static_data.pool))
            return false;
        return true;
    }


    template<typename T, size_t MAX_ELEMENTS>
    typename static_pool_allocator<T, MAX_ELEMENTS>::static_data_t static_pool_allocator<T, MAX_ELEMENTS>::static_data{};

    /** @} */ // endgroup utils

} // namespace bnb
