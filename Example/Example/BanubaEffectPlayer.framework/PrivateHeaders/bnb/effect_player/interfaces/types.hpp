#pragma once

#include <bnb/effect_player/interfaces/all.hpp>
#include <memory>

namespace bnb::interfaces
{
    using analytics_listener_sptr = std::shared_ptr<analytics_listener>;
    using analytics_listener_wptr = std::weak_ptr<analytics_listener>;
    using analytics_listener_uptr = std::unique_ptr<analytics_listener>;
    using analytics_listener_ptr = bnb::interfaces::analytics_listener*;

    using camera_poi_listener_sptr = std::shared_ptr<camera_poi_listener>;
    using camera_poi_listener_wptr = std::weak_ptr<camera_poi_listener>;
    using camera_poi_listener_uptr = std::unique_ptr<camera_poi_listener>;
    using camera_poi_listener_ptr = bnb::interfaces::camera_poi_listener*;

    using debug_interface_sptr = std::shared_ptr<debug_interface>;
    using debug_interface_wptr = std::weak_ptr<debug_interface>;
    using debug_interface_uptr = std::unique_ptr<debug_interface>;
    using debug_interface_ptr = bnb::interfaces::debug_interface*;

    using effect_sptr = std::shared_ptr<effect>;
    using effect_wptr = std::weak_ptr<effect>;
    using effect_uptr = std::unique_ptr<effect>;
    using effect_ptr = bnb::interfaces::effect*;

    using effect_event_listener_sptr = std::shared_ptr<effect_event_listener>;
    using effect_event_listener_wptr = std::weak_ptr<effect_event_listener>;
    using effect_event_listener_uptr = std::unique_ptr<effect_event_listener>;
    using effect_event_listener_ptr = bnb::interfaces::effect_event_listener*;

    using effect_manager_sptr = std::shared_ptr<effect_manager>;
    using effect_manager_wptr = std::weak_ptr<effect_manager>;
    using effect_manager_uptr = std::unique_ptr<effect_manager>;
    using effect_manager_ptr = bnb::interfaces::effect_manager*;

    using effect_player_sptr = std::shared_ptr<effect_player>;
    using effect_player_wptr = std::weak_ptr<effect_player>;
    using effect_player_uptr = std::unique_ptr<effect_player>;
    using effect_player_ptr = bnb::interfaces::effect_player*;

    using error_listener_sptr = std::shared_ptr<error_listener>;
    using error_listener_wptr = std::weak_ptr<error_listener>;
    using error_listener_uptr = std::unique_ptr<error_listener>;
    using error_listener_ptr = bnb::interfaces::error_listener*;

    using face_number_listener_sptr = std::shared_ptr<face_number_listener>;
    using face_number_listener_wptr = std::weak_ptr<face_number_listener>;
    using face_number_listener_uptr = std::unique_ptr<face_number_listener>;
    using face_number_listener_ptr = bnb::interfaces::face_number_listener*;

    using frame_duration_listener_sptr = std::shared_ptr<frame_duration_listener>;
    using frame_duration_listener_wptr = std::weak_ptr<frame_duration_listener>;
    using frame_duration_listener_uptr = std::unique_ptr<frame_duration_listener>;
    using frame_duration_listener_ptr = bnb::interfaces::frame_duration_listener*;

    using hint_listener_sptr = std::shared_ptr<hint_listener>;
    using hint_listener_wptr = std::weak_ptr<hint_listener>;
    using hint_listener_uptr = std::unique_ptr<hint_listener>;
    using hint_listener_ptr = bnb::interfaces::hint_listener*;

    using input_manager_sptr = std::shared_ptr<input_manager>;
    using input_manager_wptr = std::weak_ptr<input_manager>;
    using input_manager_uptr = std::unique_ptr<input_manager>;
    using input_manager_ptr = bnb::interfaces::input_manager*;

    using low_light_listener_sptr = std::shared_ptr<low_light_listener>;
    using low_light_listener_wptr = std::weak_ptr<low_light_listener>;
    using low_light_listener_uptr = std::unique_ptr<low_light_listener>;
    using low_light_listener_ptr = bnb::interfaces::low_light_listener*;

    using push_frame_mocker_sptr = std::shared_ptr<push_frame_mocker>;
    using push_frame_mocker_wptr = std::weak_ptr<push_frame_mocker>;
    using push_frame_mocker_uptr = std::unique_ptr<push_frame_mocker>;
    using push_frame_mocker_ptr = bnb::interfaces::push_frame_mocker*;

}
