#pragma once

#include <bnb/utils/interfaces/all.hpp>
#include <memory>

namespace bnb::interfaces
{
    using log_record_callback_sptr = std::shared_ptr<log_record_callback>;
    using log_record_callback_wptr = std::weak_ptr<log_record_callback>;
    using log_record_callback_uptr = std::unique_ptr<log_record_callback>;
    using log_record_callback_ptr = bnb::interfaces::log_record_callback*;

    using utility_manager_sptr = std::shared_ptr<utility_manager>;
    using utility_manager_wptr = std::weak_ptr<utility_manager>;
    using utility_manager_uptr = std::unique_ptr<utility_manager>;
    using utility_manager_ptr = bnb::interfaces::utility_manager*;

}
