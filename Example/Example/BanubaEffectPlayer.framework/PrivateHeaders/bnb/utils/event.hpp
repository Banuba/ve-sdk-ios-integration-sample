#pragma once

#include <memory>

#include <bnb/utils/class_unique_id.hpp>
#include <bnb/utils/static_pool_allocator.hpp>
#include <bnb/utils/allocate_unique.hpp>
#include <bnb/utils/defs.hpp>

#include <chrono>
#include <functional>

namespace bnb
{
    /**
     * @addtogroup utils
     * @{
     */

    using event_id_t = size_t;
    using handler_id_t = size_t;

    struct subscription_request_t
    {
        event_id_t event_id;
        bool is_required = false;

        subscription_request_t(event_id_t a_id)
            : event_id(a_id)
        {
        }
        subscription_request_t(event_id_t a_id, bool is_req)
            : event_id(a_id)
            , is_required(is_req)
        {
        }
    };


    class base_event_iface
    {
    public:
        virtual ~base_event_iface() = default;
        virtual event_id_t get_type_id() const noexcept = 0;
    };

    template<typename Event, size_t MaxElements = 3 * 2>
    // align to common cacheline(16) to prevent false sharing
    class BNB_ALIGNAS(16) base_event : public base_event_iface,
                                       public identified_class<event_id_t, Event>
    {
    public:
        event_id_t get_type_id() const noexcept final
        {
            return identified_class<event_id_t, Event>::get_id();
        }

        using allocator = static_pool_allocator_fallback<Event, MaxElements>;
    };


    template<typename Event>
    class time_stamped_event : public base_event<Event>
    {
    public:
        using time_stamp_t = std::chrono::time_point<std::chrono::high_resolution_clock>;
        time_stamped_event()
            : time_stamp(std::chrono::high_resolution_clock::now())
        {
        }
        const time_stamp_t time_stamp;
    };

    template<typename T, int Count>
    class simple_event : public base_event<simple_event<T, Count>>
    {
    public:
        template<typename... Args>
        explicit simple_event(Args&&... args)
            : value(args...)
        {
        }

        T value;
    };

    using base_event_ptr = std::shared_ptr<const base_event_iface>;
    using base_event_deleter = std::function<void(const bnb::base_event_iface*)>;

    template<typename T>
    using event_uptr = std::unique_ptr<T, base_event_deleter>;

    using base_event_uptr = event_uptr<const base_event_iface>;


    template<typename T, typename... Args>
    inline std::unique_ptr<T, base_event_deleter> make_unique_event(Args&&... args)
    {
        return allocate_unique<T, typename T::allocator, base_event_deleter, Args&&...>(
            typename T::allocator(),
            std::forward<Args>(args)...);
    }
    /** @} */ // endgroup utils
} // namespace bnb
