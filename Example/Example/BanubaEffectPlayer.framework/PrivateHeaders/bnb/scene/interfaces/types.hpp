#pragma once

#include <bnb/scene/interfaces/all.hpp>
#include <memory>

namespace bnb::interfaces
{
    using asset_manager_sptr = std::shared_ptr<asset_manager>;
    using asset_manager_wptr = std::weak_ptr<asset_manager>;
    using asset_manager_uptr = std::unique_ptr<asset_manager>;
    using asset_manager_ptr = bnb::interfaces::asset_manager*;

    using attachment_sptr = std::shared_ptr<attachment>;
    using attachment_wptr = std::weak_ptr<attachment>;
    using attachment_uptr = std::unique_ptr<attachment>;
    using attachment_ptr = bnb::interfaces::attachment*;

    using camera_sptr = std::shared_ptr<camera>;
    using camera_wptr = std::weak_ptr<camera>;
    using camera_uptr = std::unique_ptr<camera>;
    using camera_ptr = bnb::interfaces::camera*;

    using component_sptr = std::shared_ptr<component>;
    using component_wptr = std::weak_ptr<component>;
    using component_uptr = std::unique_ptr<component>;
    using component_ptr = bnb::interfaces::component*;

    using cubemap_sptr = std::shared_ptr<cubemap>;
    using cubemap_wptr = std::weak_ptr<cubemap>;
    using cubemap_uptr = std::unique_ptr<cubemap>;
    using cubemap_ptr = bnb::interfaces::cubemap*;

    using entity_sptr = std::shared_ptr<entity>;
    using entity_wptr = std::weak_ptr<entity>;
    using entity_uptr = std::unique_ptr<entity>;
    using entity_ptr = bnb::interfaces::entity*;

    using face_morphing_sptr = std::shared_ptr<face_morphing>;
    using face_morphing_wptr = std::weak_ptr<face_morphing>;
    using face_morphing_uptr = std::unique_ptr<face_morphing>;
    using face_morphing_ptr = bnb::interfaces::face_morphing*;

    using face_tracker_sptr = std::shared_ptr<face_tracker>;
    using face_tracker_wptr = std::weak_ptr<face_tracker>;
    using face_tracker_uptr = std::unique_ptr<face_tracker>;
    using face_tracker_ptr = bnb::interfaces::face_tracker*;

    using image_sptr = std::shared_ptr<image>;
    using image_wptr = std::weak_ptr<image>;
    using image_uptr = std::unique_ptr<image>;
    using image_ptr = bnb::interfaces::image*;

    using layer_sptr = std::shared_ptr<layer>;
    using layer_wptr = std::weak_ptr<layer>;
    using layer_uptr = std::unique_ptr<layer>;
    using layer_ptr = bnb::interfaces::layer*;

    using material_sptr = std::shared_ptr<material>;
    using material_wptr = std::weak_ptr<material>;
    using material_uptr = std::unique_ptr<material>;
    using material_ptr = bnb::interfaces::material*;

    using mesh_sptr = std::shared_ptr<mesh>;
    using mesh_wptr = std::weak_ptr<mesh>;
    using mesh_uptr = std::unique_ptr<mesh>;
    using mesh_ptr = bnb::interfaces::mesh*;

    using mesh_instance_sptr = std::shared_ptr<mesh_instance>;
    using mesh_instance_wptr = std::weak_ptr<mesh_instance>;
    using mesh_instance_uptr = std::unique_ptr<mesh_instance>;
    using mesh_instance_ptr = bnb::interfaces::mesh_instance*;

    using parameter_sptr = std::shared_ptr<parameter>;
    using parameter_wptr = std::weak_ptr<parameter>;
    using parameter_uptr = std::unique_ptr<parameter>;
    using parameter_ptr = bnb::interfaces::parameter*;

    using render_list_sptr = std::shared_ptr<render_list>;
    using render_list_wptr = std::weak_ptr<render_list>;
    using render_list_uptr = std::unique_ptr<render_list>;
    using render_list_ptr = bnb::interfaces::render_list*;

    using render_target_sptr = std::shared_ptr<render_target>;
    using render_target_wptr = std::weak_ptr<render_target>;
    using render_target_uptr = std::unique_ptr<render_target>;
    using render_target_ptr = bnb::interfaces::render_target*;

    using scene_sptr = std::shared_ptr<scene>;
    using scene_wptr = std::weak_ptr<scene>;
    using scene_uptr = std::unique_ptr<scene>;
    using scene_ptr = bnb::interfaces::scene*;

    using scene_builder_sptr = std::shared_ptr<scene_builder>;
    using scene_builder_wptr = std::weak_ptr<scene_builder>;
    using scene_builder_uptr = std::unique_ptr<scene_builder>;
    using scene_builder_ptr = bnb::interfaces::scene_builder*;

    using segmentation_mask_sptr = std::shared_ptr<segmentation_mask>;
    using segmentation_mask_wptr = std::weak_ptr<segmentation_mask>;
    using segmentation_mask_uptr = std::unique_ptr<segmentation_mask>;
    using segmentation_mask_ptr = bnb::interfaces::segmentation_mask*;

    using texture_sptr = std::shared_ptr<texture>;
    using texture_wptr = std::weak_ptr<texture>;
    using texture_uptr = std::unique_ptr<texture>;
    using texture_ptr = bnb::interfaces::texture*;

    using transformation_3d_sptr = std::shared_ptr<transformation_3d>;
    using transformation_3d_wptr = std::weak_ptr<transformation_3d>;
    using transformation_3d_uptr = std::unique_ptr<transformation_3d>;
    using transformation_3d_ptr = bnb::interfaces::transformation_3d*;

    using video_sptr = std::shared_ptr<video>;
    using video_wptr = std::weak_ptr<video>;
    using video_uptr = std::unique_ptr<video>;
    using video_ptr = bnb::interfaces::video*;

    using weighted_lut_sptr = std::shared_ptr<weighted_lut>;
    using weighted_lut_wptr = std::weak_ptr<weighted_lut>;
    using weighted_lut_uptr = std::unique_ptr<weighted_lut>;
    using weighted_lut_ptr = bnb::interfaces::weighted_lut*;

}
