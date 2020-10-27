#pragma once

#include <bnb/renderer/interfaces/all.hpp>
#include <memory>

namespace bnb::interfaces
{
    using debug_renderer_sptr = std::shared_ptr<debug_renderer>;
    using debug_renderer_wptr = std::weak_ptr<debug_renderer>;
    using debug_renderer_uptr = std::unique_ptr<debug_renderer>;
    using debug_renderer_ptr = bnb::interfaces::debug_renderer*;

}
