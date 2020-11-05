#pragma once

#include <bnb/types/interfaces/all.hpp>
#include <memory>

namespace bnb::interfaces
{
    using face_data_sptr = std::shared_ptr<face_data>;
    using face_data_wptr = std::weak_ptr<face_data>;
    using face_data_uptr = std::unique_ptr<face_data>;
    using face_data_ptr = bnb::interfaces::face_data*;

    using frame_data_sptr = std::shared_ptr<frame_data>;
    using frame_data_wptr = std::weak_ptr<frame_data>;
    using frame_data_uptr = std::unique_ptr<frame_data>;
    using frame_data_ptr = bnb::interfaces::frame_data*;

    using frx_recognition_result_sptr = std::shared_ptr<frx_recognition_result>;
    using frx_recognition_result_wptr = std::weak_ptr<frx_recognition_result>;
    using frx_recognition_result_uptr = std::unique_ptr<frx_recognition_result>;
    using frx_recognition_result_ptr = bnb::interfaces::frx_recognition_result*;

    using transformation_sptr = std::shared_ptr<transformation>;
    using transformation_wptr = std::weak_ptr<transformation>;
    using transformation_uptr = std::unique_ptr<transformation>;
    using transformation_ptr = bnb::interfaces::transformation*;

}
