#pragma once

#include <bnb/postprocess/interfaces/all.hpp>
#include <memory>

namespace bnb::interfaces
{
    using postprocess_helper_sptr = std::shared_ptr<postprocess_helper>;
    using postprocess_helper_wptr = std::weak_ptr<postprocess_helper>;
    using postprocess_helper_uptr = std::unique_ptr<postprocess_helper>;
    using postprocess_helper_ptr = bnb::interfaces::postprocess_helper*;

    using postprocess_lut_texture_sptr = std::shared_ptr<postprocess_lut_texture>;
    using postprocess_lut_texture_wptr = std::weak_ptr<postprocess_lut_texture>;
    using postprocess_lut_texture_uptr = std::unique_ptr<postprocess_lut_texture>;
    using postprocess_lut_texture_ptr = bnb::interfaces::postprocess_lut_texture*;

    using postprocess_stage_sptr = std::shared_ptr<postprocess_stage>;
    using postprocess_stage_wptr = std::weak_ptr<postprocess_stage>;
    using postprocess_stage_uptr = std::unique_ptr<postprocess_stage>;
    using postprocess_stage_ptr = bnb::interfaces::postprocess_stage*;

    using postprocess_stage_framebuffer_applier_sptr = std::shared_ptr<postprocess_stage_framebuffer_applier>;
    using postprocess_stage_framebuffer_applier_wptr = std::weak_ptr<postprocess_stage_framebuffer_applier>;
    using postprocess_stage_framebuffer_applier_uptr = std::unique_ptr<postprocess_stage_framebuffer_applier>;
    using postprocess_stage_framebuffer_applier_ptr = bnb::interfaces::postprocess_stage_framebuffer_applier*;

    using postprocess_stage_texture_applier_sptr = std::shared_ptr<postprocess_stage_texture_applier>;
    using postprocess_stage_texture_applier_wptr = std::weak_ptr<postprocess_stage_texture_applier>;
    using postprocess_stage_texture_applier_uptr = std::unique_ptr<postprocess_stage_texture_applier>;
    using postprocess_stage_texture_applier_ptr = bnb::interfaces::postprocess_stage_texture_applier*;

}
