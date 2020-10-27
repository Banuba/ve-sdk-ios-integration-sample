#pragma once

#include <atomic>

namespace bnb
{
    /**
     * @addtogroup utils
     * @{
     */

    class spin_lock
    {
    public:
        explicit spin_lock(std::atomic_flag& f)
            : flag(f)
        {
            while (flag.test_and_set(std::memory_order_acquire))
                ;
        }

        ~spin_lock()
        {
            flag.clear(std::memory_order_release);
        }

    private:
        std::atomic_flag& flag;
    };

    class spin_mutex
    {
    public:
        void lock()
        {
            while (flag.test_and_set(std::memory_order_acquire))
                ;
        }
        void unlock()
        {
            flag.clear(std::memory_order_release);
        }
        bool try_lock()
        {
            return !(flag.test_and_set(std::memory_order_acquire));
        }

    private:
        std::atomic_flag flag;
    };

    /** @} */ // endgroup utils
} // namespace bnb