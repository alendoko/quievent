; HEADER_BLOCK_START
; BambuStudio 02.07.01.62
; model printing time: 2m 49s; total estimated time: 9m 51s
; total layer number: 5
; total filament length [mm] : 197.28
; total filament volume [cm^3] : 474.52
; total filament weight [g] : 0.60
; filament_density: 1.27
; filament_diameter: 1.75
; max_z_height: 1.00
; filament: 1
; HEADER_BLOCK_END

; CONFIG_BLOCK_START
; accel_to_decel_enable = 0
; accel_to_decel_factor = 50%
; activate_air_filtration = 0
; additional_cooling_fan_speed = 0
; additional_fan_full_speed_layer = 0
; alternate_extra_wall = 0
; apply_scarf_seam_on_circles = 1
; auxiliary_fan = 1
; avoid_crossing_wall_includes_support = 0
; bed_custom_model = 
; bed_custom_texture = 
; bed_exclude_area = 
; bed_temperature_formula = by_first_filament
; before_layer_change_gcode = 
; best_object_pos = 0.5,0.5
; bottom_color_penetration_layers = 3
; bottom_shell_layers = 3
; bottom_shell_thickness = 0
; bottom_surface_density = 100%
; bottom_surface_pattern = monotonic
; bridge_angle = 0
; bridge_flow = 1
; bridge_no_support = 0
; bridge_speed = 50
; brim_object_gap = 0.1
; brim_type = auto_brim
; brim_width = 5
; chamber_temperatures = 0
; change_filament_gcode = ;======== P2S filament_change gcode ==========\n;===== 2026/05/15 =====\n\nM620 S[next_filament_id]A\nM204 S9000\n{if toolchange_count > 1 && (z_hop_types[current_filament_id] == 0 || z_hop_types[current_filament_id] == 3)}\nG17\nG2 Z{z_after_toolchange + 0.4} I0.86 J0.86 P1 F10000 ; spiral lift a little from second lift\n{endif}\n\n;nozzle_change_gcode\n\nG1 Z{max_layer_z + 3.0} F1200\n\nM400\nM106 P1 S0\n\n{if toolchange_count == 2}\n; get travel path for change filament\n;M620.1 X[travel_point_1_x] Y[travel_point_1_y] F21000 P0\n;M620.1 X[travel_point_2_x] Y[travel_point_2_y] F21000 P1\n;M620.1 X[travel_point_3_x] Y[travel_point_3_y] F21000 P2\n{endif}\n\n{if ((filament_type[current_filament_id] == \"PLA\") || (filament_type[current_filament_id] == \"PLA-CF\") || (filament_type[current_filament_id] == \"PETG\")) && (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\nM620.10 A0 F74.8347 L[flush_length] H{nozzle_diameter_at_nozzle_id[current_nozzle_id]} T{flush_temperatures[current_filament_id]} P[old_filament_temp] S1\n{else}\nM620.10 A0 F{flush_volumetric_speeds[current_filament_id]/2.4053*60} L[flush_length] H{nozzle_diameter_at_nozzle_id[current_nozzle_id]} T{flush_temperatures[current_filament_id]} P[old_filament_temp] S1\n{endif}\n\n{if ((filament_type[next_filament_id] == \"PLA\") || (filament_type[next_filament_id] == \"PLA-CF\") || (filament_type[next_filament_id] == \"PETG\")) && (nozzle_diameter_at_nozzle_id[next_nozzle_id] == 0.2)}\nM620.10 A1 F74.8347 L[flush_length] H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} T{flush_temperatures[next_filament_id]} P[new_filament_temp] S1\n{else}\nM620.10 A1 F{flush_volumetric_speeds[next_filament_id]/2.4053*60} L[flush_length] H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} T{flush_temperatures[next_filament_id]} P[new_filament_temp] S1\n{endif}\n\nM620.15 C{new_filament_temp - filament_cooling_before_tower[next_filament_id]}\n\n{if long_retraction_when_cut}\nM620.11 P1 L0 I[current_filament_id] E-{retraction_distance_when_cut} F{max((flush_volumetric_speeds[current_filament_id]/2.4053*60), 200)}\n{else}\nM620.11 P0 L0 I[current_filament_id] E0\n{endif}\n\nM620.11 K0 I[current_filament_id] R0\n\n\nT[next_filament_id]\n\n;deretract\n{if filament_type[next_filament_id] == \"TPU\"}\n{else}\n{if filament_type[next_filament_id] == \"PA\"}\n;VG1 E1 F{max(new_filament_e_feedrate, 200)}\n;VG1 E1 F{max(new_filament_e_feedrate/2, 100)}\n{else}\n;VG1 E4 F{max(new_filament_e_feedrate, 200)}\n;VG1 E4 F{max(new_filament_e_feedrate/2, 100)}\n{endif}\n{endif}\n\n; VFLUSH_START\n{if flush_length>41.5}\n;VG1 E41.5 F{min(old_filament_e_feedrate,new_filament_e_feedrate)}\n;VG1 E{flush_length-41.5} F{new_filament_e_feedrate}\n{else}\n;VG1 E{flush_length} F{min(old_filament_e_feedrate,new_filament_e_feedrate)}\n{endif}\nSYNC T{ceil(flush_length / 80) * 5}\n; VFLUSH_END\n\nM1002 set_filament_type:{filament_type[next_filament_id]}\n\nM400\nM83\n{if next_filament_id < 255}\nM620.10 R{retract_length_toolchange[filament_map[next_filament_id]-1]}\nM628 S0\n;VM109 S[new_filament_temp]\n\nM629\nM400\nM983.3 F{filament_max_volumetric_speed[next_filament_id]/2.4} A0.4 R{retract_length_toolchange[filament_map[next_filament_id]-1]}\nM400\nG1 Y247 F30000\nG1 Y217 F18000\n\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[travel_acceleration]\n{endif}\n\n{else}\nG1 X[x_after_toolchange] Y[y_after_toolchange] Z[z_after_toolchange] F12000\n{endif}\n\nM621 S[next_filament_id]A\n\nM622.1 S0 ;for prev version, default skip\nM1002 judge_flag powerloss_resume_flag\nM622 J1\nM983.3 F{filament_max_volumetric_speed[next_filament_id]/2.4} A0.4 R{retract_length_toolchange[filament_map[next_filament_id]-1]}\nM400\nG1 Y247 F30000\nG1 Y217 F18000\nG1 Z{max_layer_z + 3.0} F3000\n{if layer_z <= (initial_layer_print_height + 0.001)}\nM204 S[initial_layer_acceleration]\n{else}\nM204 S[travel_acceleration]\n{endif}\nM1002 set_flag powerloss_resume_flag=0\nM623\n\n{if (filament_type[next_filament_id] == \"PLA\") ||  (filament_type[next_filament_id] == \"PETG\")\n ||  (filament_type[next_filament_id] == \"PLA-CF\")  ||  (filament_type[next_filament_id] == \"PETG-CF\")}\nM1015.4 S1 K1 H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} ;enable E air printing detect\n{else}\nM1015.4 S0 K0 H{nozzle_diameter_at_nozzle_id[next_nozzle_id]} ;disable E air printing detect\n{endif}\n\nM620.6 I[next_filament_id] W1 ;enable ams air printing detect\n\nG1 Y256 F18000\n\n{if (overall_chamber_temperature < 40)}\n{if (layer_num + 1 <= close_additional_fan_first_x_layers[next_filament_id])}\n    {if (min_vitrification_temperature <= 50)}\n        M106 P2 S{first_x_layer_fan_speed[next_filament_id]*255.0/100.0 };set first x_layer aux fan\n    {endif}\n{elsif (layer_num + 1 < additional_fan_full_speed_layer[next_filament_id] && additional_fan_full_speed_layer[next_filament_id] > close_additional_fan_first_x_layers[next_filament_id])}\n    {if (min_vitrification_temperature <= 50)}\n        M106 P2 S{(first_x_layer_fan_speed[next_filament_id] + (additional_cooling_fan_speed[next_filament_id] - first_x_layer_fan_speed[next_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[next_filament_id]) / max(additional_fan_full_speed_layer[next_filament_id] - close_additional_fan_first_x_layers[next_filament_id], 1)) * 255.0/100.0}\n    {endif}\n{else}\n    {if (min_vitrification_temperature <= 50)}\n        {if (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.2 chamber autocooling\n        {else}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.4 chamber autocooling\n        {endif}\n    {endif}\n{endif}\n{endif}\n\nM622.1 S0\nM1002 judge_flag ventobox_replace_aux1_fan_flag\nM622 J0\n{if (layer_num + 1 <= close_additional_fan_first_x_layers[next_filament_id])}\n    M106 P10 S{first_x_layer_fan_speed[next_filament_id]*255.0/100.0 };set first x_layer left aux fan\n{elsif (layer_num + 1 < additional_fan_full_speed_layer[next_filament_id] && additional_fan_full_speed_layer[next_filament_id] > close_additional_fan_first_x_layers[next_filament_id])}\n    M106 P10 S{(first_x_layer_fan_speed[next_filament_id] + (additional_cooling_fan_speed[next_filament_id] - first_x_layer_fan_speed[next_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[next_filament_id]) / max(additional_fan_full_speed_layer[next_filament_id] - close_additional_fan_first_x_layers[next_filament_id], 1)) * 255.0/100.0}\n{else}\n    M106 P10 S{additional_cooling_fan_speed[next_filament_id]*255.0/100.0};set left aux fan\n{endif}\nM623\n\n;not set fan changing filament
; circle_compensation_manual_offset = 0
; circle_compensation_speed = 200
; close_additional_fan_first_x_layers = 3
; close_fan_the_first_x_layers = 3
; complete_print_exhaust_fan_speed = 70
; cool_plate_temp = 0
; cool_plate_temp_initial_layer = 0
; cooling_filter_enabled = 0
; cooling_perimeter_transition_distance = 10
; cooling_slowdown_logic = uniform_cooling
; counter_coef_1 = 0
; counter_coef_2 = 0.008
; counter_coef_3 = -0.041
; counter_limit_max = 0.033
; counter_limit_min = -0.035
; curr_bed_type = Textured PEI Plate
; default_acceleration = 10000
; default_filament_colour = ""
; default_filament_profile = "Bambu PLA Basic @BBL P2S"
; default_jerk = 0
; default_nozzle_volume_type = Standard
; default_print_profile = 0.20mm Standard @BBL P2S
; deretraction_speed = 30
; detect_floating_vertical_shell = 1
; detect_narrow_internal_solid_infill = 1
; detect_overhang_wall = 1
; detect_thin_wall = 0
; diameter_limit = 50
; draft_shield = disabled
; during_print_exhaust_fan_speed = 70
; elefant_foot_compensation = 0.15
; embedding_wall_into_infill = 0
; enable_arc_fitting = 1
; enable_circle_compensation = 0
; enable_filament_dynamic_map = 0
; enable_height_slowdown = 0
; enable_long_retraction_when_cut = 2
; enable_mixed_color_sublayer = 0
; enable_order_independent_overlap_carving = 0
; enable_overhang_bridge_fan = 1
; enable_overhang_speed = 1
; enable_pre_heating = 0
; enable_pressure_advance = 0
; enable_prime_tower = 0
; enable_support = 0
; enable_support_ironing = 0
; enable_tower_interface_features = 0
; enable_wrapping_detection = 0
; enforce_support_layers = 0
; eng_plate_temp = 70
; eng_plate_temp_initial_layer = 70
; ensure_vertical_shell_thickness = enabled
; exclude_object = 1
; extruder_ams_count = 1#0|4#0;1#0|4#0
; extruder_clearance_dist_to_rod = 36.5
; extruder_clearance_height_to_lid = 141.5
; extruder_clearance_height_to_rod = 32.5
; extruder_clearance_max_radius = 72
; extruder_colour = #018001
; extruder_max_nozzle_count = 1
; extruder_nozzle_stats = Standard#1
; extruder_offset = 0x0
; extruder_printable_area = 
; extruder_type = Direct Drive
; extruder_variant_list = "Direct Drive Standard,Direct Drive High Flow"
; fan_cooling_layer_time = 30
; fan_direction = right
; fan_max_speed = 90
; fan_min_speed = 40
; filament_adaptive_volumetric_speed = 0
; filament_adhesiveness_category = 300
; filament_bridge_speed = 25
; filament_change_length = 10
; filament_change_length_nc = 10
; filament_colour = #161616
; filament_colour_type = 2
; filament_cooling_before_tower = 10
; filament_cost = 30
; filament_density = 1.27
; filament_dev_ams_drying_ams_limitations = 1;0
; filament_dev_ams_drying_heat_distortion_temperature = 75
; filament_dev_ams_drying_temperature = 65,65,55,55
; filament_dev_ams_drying_time = 12,12,12,12
; filament_dev_chamber_drying_bed_temperature = 80
; filament_dev_chamber_drying_time = 12
; filament_dev_drying_cooling_temperature = 55
; filament_dev_drying_softening_temperature = 60
; filament_diameter = 1.75
; filament_enable_overhang_speed = 1
; filament_end_gcode = "; filament end gcode \n\n"
; filament_extruder_compatibility = 0
; filament_extruder_variant = "Direct Drive Standard"
; filament_flow_ratio = 0.95
; filament_flush_temp = 0
; filament_flush_temp_fast = 0
; filament_flush_volumetric_speed = 0
; filament_ids = GFG99
; filament_is_mixed = 0
; filament_is_support = 0
; filament_map = 1
; filament_map_2 = 0
; filament_map_mode = Auto For Flush
; filament_max_volumetric_speed = 12
; filament_metal_stickiness = High
; filament_minimal_purge_on_wipe_tower = 15
; filament_mixed_components = ""
; filament_mixed_gradient = 0
; filament_mixed_gradient_curve = ""
; filament_mixed_gradient_per_part = 0
; filament_mixed_gradient_range = ""
; filament_mixed_sublayer_ratios = ""
; filament_multi_colour = #161616
; filament_notes = 
; filament_nozzle_map = 0
; filament_overhang_1_4_speed = 0
; filament_overhang_2_4_speed = 50
; filament_overhang_3_4_speed = 30
; filament_overhang_4_4_speed = 10
; filament_overhang_totally_speed = 10
; filament_pre_cooling_temperature = 0
; filament_pre_cooling_temperature_nc = 0
; filament_preheat_temperature_delta = 10
; filament_prime_volume = 45
; filament_prime_volume_nc = 60
; filament_printable = 3
; filament_ramming_travel_time = 0
; filament_ramming_travel_time_nc = 0
; filament_ramming_volumetric_speed = -1
; filament_ramming_volumetric_speed_nc = -1
; filament_retract_length_nc = 14
; filament_scarf_gap = 0%
; filament_scarf_height = 10%
; filament_scarf_length = 10
; filament_scarf_seam_type = none
; filament_self_index = 1
; filament_settings_id = "Generic PETG @BBL P2S"
; filament_shrink = 100%
; filament_soluble = 0
; filament_start_gcode = "; filament start gcode\n"
; filament_tower_interface_pre_extrusion_dist = 10
; filament_tower_interface_pre_extrusion_length = 0
; filament_tower_interface_print_temp = -1
; filament_tower_interface_purge_volume = 20
; filament_tower_ironing_area = 4
; filament_type = PETG
; filament_velocity_adaptation_factor = 1
; filament_vendor = Generic
; filament_volume_map = 0
; filename_format = {input_filename_base}_{filament_type[0]}_{print_time}.gcode
; fill_multiline = 1
; filter_out_gap_fill = 0
; first_layer_print_sequence = 0
; first_x_layer_fan_speed = 0
; first_x_layer_part_fan_speed = 0
; flush_into_infill = 0
; flush_into_objects = 0
; flush_into_support = 1
; flush_multiplier = 1
; flush_multiplier_fast = 1.2
; flush_volumes_matrix = 0
; flush_volumes_vector = 140,140
; full_fan_speed_layer = 0
; fuzzy_skin = none
; fuzzy_skin_first_layer = 0
; fuzzy_skin_mode = displacement
; fuzzy_skin_noise_type = classic
; fuzzy_skin_octaves = 4
; fuzzy_skin_persistence = 0.5
; fuzzy_skin_point_distance = 0.8
; fuzzy_skin_scale = 1
; fuzzy_skin_thickness = 0.3
; gap_infill_speed = 250
; gcode_add_line_number = 0
; gcode_flavor = marlin
; grab_length = 0
; group_algo_with_time = 0
; has_filament_switcher = 0
; has_scarf_joint_seam = 0
; head_wrap_detect_zone = 
; hole_coef_1 = 0
; hole_coef_2 = -0.008
; hole_coef_3 = 0.23415
; hole_limit_max = 0.22
; hole_limit_min = 0.088
; host_type = octoprint
; hot_plate_temp = 70
; hot_plate_temp_initial_layer = 70
; hotend_cooling_rate = 2
; hotend_heating_rate = 2
; impact_strength_z = 10
; independent_support_layer_height = 1
; infill_combination = 0
; infill_direction = 45
; infill_instead_top_bottom_surfaces = 0
; infill_jerk = 9
; infill_lock_depth = 1
; infill_rotate_step = 0
; infill_shift_step = 0.4
; infill_wall_overlap = 15%
; initial_layer_acceleration = 500
; initial_layer_flow_ratio = 1
; initial_layer_infill_speed = 105
; initial_layer_jerk = 9
; initial_layer_line_width = 0.5
; initial_layer_print_height = 0.2
; initial_layer_speed = 50
; initial_layer_travel_acceleration = 6000
; inner_wall_acceleration = 0
; inner_wall_jerk = 9
; inner_wall_line_width = 0.45
; inner_wall_speed = 300
; interface_shells = 0
; interlocking_beam = 0
; interlocking_beam_layer_count = 2
; interlocking_beam_width = 0.8
; interlocking_boundary_avoidance = 2
; interlocking_depth = 2
; interlocking_orientation = 22.5
; internal_bridge_support_thickness = 0.8
; internal_solid_infill_line_width = 0.42
; internal_solid_infill_pattern = zig-zag
; internal_solid_infill_speed = 250
; ironing_direction = 45
; ironing_fan_speed = -1
; ironing_flow = 10%
; ironing_inset = 0.21
; ironing_pattern = zig-zag
; ironing_spacing = 0.15
; ironing_speed = 30
; ironing_type = no ironing
; is_infill_first = 0
; layer_change_gcode = ;======== P2S layer_change gcode ==========\n;===== 2026/05/15 ====\n\n{if (layer_num + 1 == 1)}\n{if (overall_chamber_temperature >= 40)}\n    ;not reset filter fan in first layer\n    ;not reset fan\n{else}\n{if (min_vitrification_temperature > 50)}\n    ;not reset filter fan in first layer\n    ;not reset fan\n{endif}\n{endif}\n{endif}\n\n{if (layer_num + 1 <= close_additional_fan_first_x_layers[current_filament_id])}\n{if (overall_chamber_temperature < 40)}\n    {if (min_vitrification_temperature <= 50)}\n        M106 P2 S{first_x_layer_fan_speed[current_filament_id]*255.0/100.0}\n    {endif}\n{endif}\n    M622.1 S0\n    M1002 judge_flag ventobox_replace_aux1_fan_flag\n    M622 J0\n    M106 P10 S{first_x_layer_fan_speed[current_filament_id]*255.0/100.0}; set first x_layer left aux fan\n    M623\n;not reset fan\n{elsif (layer_num + 1 < additional_fan_full_speed_layer[current_filament_id] && additional_fan_full_speed_layer[current_filament_id] > close_additional_fan_first_x_layers[current_filament_id])}\n{if (overall_chamber_temperature < 40)}\n    {if (min_vitrification_temperature <= 50)}\n        M106 P2 S{(first_x_layer_fan_speed[current_filament_id] + (additional_cooling_fan_speed[current_filament_id] - first_x_layer_fan_speed[current_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[current_filament_id]) / max(additional_fan_full_speed_layer[current_filament_id] - close_additional_fan_first_x_layers[current_filament_id], 1)) * 255.0/100.0}\n    {endif}\n{endif}\n    M622.1 S0\n    M1002 judge_flag ventobox_replace_aux1_fan_flag\n    M622 J0\n    M106 P10 S{(first_x_layer_fan_speed[current_filament_id] + (additional_cooling_fan_speed[current_filament_id] - first_x_layer_fan_speed[current_filament_id]) * (layer_num + 1 - close_additional_fan_first_x_layers[current_filament_id]) / max(additional_fan_full_speed_layer[current_filament_id] - close_additional_fan_first_x_layers[current_filament_id], 1)) * 255.0/100.0}\n    M623\n;not reset fan\n{elsif (layer_num + 1 == max(close_additional_fan_first_x_layers[current_filament_id] + 1, additional_fan_full_speed_layer[current_filament_id]))}\n{if (overall_chamber_temperature < 40)}\n    ;updata chamber autocooling in Xth layer\n    {if (min_vitrification_temperature <= 50)}\n        {if (nozzle_diameter_at_nozzle_id[current_nozzle_id] == 0.2)}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.2 chamber autocooling\n        {else}\n            M142 P1 R30 S40 U{max_additional_fan/100.0} V1.0 O45; set PLA/TPU ND0.4 chamber autocooling\n        {endif}\n    {else}\n            ;not reset filter fan in Xth layer\n    {endif}\n{else}\n        ;not reset filter fan in Xth layer\n{endif}\n    M622.1 S0\n    M1002 judge_flag ventobox_replace_aux1_fan_flag\n    M622 J0\n    M106 P10 S{additional_cooling_fan_speed[current_filament_id]*255.0/100.0}; set left aux fan\n    M623\n;not reset fan\n{endif}\n\n; update layer progress\nM73 L{layer_num+1}\nM991 S0 P{layer_num} ;notify layer change\n\n
; layer_height = 0.2
; line_width = 0.42
; locked_skeleton_infill_pattern = zigzag
; locked_skin_infill_pattern = crosszag
; long_retractions_when_cut = 0
; long_retractions_when_ec = 0
; machine_bed_mass_Y = 0
; machine_end_gcode = ;======== P2S end gcode ==========\n;===== 2026/05/18 =====\nM400 ; wait for buffer to clear\nG92 E0 ; zero the extruder\nM211 Z1\n\nG90\nG1 Z{max_layer_z + 0.4} F900 ; lower z a little\nM1002 judge_flag timelapse_record_flag\nM622 J1\n    G150.3\n    M400 ; wait all motion done\n    M991 S0 P-1 ;end smooth timelapse at safe pos\n    M400 S5 ;wait for last picture to be taken\nM623  ;end of \"timelapse_record_flag\n\nG90\nG1 Z{max_layer_z + 10} F900 ; lower z a little\n\nM140 S0 ; turn off bed\nM106 S0 ; turn off fan\nM106 P2 S0 ; turn off remote part cooling fan\nM106 P3 S0 ; turn off chamber cooling fan\nM106 P10 S0 ; turn off left aux fan\n\n; pull back filament to AMS\nM620 S65535\nT65535\nG150.1 F8000\nM621 S65535\n\nG150.3\nM104 S0 ; turn off hotend\nM400 ; wait all motion done\nM17 S\nM17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom\n{if (80.0 - max_layer_z/2) > 0}\n    {if (max_layer_z + 80.0 - max_layer_z/2) < 256}\n        G1 Z{max_layer_z + 80.0 - max_layer_z/2} F600\n        G1 Z{max_layer_z + 78.0 - max_layer_z/2}\n    {else}\n        G1 Z256 F600\n        G1 Z256\n    {endif}\n{else}\n    {if (max_layer_z + 4.0) < 256}\n        G1 Z{max_layer_z + 4.0} F600\n        G1 Z{max_layer_z + 2.0}\n    {else}\n        G1 Z256 F600\n        G1 Z256\n    {endif}\n{endif}\nM400 P100\nM17 R ; restore z current\n\n\nM220 S100  ; Reset feedrate magnitude\nM201.2 K1.0 ; Reset acc magnitude\nM73.2 R1.0 ;Reset left time magnitude\nM1002 set_gcode_claim_speed_level : 0\n\nM1015.3 S0 ;disable clog detect\nM1015.4 S0 K0 ;disable air printing detect\n\n;=====printer finish air purification=========\nM622.1 S0\nM1002 judge_flag print_finish_air_filt_flag\n\nM622 J1\nM1002 gcode_claim_action : 66\nM145 P1\nM106 P2 S255\nM400 S180\nM106 P2 S0\nM623\n\nM622 J2\nM1002 gcode_claim_action : 66\nM145 P0\nM106 P3 S255\nM400 S180\nM106 P3 S0\nM623\n;=====printer finish air purification=========\n\n;=====printer finish  sound=========\nM17\nM400 S1\nM1006 S1\nM1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 \nM1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 \nM1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A48 B10 L50 C48 D10 M50 E48 F10 N50 \nM1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 \nM1006 A60 B10 L50 C60 D10 M50 E60 F10 N50 \nM1006 W\n;=====printer finish  sound=========\nM400\nM18\n
; machine_hotend_change_time = 0
; machine_load_filament_time = 26
; machine_max_acceleration_e = 5000,5000
; machine_max_acceleration_extruding = 20000,20000
; machine_max_acceleration_retracting = 5000,5000
; machine_max_acceleration_travel = 10000,10000
; machine_max_acceleration_x = 20000,20000
; machine_max_acceleration_y = 20000,20000
; machine_max_acceleration_z = 500,500
; machine_max_force_Y = 0
; machine_max_jerk_e = 2.5,2.5
; machine_max_jerk_x = 9,9
; machine_max_jerk_y = 9,9
; machine_max_jerk_z = 3,3
; machine_max_printed_mass = 0
; machine_max_speed_e = 30,30
; machine_max_speed_x = 600,600
; machine_max_speed_y = 600,600
; machine_max_speed_z = 20,20
; machine_min_extruding_rate = 0
; machine_min_travel_rate = 0
; machine_pause_gcode = M400 U1
; machine_prepare_compensation_time = 370
; machine_start_gcode = ;M1002 set_flag extrude_cali_flag=1\n;M1002 set_flag g29_before_print_flag=1\n;M1002 set_flag auto_cali_toolhead_offset_flag=1\n;M1002 set_flag build_plate_detect_flag=1\n\n;======== P2S start gcode==========\n;===== 2026/05/18 =====\n\n  M140 S[bed_temperature_initial_layer_single] ; heat heatbed first\n  M993 A0 B0 C0 ; nozzle cam detection not allowed.\n  M400\n\n;=====printer start sound ===================\nM17\nM400 S1\nM1006 S1\nM1006 A53 B9 L50 C53 D9 M50 E53 F9 N50\nM1006 A56 B9 L50 C56 D9 M50 E56 F9 N50\nM1006 A61 B9 L50 C61 D9 M50 E61 F9 N50\nM1006 A53 B9 L50 C53 D9 M50 E53 F9 N50\nM1006 A56 B9 L50 C56 D9 M50 E56 F9 N50\nM1006 A61 B18 L50 C61 D18 M50 E61 F18 N50\nM1006 W\n;=====printer start sound ===================\n\n  M620 M ;enable remap\n  G389\n\n;===== avoid end stop =================\n  G91\n  G380 S2 Z22 F1200\n  G380 S2 Z-12 F1200\n  G90\n;===== avoid end stop =================\n\n;===== reset machine status =================\n  M204 S10000\n  M630 S0 P1\n  G90\n  M17 D ; reset motor current to default\n  M960 S5 P1 ; turn on logo lamp\n  G90\n  M220 S100 ;Reset Feedrate\n  M1002 set_gcode_claim_speed_level: 5\n  M221 S100 ;Reset Flowrate\n  M73.2   R1.0 ;Reset left time magnitude\n  G29.1 Z{+0.0} ; clear z-trim value first\n  M983.1 M1\n  M982.2 S1 ; turn on cog noise reduction\n  M983.4 S0\n;===== reset machine status =================\n\n;==== set airduct mode ====\n;==== if Chamber Cooling is necessary ====\n{if (overall_chamber_temperature >= 40)}\nM145 P1 ; set airduct mode to heating mode for heating\nM106 P2 S255 ; turn on filter fan\nM622.1 S0\nM1002 judge_flag ventobox_replace_aux1_fan_flag\nM622 J0\nM106 P10 S0 ; turn off left aux fan\nM623\n{else}\n{if (min_vitrification_temperature <= 50)}\nM145 P0 ; set airduct mode to cooling mode for cooling\nM106 P2 S255 ; turn on auxiliary fan for cooling\nM106 P3 S127 ; turn on chamber fan for cooling\nM1002 gcode_claim_action : 29\nM191 S0 ; wait for chamber temp\nM106 P2 S102 ; turn on chamber cooling fan\nM622.1 S0\nM1002 judge_flag ventobox_replace_aux1_fan_flag\nM622 J0\nM106 P10 S0 ; turn off left aux fan\nM623\nM142 P6 R30 S40 U0.3 V0.8 ; set PETG exhaust chamber autocooling\n{else}\nM145 P1 ; set airduct mode to heating mode for heating\nM106 P2 S127 ; turn on 50% filter fan\nM142 P6 R30 S40 U0.3 V0.8 ; set PLA/TPU exhaust chamber autocooling\n{endif}\n{endif}\n;==== set airduct mode ====\n\n;===== start to heat heatbed & hotend==========\n  M1002 gcode_claim_action : 2\n  M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n  M104 S140 A\n\n  G29.2 S0 ; avoid invalid abl data\n\n;===== first homing start =====\n  M1002 gcode_claim_action : 13\n  G28 X T300\n  G150.1 F8000 ; wipe mouth to avoid filament stick to heatbed\n  G150.3\n  M972 S24 P0\n  M972 S26 P0 C0\n  M972 S42 P0 T5000\n  G150.1 F8000 ; wipe mouth to avoid filament stick to heatbed\n  G90\n  G1 X128 Y128 F30000\n  G28 Z P0 T400\n  M400\n;===== first homign end =====\n\n;===== detection start =====\n  M1002 gcode_claim_action : 11\n  M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]-80} A ; rise temp in advance\n  M972 S19 P0 T5000 ;plate type detection\n\n  {if max_print_z >= 145}\n    M1002 gcode_claim_action : 75 ;  Detect obstacles at the botton of the heated bed\n    G150.3\n    M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]} ; rise temp in advance\n    G3811 Z{max_print_z}  ; Detect obstacles at the bottom of the heated bed\n  {endif}\n;===== detection end =====\n\n;===== prepare print temperature and material ==========\n  M400\n  M211 X0 Y0 Z0 ;turn off soft endstop\n  M975 S1 ; turn on input shaping\n\n  G29.2 S0 ; avoid invalid abl data\n  G150.3\n{if ((filament_type[initial_no_support_filament_id] == \"PLA\") || (filament_type[initial_no_support_filament_id] == \"PLA-CF\") || (filament_type[initial_no_support_filament_id] == \"PETG\")) && (nozzle_diameter_at_nozzle_id[initial_nozzle_id] == 0.2)}\nM620.10 A0 F74.8347 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\nM620.10 A1 F74.8347 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\n{else}\nM620.10 A0 F{flush_volumetric_speeds[initial_no_support_filament_id]/2.4053*60} H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\nM620.10 A1 F{flush_volumetric_speeds[initial_no_support_filament_id]/2.4053*60} H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} T{flush_temperatures[initial_no_support_filament_id]} P{nozzle_temperature_initial_layer[initial_no_support_filament_id]} S1\n{endif}\n\n M620.11 P0 L0 I[initial_no_support_filament_id] E0\n M620.11 K0 I[initial_no_support_filament_id] R0\n\n  M620 S[initial_no_support_filament_id]A   ; switch material if AMS exist\n  M1002 gcode_claim_action : 4\n  M1002 set_filament_type:UNKNOWN\n  M400\n  T[initial_no_support_filament_id]\n  M400\n  M628 S0\n  M629\n  M400\n  M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n  M621 S[initial_no_support_filament_id]A\n  M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]}\n  M400\n  M106 P1 S0\n  M400\n  G29.2 S1\n;===== prepare print temperature and material ==========\n\n\n;===== auto extrude cali start =========================\n  M975 S1\n  M1002 judge_flag extrude_cali_flag\n  M622 J0\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2.4} A0.4 ; cali dynamic extrusion compensation\n  M623\n\n  M622 J1\n    M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n    M1002 gcode_claim_action : 8\n    M109 S{nozzle_temperature[initial_no_support_filament_id]}\n    G90\n    M83\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2.4} A0.4 ; cali dynamic extrusion compensation\n    M400\n    M106 P1 S255\n    M400 S5\n    M106 P1 S0\n    G150.3\n  M623\n\n  M622 J2\n    M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n    M1002 gcode_claim_action : 8\n    M109 S{nozzle_temperature[initial_no_support_filament_id]}\n    G90\n    M83\n    M983.3 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2.4} A0.4 ; cali dynamic extrusion compensation\n    M400\n    M106 P1 S255\n    M400 S5\n    M106 P1 S0\n    G150.3\n  M623\n;===== auto extrude cali end =========================\n\n  {if hold_chamber_temp_for_flat_print}\n    M1002 gcode_claim_action : 58\n    M104 S{first_layer_temperature[initial_no_support_filament_id]}\n    {if bed_temperature_initial_layer_single > 89}\n        M1030 S1800\n        SYNC R0 T1800\n    {else}\n        M1030 S300\n        SYNC R0 T300\n    {endif}\n    M1030 C\n  {endif}\n\n  {if filament_type[initial_filament_id] == \"TPU\" || filament_type[initial_filament_id] == \"PVA\"}\n  {else}\n    M83\n    G1 E-3 F1800\n    M400 P500\n  {endif}\n  G150.2\n  G150.1 F8000\n  G150.2\n  G150.1 F8000\n\n  G91\n  G1 Y-16 F12000 ; move away from the trash bin\n  G90\n  M400\n\n  M104 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]-80} A\n\n;===== wipe right nozzle start =====\n  M1002 gcode_claim_action : 14\n  G150 T{nozzle_temperature_initial_layer[initial_no_support_filament_id]}\n  M400\n\n{if filament_type[initial_filament_id] == \"PC\"}\n  M109 S170 A\n{else}\n  M109 S140 A\n{endif}\n  G91\n  G1 Z5 F1200\n  G90\n  M400\n  G150.1\n;===== wipe left nozzle end =====\n\n\n;===== mech mode sweep start =====\n  M1002 gcode_claim_action : 3\n  G90\n  G1 X128 Y128 F20000\n  G1 Z5 F1200\n  M400 P200\n  M970.3 Q1 A5 K0 O1\n  M970.2 Q1 K1 W74 Z0.01\n  M974 Q1 S2 P0\n  M970.3 Q0 A7 K0 O1\n  M970.2 Q0 K1 W74 Z0.01\n  M974 Q0 S2 P0\n  M975 S1\n  M400\n;===== mech mode sweep end =====\n\n;===== bed leveling ==================================\n  M1002 gcode_claim_action : 54\n  M190 S[bed_temperature_initial_layer_single]; ensure bed temp\n  M109 S140 A\n  M106 S0 ; turn off fan , too noisy\n  M1002 judge_flag g29_before_print_flag\n  M622 J1\n    M1002 gcode_claim_action : 1\n    {if hold_chamber_temp_for_flat_print}\n      G29 H\n    {else}\n      G29 A1 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    {endif}\n    M400\n  M623\n\n  M622 J2\n    M1002 gcode_claim_action : 1\n    {if hold_chamber_temp_for_flat_print}\n      G29 H\n    {else}\n      G29 A2 X{first_layer_print_min[0]} Y{first_layer_print_min[1]} I{first_layer_print_size[0]} J{first_layer_print_size[1]}\n    {endif}\n    M400\n  M623\n\n  M622 J0\n    G28\n  M623\n  G29.2 S1\n  G28\n;===== bed leveling end ================================\n\n  M985.1 U0 E2\n  M985.1 U1 E2\n\n  M104 S{nozzle_temperature_initial_layer[initial_filament_id]} A\n  G150.3 ; move to garbage can to wait for temp\n\n;===== wait temperature reaching the reference value =======\n  M190 S[bed_temperature_initial_layer_single]\n\n  ;========turn off light and fans =============\n  M960 S1 P0 ; turn off laser\n  M960 S2 P0 ; turn off laser\n  M106 S0 ; turn off cooling fan\n\n;===== wait temperature reaching the reference value =======\n\n  M1002 gcode_claim_action : 255\n  M400\n  M975 S1 ; turn on mech mode supression\n\n;============switch again==================\n  M211 X0 Y0 Z0 ;turn off soft endstop\n  G91\n  G1 Z6 F1200\n  G90\n  M1002 set_filament_type:{filament_type[initial_no_support_filament_id]}\n  M620 S[initial_no_support_filament_id]A\n  M400\n  T[initial_no_support_filament_id]\n  M400\n  M628 S0\n  M629\n  M400\n  M621 S[initial_no_support_filament_id]A\n;============switch again==================\n\n;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==\n  {if bed_temperature_initial_layer_single > 89}\n    {if curr_bed_type==\"Textured PEI Plate\"}\n      G29.1 Z{-0.02} ; for Textured PEI Plate\n    {else}\n      G29.1 Z{0.0}\n    {endif}\n  {else}\n    {if curr_bed_type==\"Textured PEI Plate\"}\n      G29.1 Z{0.01} ; for Textured PEI Plate\n    {else}\n      G29.1 Z{0.03}\n    {endif}\n  {endif}\n\n\n;===== nozzle load line ===============================\nM1002 gcode_claim_action : 51\n  G29.2 S1 ; ensure z comp turn on\n  G90\n  M83\n  M400 P50\n  M500 D1\n  M400 S3\n  M109 S{nozzle_temperature_initial_layer[initial_no_support_filament_id]}\n  G0 X100 Y0 F24000\n  M400\n  ;G130 O0 X100 Y-0.4 Z0.8 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2/2.4053} L40 E20 D5\n  G130 O0 X100 Y-0.2 Z0.6 F{filament_max_volumetric_speed[initial_no_support_filament_id]/2/2.4053} L40 E12 D4\n  G90\n  M83\n  G1 Z1\n  M400\n;===== noozle load line end ===========================\nM1002 gcode_claim_action : 0\n  G29.99\n\n{if (filament_type[initial_no_support_filament_id] == \"TPU\") ||\n(filament_type[initial_no_support_filament_id] == \"PLA\") ||  (filament_type[initial_no_support_filament_id] == \"PETG\")}\nM1015.3 S1 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]};enable tpu, pla and petg clog detect\n{else}\nM1015.3 S0;disable clog detect\n{endif}\n\n{if (filament_type[initial_no_support_filament_id] == \"PLA\") ||  (filament_type[initial_no_support_filament_id] == \"PETG\")\n ||  (filament_type[initial_no_support_filament_id] == \"PLA-CF\")  ||  (filament_type[initial_no_support_filament_id] == \"PETG-CF\")}\nM1015.4 S1 K1 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} ;enable E air printing detect\n{else}\nM1015.4 S0 K0 H{nozzle_diameter_at_nozzle_id[initial_nozzle_id]} ;disable E air printing detect\n{endif}\n\nM620.6 I[initial_no_support_filament_id] W1 ;enable ams air printing detect\n\nM1010 Q0 B0.023 S0.01\nM1010 Q1 B0.005 S0.01\nM1010.1 S1\n
; machine_switch_extruder_time = 0
; machine_unload_filament_time = 31
; master_extruder_id = 1
; max_bridge_length = 0
; max_layer_height = 0.28
; max_travel_detour_distance = 0
; min_bead_width = 85%
; min_feature_size = 25%
; min_layer_height = 0.08
; minimum_sparse_infill_area = 15
; mmu_segmented_region_interlocking_depth = 0
; mmu_segmented_region_max_width = 0
; monotonic_travel_into_wall = 45%
; no_slow_down_for_cooling_on_outwalls = 0
; nozzle_diameter = 0.4
; nozzle_flush_dataset = 0
; nozzle_height = 4.2
; nozzle_temperature = 255
; nozzle_temperature_initial_layer = 255
; nozzle_temperature_range_high = 270
; nozzle_temperature_range_low = 220
; nozzle_type = hardened_steel
; nozzle_volume = 110
; nozzle_volume_type = Standard
; only_one_wall_first_layer = 0
; ooze_prevention = 0
; other_layers_print_sequence = 0
; other_layers_print_sequence_nums = 0
; outer_wall_acceleration = 6000
; outer_wall_jerk = 9
; outer_wall_line_width = 0.42
; outer_wall_speed = 200
; overhang_1_4_speed = 0
; overhang_2_4_speed = 50
; overhang_3_4_speed = 30
; overhang_4_4_speed = 10
; overhang_fan_speed = 90
; overhang_fan_threshold = 10%
; overhang_threshold_participating_cooling = 95%
; overhang_totally_speed = 10
; override_filament_scarf_seam_setting = 0
; override_process_overhang_speed = 0
; physical_extruder_map = 0
; post_process = 
; pre_start_fan_time = 0
; precise_outer_wall = 0
; precise_z_height = 0
; pressure_advance = 0.02
; prime_tower_brim_width = 3
; prime_tower_enable_framework = 0
; prime_tower_extra_rib_length = 0
; prime_tower_fillet_wall = 1
; prime_tower_flat_ironing = 1
; prime_tower_infill_gap = 150%
; prime_tower_lift_height = -1
; prime_tower_lift_speed = 90
; prime_tower_max_speed = 90
; prime_tower_rib_wall = 1
; prime_tower_rib_width = 8
; prime_tower_skip_points = 1
; prime_tower_width = 35
; prime_volume_mode = Default
; print_compatible_printers = "Bambu Lab P2S 0.4 nozzle"
; print_extruder_id = 1
; print_extruder_variant = "Direct Drive Standard"
; print_flow_ratio = 1
; print_in_clockwise = 1
; print_sequence = by layer
; print_settings_id = 0.20mm Standard @BBL P2S
; printable_area = 0x0,256x0,256x256,0x256
; printable_height = 256
; printer_extruder_id = 1
; printer_extruder_variant = "Direct Drive Standard"
; printer_model = Bambu Lab P2S
; printer_notes = 
; printer_settings_id = Bambu Lab P2S 0.4 nozzle
; printer_structure = corexy
; printer_technology = FFF
; printer_variant = 0.4
; printhost_authorization_type = key
; printhost_ssl_ignore_revoke = 0
; printing_by_object_gcode = 
; process_notes = 
; raft_contact_distance = 0.1
; raft_expansion = 1.5
; raft_first_layer_density = 90%
; raft_first_layer_expansion = -1
; raft_layers = 0
; reduce_crossing_wall = 0
; reduce_fan_stop_start_freq = 1
; reduce_infill_retraction_mode = Auto
; required_nozzle_HRC = 3
; resolution = 0.012
; retract_before_wipe = 0%
; retract_length_toolchange = 2
; retract_lift_above = 0
; retract_lift_below = 249
; retract_restart_extra = 0
; retract_restart_extra_toolchange = 0
; retract_when_changing_layer = 1
; retraction_distances_when_cut = 18
; retraction_distances_when_ec = 0
; retraction_length = 0.8
; retraction_minimum_travel = 1
; retraction_speed = 30
; role_base_wipe_speed = 1
; scan_first_layer = 0
; scarf_angle_threshold = 155
; seam_gap = 15%
; seam_placement_away_from_overhangs = 0
; seam_position = aligned
; seam_slope_conditional = 1
; seam_slope_entire_loop = 0
; seam_slope_gap = 0
; seam_slope_inner_walls = 1
; seam_slope_min_length = 10
; seam_slope_start_height = 10%
; seam_slope_steps = 10
; seam_slope_type = none
; silent_mode = 0
; single_extruder_multi_material = 1
; skeleton_infill_density = 15%
; skeleton_infill_line_width = 0.45
; skin_infill_density = 15%
; skin_infill_depth = 2
; skin_infill_line_width = 0.45
; skirt_distance = 2
; skirt_height = 1
; skirt_loops = 0
; skirt_per_object = 1
; slice_closing_radius = 0.049
; slicing_mode = regular
; slow_down_for_layer_cooling = 1
; slow_down_layer_time = 12
; slow_down_min_speed = 20
; slowdown_end_acc = 100000
; slowdown_end_height = 400
; slowdown_end_speed = 1000
; slowdown_start_acc = 100000
; slowdown_start_height = 0
; slowdown_start_speed = 1000
; small_perimeter_speed = 50%
; small_perimeter_threshold = 0
; smooth_coefficient = 4
; smooth_speed_discontinuity_area = 1
; solid_infill_filament = 0
; sparse_infill_acceleration = 100%
; sparse_infill_anchor = 400%
; sparse_infill_anchor_max = 20
; sparse_infill_density = 15%
; sparse_infill_filament = 0
; sparse_infill_lattice_angle_1 = -45
; sparse_infill_lattice_angle_2 = 45
; sparse_infill_line_width = 0.45
; sparse_infill_pattern = grid
; sparse_infill_speed = 270
; spiral_mode = 0
; spiral_mode_max_xy_smoothing = 200%
; spiral_mode_smooth = 0
; standby_temperature_delta = -5
; start_end_points = 30x-3,54x245
; supertack_plate_temp = 70
; supertack_plate_temp_initial_layer = 70
; support_air_filtration = 0
; support_angle = 0
; support_base_pattern = default
; support_base_pattern_spacing = 2.5
; support_bottom_interface_spacing = 0.5
; support_bottom_z_distance = 0.2
; support_chamber_temp_control = 0
; support_cooling_filter = 0
; support_critical_regions_only = 0
; support_expansion = 0
; support_fast_purge_mode = 0
; support_filament = 0
; support_interface_bottom_layers = 2
; support_interface_filament = 0
; support_interface_loop_pattern = 0
; support_interface_not_for_body = 1
; support_interface_pattern = auto
; support_interface_spacing = 0.5
; support_interface_speed = 80
; support_interface_top_layers = 2
; support_ironing_direction = 0
; support_ironing_flow = 10%
; support_ironing_inset = 0
; support_ironing_pattern = zig-zag
; support_ironing_spacing = 0.15
; support_ironing_speed = 30
; support_line_width = 0.42
; support_object_first_layer_gap = 0.2
; support_object_skip_flush = 1
; support_object_xy_distance = 0.35
; support_on_build_plate_only = 0
; support_remove_small_overhang = 1
; support_speed = 150
; support_style = default
; support_threshold_angle = 30
; support_top_z_distance = 0.2
; support_type = tree(auto)
; symmetric_infill_y_axis = 0
; temperature_vitrification = 70
; template_custom_gcode = 
; textured_plate_temp = 70
; textured_plate_temp_initial_layer = 70
; thick_bridges = 0
; thumbnail_size = 50x50
; time_lapse_gcode = ;======== P2S timelapes gcode ==========\n;===== 2025/06/16 ====\n; SKIPPABLE_START\n; SKIPTYPE: timelapse\nM622.1 S1 ; for prev firware, default turned on\n\nM1002 judge_flag timelapse_record_flag\nM622 J1\n{if timelapse_type == 0} ; timelapse without wipe tower\n  M971 S11 C10 O0\n  M1004 S5 P1  ; external shutter\n{elsif timelapse_type == 1} ; timelapse with wipe tower\n  G150.3 ; move to garbage can\n  M400\n  M1004 S5 P1  ; external shutter\n  M400 P300\n  M971 S11 C10 O0\n  M400 P350\n  \n  G90\n  G1 Z{max_layer_z + 3.0} F1200\n  G1 Y247 F30000\n  G1 Y217 F18000\n{endif}\nM623\n; SKIPPABLE_END\n
; timelapse_type = 0
; top_area_threshold = 200%
; top_color_penetration_layers = 5
; top_one_wall_type = all top
; top_shell_layers = 5
; top_shell_thickness = 1
; top_solid_infill_flow_ratio = 1
; top_surface_acceleration = 2000
; top_surface_density = 100%
; top_surface_jerk = 9
; top_surface_line_width = 0.42
; top_surface_pattern = monotonicline
; top_surface_speed = 200
; top_z_overrides_xy_distance = 0
; travel_acceleration = 10000
; travel_jerk = 9
; travel_short_distance_acceleration = 250
; travel_speed = 600
; travel_speed_z = 0
; tree_support_branch_angle = 45
; tree_support_branch_diameter = 2
; tree_support_branch_diameter_angle = 5
; tree_support_branch_distance = 5
; tree_support_wall_count = -1
; upward_compatible_machine = "Bambu Lab A1 0.4 nozzle";"Bambu Lab H2S 0.4 nozzle";"Bambu Lab H2D 0.4 nozzle";"Bambu Lab H2D Pro 0.4 nozzle";"Bambu Lab H2C 0.4 nozzle";"Bambu Lab X2D 0.4 nozzle";"Bambu Lab A2L 0.4 nozzle"
; use_firmware_retraction = 0
; use_relative_e_distances = 1
; vertical_shell_speed = 80%
; volumetric_speed_coefficients = "0 0 0 0 0 0"
; wall_distribution_count = 1
; wall_filament = 0
; wall_generator = classic
; wall_loops = 2
; wall_sequence = inner wall/outer wall
; wall_transition_angle = 10
; wall_transition_filter_deviation = 25%
; wall_transition_length = 100%
; wipe = 1
; wipe_distance = 2
; wipe_speed = 80%
; wipe_tower_no_sparse_layers = 0
; wipe_tower_rotation_angle = 0
; wipe_tower_x = 165
; wipe_tower_y = 216.972
; wrapping_detection_gcode = ;======== P2S 20250822 clumping ========\n{if !spiral_mode}\n    M622.1 S0 ; for previous firmware, default turn off\n    M1002 set_flag g39_forced_detection_flag=1\n    M1002 judge_flag g39_forced_detection_flag\n    M622 J1\n        {if layer_num == 3 || layer_num == 10 || layer_num == 19}\n            M993 A2 B2 C2 ; nozzle cam detection allow status save.\n            M993 A0 B0 C0 ; nozzle cam detection not allowed.\n\n            M400 P100\n\n            G39\n\n            G90\n            G1 Y247 F30000\n            G1 Y217 F18000\n            \n            M993 A3 B3 C3 ; nozzle cam detection allow status restore.\n        {endif}\n    M623\n{endif}
; wrapping_detection_layers = 20
; wrapping_exclude_area = 153x256,216x256,216x235,153x235
; xy_contour_compensation = 0
; xy_hole_compensation = 0
; z_direction_outwall_speed_continuous = 0
; z_hop = 0.4
; z_hop_types = Auto Lift
; CONFIG_BLOCK_END

; EXECUTABLE_BLOCK_START
M73 P0 R9
M73 C8
M201 X20000 Y20000 Z500 E5000
M203 X600 Y600 Z20 E30
M204 P20000 R5000 T20000
M205 X9.00 Y9.00 Z3.00 E2.50
M106 S0
M106 P2 S0
; FEATURE: Custom
;M1002 set_flag extrude_cali_flag=1
;M1002 set_flag g29_before_print_flag=1
;M1002 set_flag auto_cali_toolhead_offset_flag=1
;M1002 set_flag build_plate_detect_flag=1

;======== P2S start gcode==========
;===== 2026/05/18 =====

  M140 S70 ; heat heatbed first
  M993 A0 B0 C0 ; nozzle cam detection not allowed.
  M400

;=====printer start sound ===================
M17
M400 S1
M1006 S1
M1006 A53 B9 L50 C53 D9 M50 E53 F9 N50
M1006 A56 B9 L50 C56 D9 M50 E56 F9 N50
M1006 A61 B9 L50 C61 D9 M50 E61 F9 N50
M1006 A53 B9 L50 C53 D9 M50 E53 F9 N50
M1006 A56 B9 L50 C56 D9 M50 E56 F9 N50
M1006 A61 B18 L50 C61 D18 M50 E61 F18 N50
M1006 W
;=====printer start sound ===================

  M620 M ;enable remap
  G389

;===== avoid end stop =================
  G91
  G380 S2 Z22 F1200
  G380 S2 Z-12 F1200
  G90
;===== avoid end stop =================

;===== reset machine status =================
  M204 S10000
  M630 S0 P1
  G90
  M17 D ; reset motor current to default
  M960 S5 P1 ; turn on logo lamp
  G90
  M220 S100 ;Reset Feedrate
  M1002 set_gcode_claim_speed_level: 5
  M221 S100 ;Reset Flowrate
  M73.2   R1.0 ;Reset left time magnitude
  G29.1 Z0 ; clear z-trim value first
  M983.1 M1
  M982.2 S1 ; turn on cog noise reduction
  M983.4 S0
;===== reset machine status =================

;==== set airduct mode ====
;==== if Chamber Cooling is necessary ====


M145 P1 ; set airduct mode to heating mode for heating
M106 P2 S127 ; turn on 50% filter fan
M142 P6 R30 S40 U0.3 V0.8 ; set PLA/TPU exhaust chamber autocooling


;==== set airduct mode ====

;===== start to heat heatbed & hotend==========
  M1002 gcode_claim_action : 2
  M1002 set_filament_type:PETG
  M104 S140 A

  G29.2 S0 ; avoid invalid abl data

;===== first homing start =====
  M1002 gcode_claim_action : 13
  G28 X T300
  G150.1 F8000 ; wipe mouth to avoid filament stick to heatbed
  G150.3
  M972 S24 P0
  M972 S26 P0 C0
  M972 S42 P0 T5000
  G150.1 F8000 ; wipe mouth to avoid filament stick to heatbed
  G90
  G1 X128 Y128 F30000
  G28 Z P0 T400
  M400
;===== first homign end =====

;===== detection start =====
  M1002 gcode_claim_action : 11
  M104 S175 A ; rise temp in advance
  M972 S19 P0 T5000 ;plate type detection

  
;===== detection end =====

;===== prepare print temperature and material ==========
  M400
  M211 X0 Y0 Z0 ;turn off soft endstop
  M975 S1 ; turn on input shaping

  G29.2 S0 ; avoid invalid abl data
  G150.3

M620.10 A0 F299.339 H0.4 T270 P255 S1
M620.10 A1 F299.339 H0.4 T270 P255 S1


 M620.11 P0 L0 I0 E0
 M620.11 K0 I0 R0

  M620 S0A   ; switch material if AMS exist
  M1002 gcode_claim_action : 4
  M1002 set_filament_type:UNKNOWN
  M400
  T0
  M400
  M628 S0
  M629
  M400
  M1002 set_filament_type:PETG
  M621 S0A
  M104 S255
  M400
  M106 P1 S0
  M400
  G29.2 S1
;===== prepare print temperature and material ==========


;===== auto extrude cali start =========================
  M975 S1
  M1002 judge_flag extrude_cali_flag
  M622 J0
    M983.3 F5 A0.4 ; cali dynamic extrusion compensation
  M623

  M622 J1
    M1002 set_filament_type:PETG
    M1002 gcode_claim_action : 8
    M109 S255
    G90
    M83
    M983.3 F5 A0.4 ; cali dynamic extrusion compensation
    M400
    M106 P1 S255
    M400 S5
    M106 P1 S0
    G150.3
  M623

  M622 J2
    M1002 set_filament_type:PETG
    M1002 gcode_claim_action : 8
    M109 S255
    G90
    M83
    M983.3 F5 A0.4 ; cali dynamic extrusion compensation
    M400
    M106 P1 S255
    M400 S5
    M106 P1 S0
    G150.3
  M623
;===== auto extrude cali end =========================

  

  
    M83
    G1 E-3 F1800
    M400 P500
  
  G150.2
  G150.1 F8000
  G150.2
  G150.1 F8000

  G91
  G1 Y-16 F12000 ; move away from the trash bin
  G90
  M400

  M104 S175 A

;===== wipe right nozzle start =====
  M1002 gcode_claim_action : 14
  G150 T255
  M400


  M109 S140 A

  G91
M73 P4 R9
  G1 Z5 F1200
  G90
  M400
  G150.1
;===== wipe left nozzle end =====


;===== mech mode sweep start =====
  M1002 gcode_claim_action : 3
  G90
M73 P6 R9
  G1 X128 Y128 F20000
  G1 Z5 F1200
  M400 P200
  M970.3 Q1 A5 K0 O1
  M970.2 Q1 K1 W74 Z0.01
  M974 Q1 S2 P0
  M970.3 Q0 A7 K0 O1
  M970.2 Q0 K1 W74 Z0.01
  M974 Q0 S2 P0
  M975 S1
  M400
;===== mech mode sweep end =====

;===== bed leveling ==================================
  M1002 gcode_claim_action : 54
  M190 S70; ensure bed temp
  M109 S140 A
  M106 S0 ; turn off fan , too noisy
  M1002 judge_flag g29_before_print_flag
  M622 J1
    M1002 gcode_claim_action : 1
    
      G29 A1 X113 Y113 I30 J30
    
    M400
  M623

  M622 J2
    M1002 gcode_claim_action : 1
    
      G29 A2 X113 Y113 I30 J30
    
    M400
  M623

  M622 J0
    G28
  M623
  G29.2 S1
  G28
;===== bed leveling end ================================

  M985.1 U0 E2
  M985.1 U1 E2

  M104 S255 A
  G150.3 ; move to garbage can to wait for temp

;===== wait temperature reaching the reference value =======
  M190 S70

  ;========turn off light and fans =============
  M960 S1 P0 ; turn off laser
  M960 S2 P0 ; turn off laser
  M106 S0 ; turn off cooling fan

;===== wait temperature reaching the reference value =======

  M1002 gcode_claim_action : 255
  M400
  M975 S1 ; turn on mech mode supression

;============switch again==================
  M211 X0 Y0 Z0 ;turn off soft endstop
  G91
  G1 Z6 F1200
  G90
  M1002 set_filament_type:PETG
  M620 S0A
  M400
  T0
  M400
  M628 S0
  M629
  M400
  M621 S0A
;============switch again==================

;===== for Textured PEI Plate , lower the nozzle as the nozzle was touching topmost of the texture when homing ==
  
    
      G29.1 Z0.01 ; for Textured PEI Plate
    
  


;===== nozzle load line ===============================
M1002 gcode_claim_action : 51
  G29.2 S1 ; ensure z comp turn on
  G90
  M83
  M400 P50
  M500 D1
  M400 S3
  M109 S255
  G0 X100 Y0 F24000
  M400
  ;G130 O0 X100 Y-0.4 Z0.8 F2.49449 L40 E20 D5
  G130 O0 X100 Y-0.2 Z0.6 F2.49449 L40 E12 D4
  G90
  M83
  G1 Z1
  M400
;===== noozle load line end ===========================
M1002 gcode_claim_action : 0
  G29.99


M1015.3 S1 H0.4;enable tpu, pla and petg clog detect



M1015.4 S1 K1 H0.4 ;enable E air printing detect


M620.6 I0 W1 ;enable ams air printing detect

M1010 Q0 B0.023 S0.01
M1010 Q1 B0.005 S0.01
M1010.1 S1
; MACHINE_START_GCODE_END
; filament start gcode
;VT0 H-1
G90
G21
M83 ; use relative distances for extrusion
M981 S1 P20000 ;open spaghetti detector
; CHANGE_LAYER
; Z_HEIGHT: 0.2
; LAYER_HEIGHT: 0.2
G1 E-.8 F1800
;======== P2S layer_change gcode ==========
;===== 2026/05/15 ====




    ;not reset filter fan in first layer
    ;not reset fan






    

    M622.1 S0
    M1002 judge_flag ventobox_replace_aux1_fan_flag
    M622 J0
    M106 P10 S0; set first x_layer left aux fan
    M623
;not reset fan


; update layer progress
M73 L1
M991 S0 P0 ;notify layer change


M106 S0
M204 S6000
M73 P70 R2
M73 C1
G1 Z.4 F36000
;======== P2S timelapes gcode ==========
;===== 2025/06/16 ====
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
  M971 S11 C10 O0
  M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 175
G1 X116.671 Y135.843
G1 Z.2
M73 P71 R2
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.5
G1 F3000
M204 S500
G1 X116.707 Y135.843 E.00129
G1 X116.707 Y135.993 E.00542
G1 X116.857 Y135.993 E.00542
G1 X116.857 Y136.293 E.01083
G1 X117.007 Y136.293 E.00542
G1 X117.007 Y136.443 E.00542
G1 X117.157 Y136.443 E.00542
G1 X117.157 Y136.593 E.00542
G1 X117.307 Y136.593 E.00542
G1 X117.307 Y136.743 E.00542
G1 X117.457 Y136.743 E.00542
G1 X117.457 Y137.043 E.01083
G1 X117.607 Y137.043 E.00542
G1 X117.607 Y137.193 E.00542
G1 X117.757 Y137.193 E.00542
G1 X117.757 Y137.343 E.00542
G1 X117.907 Y137.343 E.00542
G1 X117.907 Y137.493 E.00542
G1 X118.057 Y137.493 E.00542
G1 X118.057 Y137.643 E.00542
G1 X118.207 Y137.643 E.00542
G1 X118.207 Y137.793 E.00542
G1 X118.357 Y137.793 E.00542
G1 X118.357 Y137.943 E.00542
G1 X118.507 Y137.943 E.00542
G1 X118.507 Y138.093 E.00542
G1 X118.657 Y138.093 E.00542
G1 X118.657 Y138.243 E.00542
G1 X118.807 Y138.243 E.00542
G1 X118.807 Y138.393 E.00542
G1 X118.957 Y138.393 E.00542
G1 X118.957 Y138.543 E.00542
G1 X119.257 Y138.543 E.01083
G1 X119.257 Y138.693 E.00542
G1 X119.407 Y138.693 E.00542
G1 X119.407 Y138.843 E.00542
G1 X119.557 Y138.843 E.00542
G1 X119.557 Y138.993 E.00542
G1 X119.707 Y138.993 E.00542
G1 X119.707 Y139.143 E.00542
G1 X120.007 Y139.143 E.01083
G1 X120.007 Y139.293 E.00542
G1 X120.157 Y139.293 E.00542
G1 X120.157 Y139.443 E.00542
G1 X120.307 Y139.443 E.00542
G1 X120.307 Y139.593 E.00542
G1 X120.607 Y139.593 E.01083
G1 X120.607 Y139.743 E.00542
G1 X120.907 Y139.743 E.01083
G1 X120.907 Y139.893 E.00542
G1 X121.057 Y139.893 E.00542
G1 X121.057 Y140.043 E.00542
G1 X121.357 Y140.043 E.01083
G1 X121.357 Y140.193 E.00542
G1 X121.657 Y140.193 E.01083
G1 X121.657 Y140.343 E.00542
G1 X121.807 Y140.343 E.00542
G1 X121.807 Y140.493 E.00542
G1 X122.107 Y140.493 E.01083
G1 X122.107 Y140.643 E.00542
G1 X122.407 Y140.643 E.01083
G1 X122.407 Y140.793 E.00542
G1 X122.857 Y140.793 E.01625
G1 X122.857 Y140.943 E.00542
G1 X123.157 Y140.943 E.01083
G1 X123.157 Y141.093 E.00542
G1 X123.607 Y141.093 E.01625
G1 X123.607 Y141.243 E.00542
G1 X123.907 Y141.243 E.01083
G1 X123.907 Y141.393 E.00542
G1 X124.357 Y141.393 E.01625
G1 X124.357 Y141.543 E.00542
G1 X124.957 Y141.543 E.02166
G1 X124.957 Y141.693 E.00542
G1 X125.557 Y141.693 E.02166
G1 X125.557 Y141.843 E.00542
G1 X126.307 Y141.843 E.02708
G1 X126.307 Y141.993 E.00542
G1 X127.357 Y141.993 E.03791
G1 X127.357 Y142.143 E.00542
G1 X128.643 Y142.143 E.04643
G1 X128.643 Y141.993 E.00542
G1 X129.693 Y141.993 E.03791
G1 X129.693 Y141.843 E.00542
G1 X130.443 Y141.843 E.02708
G1 X130.443 Y141.693 E.00542
G1 X131.043 Y141.693 E.02166
G1 X131.043 Y141.543 E.00542
G1 X131.643 Y141.543 E.02166
G1 X131.643 Y141.393 E.00542
G1 X132.093 Y141.393 E.01625
G1 X132.093 Y141.243 E.00542
G1 X132.393 Y141.243 E.01083
G1 X132.393 Y141.093 E.00542
G1 X132.843 Y141.093 E.01625
G1 X132.843 Y140.943 E.00542
G1 X133.143 Y140.943 E.01083
G1 X133.143 Y140.793 E.00542
G1 X133.593 Y140.793 E.01625
G1 X133.593 Y140.643 E.00542
G1 X133.893 Y140.643 E.01083
G1 X133.893 Y140.493 E.00542
G1 X134.193 Y140.493 E.01083
G1 X134.193 Y140.343 E.00542
G1 X134.343 Y140.343 E.00542
G1 X134.343 Y140.193 E.00542
G1 X134.643 Y140.193 E.01083
G1 X134.643 Y140.043 E.00542
G1 X134.943 Y140.043 E.01083
G1 X134.943 Y139.893 E.00542
G1 X135.093 Y139.893 E.00542
G1 X135.093 Y139.743 E.00542
G1 X135.393 Y139.743 E.01083
G1 X135.393 Y139.593 E.00542
G1 X135.693 Y139.593 E.01083
G1 X135.693 Y139.443 E.00542
G1 X135.843 Y139.443 E.00542
G1 X135.843 Y139.293 E.00542
G1 X135.993 Y139.293 E.00542
G1 X135.993 Y139.143 E.00542
G1 X136.293 Y139.143 E.01083
G1 X136.293 Y138.993 E.00542
G1 X136.443 Y138.993 E.00542
G1 X136.443 Y138.843 E.00542
G1 X136.593 Y138.843 E.00542
G1 X136.593 Y138.693 E.00542
G1 X136.743 Y138.693 E.00542
G1 X136.743 Y138.543 E.00542
G1 X137.043 Y138.543 E.01083
G1 X137.043 Y138.393 E.00542
G1 X137.193 Y138.393 E.00542
G1 X137.193 Y138.243 E.00542
G1 X137.343 Y138.243 E.00542
G1 X137.343 Y138.093 E.00542
G1 X137.493 Y138.093 E.00542
G1 X137.493 Y137.943 E.00542
G1 X137.643 Y137.943 E.00542
G1 X137.643 Y137.793 E.00542
G1 X137.793 Y137.793 E.00542
G1 X137.793 Y137.643 E.00542
G1 X137.943 Y137.643 E.00542
G1 X137.943 Y137.493 E.00542
G1 X138.093 Y137.493 E.00542
G1 X138.093 Y137.343 E.00542
G1 X138.243 Y137.343 E.00542
G1 X138.243 Y137.193 E.00542
G1 X138.393 Y137.193 E.00542
G1 X138.393 Y137.043 E.00542
G1 X138.543 Y137.043 E.00542
G1 X138.543 Y136.743 E.01083
G1 X138.693 Y136.743 E.00542
G1 X138.693 Y136.593 E.00542
G1 X138.843 Y136.593 E.00542
G1 X138.843 Y136.443 E.00542
G1 X138.993 Y136.443 E.00542
G1 X138.993 Y136.293 E.00542
G1 X139.143 Y136.293 E.00542
G1 X139.143 Y135.993 E.01083
G1 X139.293 Y135.993 E.00542
G1 X139.293 Y135.843 E.00542
G1 X139.443 Y135.843 E.00542
G1 X139.443 Y135.693 E.00542
G1 X139.593 Y135.693 E.00542
G1 X139.593 Y135.393 E.01083
G1 X139.743 Y135.393 E.00542
G1 X139.743 Y135.093 E.01083
G1 X139.893 Y135.093 E.00542
G1 X139.893 Y134.943 E.00542
G1 X140.043 Y134.943 E.00542
G1 X140.043 Y134.643 E.01083
G1 X140.193 Y134.643 E.00542
G1 X140.193 Y134.343 E.01083
G1 X140.343 Y134.343 E.00542
G1 X140.343 Y134.193 E.00542
G1 X140.493 Y134.193 E.00542
G1 X140.493 Y133.893 E.01083
G1 X140.643 Y133.893 E.00542
G1 X140.643 Y133.593 E.01083
G1 X140.793 Y133.593 E.00542
G1 X140.793 Y133.143 E.01625
G1 X140.943 Y133.143 E.00542
G1 X140.943 Y132.843 E.01083
G1 X141.093 Y132.843 E.00542
G1 X141.093 Y132.393 E.01625
G1 X141.243 Y132.393 E.00542
G1 X141.243 Y132.093 E.01083
G1 X141.393 Y132.093 E.00542
G1 X141.393 Y131.643 E.01625
G1 X141.543 Y131.643 E.00542
G1 X141.543 Y131.043 E.02166
G1 X141.693 Y131.043 E.00542
G1 X141.693 Y130.443 E.02166
G1 X141.843 Y130.443 E.00542
G1 X141.843 Y129.693 E.02708
G1 X141.993 Y129.693 E.00542
G1 X141.993 Y128.643 E.03791
G1 X142.143 Y128.643 E.00542
G1 X142.143 Y127.357 E.04643
G1 X141.993 Y127.357 E.00542
G1 X141.993 Y126.307 E.03791
G1 X141.843 Y126.307 E.00542
G1 X141.843 Y125.557 E.02708
G1 X141.693 Y125.557 E.00542
G1 X141.693 Y124.957 E.02166
G1 X141.543 Y124.957 E.00542
M73 P72 R2
G1 X141.543 Y124.357 E.02166
G1 X141.393 Y124.357 E.00542
G1 X141.393 Y123.907 E.01625
G1 X141.243 Y123.907 E.00542
G1 X141.243 Y123.607 E.01083
G1 X141.093 Y123.607 E.00542
G1 X141.093 Y123.157 E.01625
G1 X140.943 Y123.157 E.00542
G1 X140.943 Y122.857 E.01083
G1 X140.793 Y122.857 E.00542
G1 X140.793 Y122.407 E.01625
G1 X140.643 Y122.407 E.00542
G1 X140.643 Y122.107 E.01083
G1 X140.493 Y122.107 E.00542
G1 X140.493 Y121.807 E.01083
G1 X140.343 Y121.807 E.00542
G1 X140.343 Y121.657 E.00542
G1 X140.193 Y121.657 E.00542
G1 X140.193 Y121.357 E.01083
G1 X140.043 Y121.357 E.00542
G1 X140.043 Y121.057 E.01083
G1 X139.893 Y121.057 E.00542
G1 X139.893 Y120.907 E.00542
G1 X139.743 Y120.907 E.00542
G1 X139.743 Y120.607 E.01083
G1 X139.593 Y120.607 E.00542
G1 X139.593 Y120.307 E.01083
G1 X139.443 Y120.307 E.00542
G1 X139.443 Y120.157 E.00542
G1 X139.293 Y120.157 E.00542
G1 X139.293 Y120.007 E.00542
G1 X139.143 Y120.007 E.00542
G1 X139.143 Y119.707 E.01083
G1 X138.993 Y119.707 E.00542
G1 X138.993 Y119.557 E.00542
G1 X138.843 Y119.557 E.00542
G1 X138.843 Y119.407 E.00542
G1 X138.693 Y119.407 E.00542
G1 X138.693 Y119.257 E.00542
G1 X138.543 Y119.257 E.00542
G1 X138.543 Y118.957 E.01083
G1 X138.393 Y118.957 E.00542
G1 X138.393 Y118.807 E.00542
G1 X138.243 Y118.807 E.00542
G1 X138.243 Y118.657 E.00542
G1 X138.093 Y118.657 E.00542
G1 X138.093 Y118.507 E.00542
G1 X137.943 Y118.507 E.00542
G1 X137.943 Y118.357 E.00542
G1 X137.793 Y118.357 E.00542
G1 X137.793 Y118.207 E.00542
G1 X137.643 Y118.207 E.00542
G1 X137.643 Y118.057 E.00542
G1 X137.493 Y118.057 E.00542
G1 X137.493 Y117.907 E.00542
G1 X137.343 Y117.907 E.00542
G1 X137.343 Y117.757 E.00542
G1 X137.193 Y117.757 E.00542
G1 X137.193 Y117.607 E.00542
G1 X137.043 Y117.607 E.00542
G1 X137.043 Y117.457 E.00542
G1 X136.743 Y117.457 E.01083
G1 X136.743 Y117.307 E.00542
G1 X136.593 Y117.307 E.00542
G1 X136.593 Y117.157 E.00542
G1 X136.443 Y117.157 E.00542
G1 X136.443 Y117.007 E.00542
G1 X136.293 Y117.007 E.00542
G1 X136.293 Y116.857 E.00542
G1 X135.993 Y116.857 E.01083
G1 X135.993 Y116.707 E.00542
G1 X135.843 Y116.707 E.00542
G1 X135.843 Y116.557 E.00542
G1 X135.693 Y116.557 E.00542
G1 X135.693 Y116.407 E.00542
G1 X135.393 Y116.407 E.01083
G1 X135.393 Y116.257 E.00542
G1 X135.093 Y116.257 E.01083
G1 X135.093 Y116.107 E.00542
G1 X134.943 Y116.107 E.00542
G1 X134.943 Y115.957 E.00542
G1 X134.643 Y115.957 E.01083
G1 X134.643 Y115.807 E.00542
G1 X134.343 Y115.807 E.01083
G1 X134.343 Y115.657 E.00542
G1 X134.193 Y115.657 E.00542
G1 X134.193 Y115.507 E.00542
G1 X133.893 Y115.507 E.01083
G1 X133.893 Y115.357 E.00542
G1 X133.593 Y115.357 E.01083
G1 X133.593 Y115.207 E.00542
G1 X133.143 Y115.207 E.01625
G1 X133.143 Y115.057 E.00542
G1 X132.843 Y115.057 E.01083
G1 X132.843 Y114.907 E.00542
G1 X132.393 Y114.907 E.01625
G1 X132.393 Y114.757 E.00542
G1 X132.093 Y114.757 E.01083
G1 X132.093 Y114.607 E.00542
G1 X131.643 Y114.607 E.01625
G1 X131.643 Y114.457 E.00542
G1 X131.043 Y114.457 E.02166
G1 X131.043 Y114.307 E.00542
G1 X130.443 Y114.307 E.02166
G1 X130.443 Y114.157 E.00542
G1 X129.693 Y114.157 E.02708
G1 X129.693 Y114.007 E.00542
G1 X128.643 Y114.007 E.03791
G1 X128.643 Y113.857 E.00542
G1 X127.357 Y113.857 E.04643
G1 X127.357 Y114.007 E.00542
G1 X126.307 Y114.007 E.03791
G1 X126.307 Y114.157 E.00542
G1 X125.557 Y114.157 E.02708
G1 X125.557 Y114.307 E.00542
G1 X124.957 Y114.307 E.02166
G1 X124.957 Y114.457 E.00542
G1 X124.357 Y114.457 E.02166
G1 X124.357 Y114.607 E.00542
G1 X123.907 Y114.607 E.01625
G1 X123.907 Y114.757 E.00542
G1 X123.607 Y114.757 E.01083
G1 X123.607 Y114.907 E.00542
G1 X123.157 Y114.907 E.01625
G1 X123.157 Y115.057 E.00542
G1 X122.857 Y115.057 E.01083
G1 X122.857 Y115.207 E.00542
G1 X122.407 Y115.207 E.01625
G1 X122.407 Y115.357 E.00542
G1 X122.107 Y115.357 E.01083
G1 X122.107 Y115.507 E.00542
G1 X121.807 Y115.507 E.01083
G1 X121.807 Y115.657 E.00542
G1 X121.657 Y115.657 E.00542
G1 X121.657 Y115.807 E.00542
G1 X121.357 Y115.807 E.01083
G1 X121.357 Y115.957 E.00542
G1 X121.057 Y115.957 E.01083
G1 X121.057 Y116.107 E.00542
G1 X120.907 Y116.107 E.00542
G1 X120.907 Y116.257 E.00542
G1 X120.607 Y116.257 E.01083
G1 X120.607 Y116.407 E.00542
G1 X120.307 Y116.407 E.01083
G1 X120.307 Y116.557 E.00542
G1 X120.157 Y116.557 E.00542
G1 X120.157 Y116.707 E.00542
G1 X120.007 Y116.707 E.00542
G1 X120.007 Y116.857 E.00542
G1 X119.707 Y116.857 E.01083
G1 X119.707 Y117.007 E.00542
G1 X119.557 Y117.007 E.00542
G1 X119.557 Y117.157 E.00542
G1 X119.407 Y117.157 E.00542
G1 X119.407 Y117.307 E.00542
G1 X119.257 Y117.307 E.00542
G1 X119.257 Y117.457 E.00542
G1 X118.957 Y117.457 E.01083
G1 X118.957 Y117.607 E.00542
G1 X118.807 Y117.607 E.00542
G1 X118.807 Y117.757 E.00542
G1 X118.657 Y117.757 E.00542
G1 X118.657 Y117.907 E.00542
G1 X118.507 Y117.907 E.00542
G1 X118.507 Y118.057 E.00542
G1 X118.357 Y118.057 E.00542
G1 X118.357 Y118.207 E.00542
G1 X118.207 Y118.207 E.00542
G1 X118.207 Y118.357 E.00542
G1 X118.057 Y118.357 E.00542
G1 X118.057 Y118.507 E.00542
G1 X117.907 Y118.507 E.00542
G1 X117.907 Y118.657 E.00542
G1 X117.757 Y118.657 E.00542
G1 X117.757 Y118.807 E.00542
G1 X117.607 Y118.807 E.00542
G1 X117.607 Y118.957 E.00542
G1 X117.457 Y118.957 E.00542
G1 X117.457 Y119.257 E.01083
G1 X117.307 Y119.257 E.00542
G1 X117.307 Y119.407 E.00542
G1 X117.157 Y119.407 E.00542
G1 X117.157 Y119.557 E.00542
G1 X117.007 Y119.557 E.00542
G1 X117.007 Y119.707 E.00542
G1 X116.857 Y119.707 E.00542
G1 X116.857 Y120.007 E.01083
G1 X116.707 Y120.007 E.00542
G1 X116.707 Y120.157 E.00542
G1 X116.557 Y120.157 E.00542
G1 X116.557 Y120.307 E.00542
G1 X116.407 Y120.307 E.00542
G1 X116.407 Y120.607 E.01083
G1 X116.257 Y120.607 E.00542
G1 X116.257 Y120.907 E.01083
G1 X116.107 Y120.907 E.00542
G1 X116.107 Y121.057 E.00542
G1 X115.957 Y121.057 E.00542
G1 X115.957 Y121.357 E.01083
G1 X115.807 Y121.357 E.00542
G1 X115.807 Y121.657 E.01083
G1 X115.657 Y121.657 E.00542
G1 X115.657 Y121.807 E.00542
G1 X115.507 Y121.807 E.00542
G1 X115.507 Y122.107 E.01083
G1 X115.357 Y122.107 E.00542
G1 X115.357 Y122.407 E.01083
G1 X115.207 Y122.407 E.00542
G1 X115.207 Y122.857 E.01625
G1 X115.057 Y122.857 E.00542
G1 X115.057 Y123.157 E.01083
G1 X114.907 Y123.157 E.00542
G1 X114.907 Y123.607 E.01625
G1 X114.757 Y123.607 E.00542
G1 X114.757 Y123.907 E.01083
G1 X114.607 Y123.907 E.00542
G1 X114.607 Y124.357 E.01625
G1 X114.457 Y124.357 E.00542
G1 X114.457 Y124.957 E.02166
G1 X114.307 Y124.957 E.00542
G1 X114.307 Y125.557 E.02166
G1 X114.157 Y125.557 E.00542
G1 X114.157 Y126.307 E.02708
G1 X114.007 Y126.307 E.00542
G1 X114.007 Y127.357 E.03791
G1 X113.857 Y127.357 E.00542
G1 X113.857 Y128.643 E.04643
G1 X114.007 Y128.643 E.00542
G1 X114.007 Y129.693 E.03791
G1 X114.157 Y129.693 E.00542
G1 X114.157 Y130.443 E.02708
G1 X114.307 Y130.443 E.00542
G1 X114.307 Y131.043 E.02166
G1 X114.457 Y131.043 E.00542
G1 X114.457 Y131.643 E.02166
G1 X114.607 Y131.643 E.00542
G1 X114.607 Y132.093 E.01625
G1 X114.757 Y132.093 E.00542
G1 X114.757 Y132.393 E.01083
G1 X114.907 Y132.393 E.00542
G1 X114.907 Y132.843 E.01625
G1 X115.057 Y132.843 E.00542
G1 X115.057 Y133.143 E.01083
G1 X115.207 Y133.143 E.00542
G1 X115.207 Y133.593 E.01625
G1 X115.357 Y133.593 E.00542
G1 X115.357 Y133.893 E.01083
G1 X115.507 Y133.893 E.00542
G1 X115.507 Y134.193 E.01083
G1 X115.657 Y134.193 E.00542
G1 X115.657 Y134.343 E.00542
G1 X115.807 Y134.343 E.00542
G1 X115.807 Y134.643 E.01083
G1 X115.957 Y134.643 E.00542
G1 X115.957 Y134.943 E.01083
G1 X116.107 Y134.943 E.00542
G1 X116.107 Y135.093 E.00542
G1 X116.257 Y135.093 E.00542
G1 X116.257 Y135.393 E.01083
G1 X116.407 Y135.393 E.00542
G1 X116.407 Y135.693 E.01083
G1 X116.557 Y135.693 E.00542
G1 X116.557 Y135.843 E.00542
G1 X116.611 Y135.843 E.00196
M204 S6000
G1 X116.25 Y136.3 F36000
; FEATURE: Outer wall
G1 F3000
M204 S500
G1 X116.25 Y136.45 E.00542
G1 X116.4 Y136.45 E.00542
G1 X116.4 Y136.75 E.01083
G1 X116.55 Y136.75 E.00542
G1 X116.55 Y136.9 E.00542
G1 X116.7 Y136.9 E.00542
G1 X116.7 Y137.05 E.00542
G1 X116.85 Y137.05 E.00542
G1 X116.85 Y137.2 E.00542
G1 X117 Y137.2 E.00542
G1 X117 Y137.5 E.01083
G1 X117.15 Y137.5 E.00542
G1 X117.15 Y137.65 E.00542
G1 X117.3 Y137.65 E.00542
G1 X117.3 Y137.8 E.00542
G1 X117.45 Y137.8 E.00542
G1 X117.45 Y137.95 E.00542
G1 X117.6 Y137.95 E.00542
G1 X117.6 Y138.1 E.00542
G1 X117.75 Y138.1 E.00542
G1 X117.75 Y138.25 E.00542
G1 X117.9 Y138.25 E.00542
G1 X117.9 Y138.4 E.00542
G1 X118.05 Y138.4 E.00542
G1 X118.05 Y138.55 E.00542
G1 X118.2 Y138.55 E.00542
G1 X118.2 Y138.7 E.00542
G1 X118.35 Y138.7 E.00542
G1 X118.35 Y138.85 E.00542
G1 X118.5 Y138.85 E.00542
G1 X118.5 Y139 E.00542
G1 X118.8 Y139 E.01083
G1 X118.8 Y139.15 E.00542
G1 X118.95 Y139.15 E.00542
G1 X118.95 Y139.3 E.00542
G1 X119.1 Y139.3 E.00542
G1 X119.1 Y139.45 E.00542
G1 X119.25 Y139.45 E.00542
G1 X119.25 Y139.6 E.00542
G1 X119.55 Y139.6 E.01083
G1 X119.55 Y139.75 E.00542
G1 X119.7 Y139.75 E.00542
M73 P73 R2
G1 X119.7 Y139.9 E.00542
G1 X119.85 Y139.9 E.00542
G1 X119.85 Y140.05 E.00542
G1 X120.15 Y140.05 E.01083
G1 X120.15 Y140.2 E.00542
G1 X120.45 Y140.2 E.01083
G1 X120.45 Y140.35 E.00542
G1 X120.6 Y140.35 E.00542
G1 X120.6 Y140.5 E.00542
G1 X120.9 Y140.5 E.01083
G1 X120.9 Y140.65 E.00542
G1 X121.2 Y140.65 E.01083
G1 X121.2 Y140.8 E.00542
G1 X121.35 Y140.8 E.00542
G1 X121.35 Y140.95 E.00542
G1 X121.65 Y140.95 E.01083
G1 X121.65 Y141.1 E.00542
G1 X121.95 Y141.1 E.01083
G1 X121.95 Y141.25 E.00542
G1 X122.4 Y141.25 E.01625
G1 X122.4 Y141.4 E.00542
G1 X122.7 Y141.4 E.01083
G1 X122.7 Y141.55 E.00542
G1 X123.15 Y141.55 E.01625
G1 X123.15 Y141.7 E.00542
G1 X123.45 Y141.7 E.01083
G1 X123.45 Y141.85 E.00542
G1 X123.9 Y141.85 E.01625
G1 X123.9 Y142 E.00542
G1 X124.5 Y142 E.02166
G1 X124.5 Y142.15 E.00542
G1 X125.1 Y142.15 E.02166
G1 X125.1 Y142.3 E.00542
G1 X125.85 Y142.3 E.02708
G1 X125.85 Y142.45 E.00542
G1 X126.9 Y142.45 E.03791
G1 X126.9 Y142.6 E.00542
G1 X129.1 Y142.6 E.07943
G1 X129.1 Y142.45 E.00542
G1 X130.15 Y142.45 E.03791
G1 X130.15 Y142.3 E.00542
G1 X130.9 Y142.3 E.02708
G1 X130.9 Y142.15 E.00542
G1 X131.5 Y142.15 E.02166
G1 X131.5 Y142 E.00542
G1 X132.1 Y142 E.02166
G1 X132.1 Y141.85 E.00542
G1 X132.55 Y141.85 E.01625
G1 X132.55 Y141.7 E.00542
G1 X132.85 Y141.7 E.01083
G1 X132.85 Y141.55 E.00542
G1 X133.3 Y141.55 E.01625
G1 X133.3 Y141.4 E.00542
G1 X133.6 Y141.4 E.01083
G1 X133.6 Y141.25 E.00542
G1 X134.05 Y141.25 E.01625
G1 X134.05 Y141.1 E.00542
G1 X134.35 Y141.1 E.01083
G1 X134.35 Y140.95 E.00542
G1 X134.65 Y140.95 E.01083
G1 X134.65 Y140.8 E.00542
G1 X134.8 Y140.8 E.00542
G1 X134.8 Y140.65 E.00542
G1 X135.1 Y140.65 E.01083
G1 X135.1 Y140.5 E.00542
G1 X135.4 Y140.5 E.01083
G1 X135.4 Y140.35 E.00542
G1 X135.55 Y140.35 E.00542
G1 X135.55 Y140.2 E.00542
G1 X135.85 Y140.2 E.01083
G1 X135.85 Y140.05 E.00542
G1 X136.15 Y140.05 E.01083
G1 X136.15 Y139.9 E.00542
G1 X136.3 Y139.9 E.00542
G1 X136.3 Y139.75 E.00542
G1 X136.45 Y139.75 E.00542
G1 X136.45 Y139.6 E.00542
G1 X136.75 Y139.6 E.01083
G1 X136.75 Y139.45 E.00542
G1 X136.9 Y139.45 E.00542
G1 X136.9 Y139.3 E.00542
G1 X137.05 Y139.3 E.00542
G1 X137.05 Y139.15 E.00542
G1 X137.2 Y139.15 E.00542
G1 X137.2 Y139 E.00542
G1 X137.5 Y139 E.01083
G1 X137.5 Y138.85 E.00542
G1 X137.65 Y138.85 E.00542
G1 X137.65 Y138.7 E.00542
G1 X137.8 Y138.7 E.00542
G1 X137.8 Y138.55 E.00542
G1 X137.95 Y138.55 E.00542
G1 X137.95 Y138.4 E.00542
G1 X138.1 Y138.4 E.00542
G1 X138.1 Y138.25 E.00542
G1 X138.25 Y138.25 E.00542
G1 X138.25 Y138.1 E.00542
G1 X138.4 Y138.1 E.00542
G1 X138.4 Y137.95 E.00542
G1 X138.55 Y137.95 E.00542
G1 X138.55 Y137.8 E.00542
G1 X138.7 Y137.8 E.00542
G1 X138.7 Y137.65 E.00542
G1 X138.85 Y137.65 E.00542
G1 X138.85 Y137.5 E.00542
G1 X139 Y137.5 E.00542
G1 X139 Y137.2 E.01083
G1 X139.15 Y137.2 E.00542
G1 X139.15 Y137.05 E.00542
G1 X139.3 Y137.05 E.00542
G1 X139.3 Y136.9 E.00542
G1 X139.45 Y136.9 E.00542
G1 X139.45 Y136.75 E.00542
G1 X139.6 Y136.75 E.00542
G1 X139.6 Y136.45 E.01083
G1 X139.75 Y136.45 E.00542
G1 X139.75 Y136.3 E.00542
G1 X139.9 Y136.3 E.00542
G1 X139.9 Y136.15 E.00542
G1 X140.05 Y136.15 E.00542
G1 X140.05 Y135.85 E.01083
G1 X140.2 Y135.85 E.00542
G1 X140.2 Y135.55 E.01083
G1 X140.35 Y135.55 E.00542
G1 X140.35 Y135.4 E.00542
G1 X140.5 Y135.4 E.00542
G1 X140.5 Y135.1 E.01083
G1 X140.65 Y135.1 E.00542
G1 X140.65 Y134.8 E.01083
G1 X140.8 Y134.8 E.00542
G1 X140.8 Y134.65 E.00542
G1 X140.95 Y134.65 E.00542
G1 X140.95 Y134.35 E.01083
G1 X141.1 Y134.35 E.00542
G1 X141.1 Y134.05 E.01083
G1 X141.25 Y134.05 E.00542
G1 X141.25 Y133.6 E.01625
G1 X141.4 Y133.6 E.00542
G1 X141.4 Y133.3 E.01083
G1 X141.55 Y133.3 E.00542
G1 X141.55 Y132.85 E.01625
G1 X141.7 Y132.85 E.00542
G1 X141.7 Y132.55 E.01083
G1 X141.85 Y132.55 E.00542
G1 X141.85 Y132.1 E.01625
G1 X142 Y132.1 E.00542
G1 X142 Y131.5 E.02166
G1 X142.15 Y131.5 E.00542
G1 X142.15 Y130.9 E.02166
G1 X142.3 Y130.9 E.00542
G1 X142.3 Y130.15 E.02708
G1 X142.45 Y130.15 E.00542
G1 X142.45 Y129.1 E.03791
G1 X142.6 Y129.1 E.00542
G1 X142.6 Y126.9 E.07943
G1 X142.45 Y126.9 E.00542
G1 X142.45 Y125.85 E.03791
G1 X142.3 Y125.85 E.00542
G1 X142.3 Y125.1 E.02708
G1 X142.15 Y125.1 E.00542
G1 X142.15 Y124.5 E.02166
G1 X142 Y124.5 E.00542
G1 X142 Y123.9 E.02166
G1 X141.85 Y123.9 E.00542
G1 X141.85 Y123.45 E.01625
G1 X141.7 Y123.45 E.00542
G1 X141.7 Y123.15 E.01083
G1 X141.55 Y123.15 E.00542
G1 X141.55 Y122.7 E.01625
G1 X141.4 Y122.7 E.00542
G1 X141.4 Y122.4 E.01083
G1 X141.25 Y122.4 E.00542
G1 X141.25 Y121.95 E.01625
G1 X141.1 Y121.95 E.00542
G1 X141.1 Y121.65 E.01083
G1 X140.95 Y121.65 E.00542
G1 X140.95 Y121.35 E.01083
G1 X140.8 Y121.35 E.00542
G1 X140.8 Y121.2 E.00542
G1 X140.65 Y121.2 E.00542
G1 X140.65 Y120.9 E.01083
G1 X140.5 Y120.9 E.00542
G1 X140.5 Y120.6 E.01083
G1 X140.35 Y120.6 E.00542
G1 X140.35 Y120.45 E.00542
G1 X140.2 Y120.45 E.00542
G1 X140.2 Y120.15 E.01083
G1 X140.05 Y120.15 E.00542
G1 X140.05 Y119.85 E.01083
G1 X139.9 Y119.85 E.00542
G1 X139.9 Y119.7 E.00542
G1 X139.75 Y119.7 E.00542
G1 X139.75 Y119.55 E.00542
G1 X139.6 Y119.55 E.00542
G1 X139.6 Y119.25 E.01083
G1 X139.45 Y119.25 E.00542
G1 X139.45 Y119.1 E.00542
G1 X139.3 Y119.1 E.00542
G1 X139.3 Y118.95 E.00542
G1 X139.15 Y118.95 E.00542
G1 X139.15 Y118.8 E.00542
G1 X139 Y118.8 E.00542
G1 X139 Y118.5 E.01083
G1 X138.85 Y118.5 E.00542
G1 X138.85 Y118.35 E.00542
G1 X138.7 Y118.35 E.00542
G1 X138.7 Y118.2 E.00542
G1 X138.55 Y118.2 E.00542
G1 X138.55 Y118.05 E.00542
G1 X138.4 Y118.05 E.00542
G1 X138.4 Y117.9 E.00542
G1 X138.25 Y117.9 E.00542
G1 X138.25 Y117.75 E.00542
G1 X138.1 Y117.75 E.00542
G1 X138.1 Y117.6 E.00542
G1 X137.95 Y117.6 E.00542
G1 X137.95 Y117.45 E.00542
G1 X137.8 Y117.45 E.00542
G1 X137.8 Y117.3 E.00542
G1 X137.65 Y117.3 E.00542
G1 X137.65 Y117.15 E.00542
G1 X137.5 Y117.15 E.00542
G1 X137.5 Y117 E.00542
G1 X137.2 Y117 E.01083
G1 X137.2 Y116.85 E.00542
G1 X137.05 Y116.85 E.00542
G1 X137.05 Y116.7 E.00542
G1 X136.9 Y116.7 E.00542
G1 X136.9 Y116.55 E.00542
G1 X136.75 Y116.55 E.00542
G1 X136.75 Y116.4 E.00542
G1 X136.45 Y116.4 E.01083
G1 X136.45 Y116.25 E.00542
G1 X136.3 Y116.25 E.00542
G1 X136.3 Y116.1 E.00542
G1 X136.15 Y116.1 E.00542
G1 X136.15 Y115.95 E.00542
G1 X135.85 Y115.95 E.01083
G1 X135.85 Y115.8 E.00542
G1 X135.55 Y115.8 E.01083
G1 X135.55 Y115.65 E.00542
G1 X135.4 Y115.65 E.00542
G1 X135.4 Y115.5 E.00542
G1 X135.1 Y115.5 E.01083
G1 X135.1 Y115.35 E.00542
G1 X134.8 Y115.35 E.01083
G1 X134.8 Y115.2 E.00542
G1 X134.65 Y115.2 E.00542
G1 X134.65 Y115.05 E.00542
G1 X134.35 Y115.05 E.01083
G1 X134.35 Y114.9 E.00542
G1 X134.05 Y114.9 E.01083
G1 X134.05 Y114.75 E.00542
G1 X133.6 Y114.75 E.01625
G1 X133.6 Y114.6 E.00542
G1 X133.3 Y114.6 E.01083
G1 X133.3 Y114.45 E.00542
G1 X132.85 Y114.45 E.01625
G1 X132.85 Y114.3 E.00542
G1 X132.55 Y114.3 E.01083
G1 X132.55 Y114.15 E.00542
G1 X132.1 Y114.15 E.01625
G1 X132.1 Y114 E.00542
G1 X131.5 Y114 E.02166
G1 X131.5 Y113.85 E.00542
G1 X130.9 Y113.85 E.02166
G1 X130.9 Y113.7 E.00542
G1 X130.15 Y113.7 E.02708
G1 X130.15 Y113.55 E.00542
G1 X129.1 Y113.55 E.03791
G1 X129.1 Y113.4 E.00542
G1 X126.9 Y113.4 E.07943
G1 X126.9 Y113.55 E.00542
G1 X125.85 Y113.55 E.03791
G1 X125.85 Y113.7 E.00542
G1 X125.1 Y113.7 E.02708
G1 X125.1 Y113.85 E.00542
G1 X124.5 Y113.85 E.02166
G1 X124.5 Y114 E.00542
G1 X123.9 Y114 E.02166
G1 X123.9 Y114.15 E.00542
G1 X123.45 Y114.15 E.01625
G1 X123.45 Y114.3 E.00542
G1 X123.15 Y114.3 E.01083
G1 X123.15 Y114.45 E.00542
M73 P74 R2
G1 X122.7 Y114.45 E.01625
G1 X122.7 Y114.6 E.00542
G1 X122.4 Y114.6 E.01083
G1 X122.4 Y114.75 E.00542
G1 X121.95 Y114.75 E.01625
G1 X121.95 Y114.9 E.00542
G1 X121.65 Y114.9 E.01083
G1 X121.65 Y115.05 E.00542
G1 X121.35 Y115.05 E.01083
G1 X121.35 Y115.2 E.00542
G1 X121.2 Y115.2 E.00542
G1 X121.2 Y115.35 E.00542
G1 X120.9 Y115.35 E.01083
G1 X120.9 Y115.5 E.00542
G1 X120.6 Y115.5 E.01083
G1 X120.6 Y115.65 E.00542
G1 X120.45 Y115.65 E.00542
G1 X120.45 Y115.8 E.00542
G1 X120.15 Y115.8 E.01083
G1 X120.15 Y115.95 E.00542
G1 X119.85 Y115.95 E.01083
G1 X119.85 Y116.1 E.00542
G1 X119.7 Y116.1 E.00542
G1 X119.7 Y116.25 E.00542
G1 X119.55 Y116.25 E.00542
G1 X119.55 Y116.4 E.00542
G1 X119.25 Y116.4 E.01083
G1 X119.25 Y116.55 E.00542
G1 X119.1 Y116.55 E.00542
G1 X119.1 Y116.7 E.00542
G1 X118.95 Y116.7 E.00542
G1 X118.95 Y116.85 E.00542
G1 X118.8 Y116.85 E.00542
G1 X118.8 Y117 E.00542
G1 X118.5 Y117 E.01083
G1 X118.5 Y117.15 E.00542
G1 X118.35 Y117.15 E.00542
G1 X118.35 Y117.3 E.00542
G1 X118.2 Y117.3 E.00542
G1 X118.2 Y117.45 E.00542
G1 X118.05 Y117.45 E.00542
G1 X118.05 Y117.6 E.00542
G1 X117.9 Y117.6 E.00542
G1 X117.9 Y117.75 E.00542
G1 X117.75 Y117.75 E.00542
G1 X117.75 Y117.9 E.00542
G1 X117.6 Y117.9 E.00542
G1 X117.6 Y118.05 E.00542
G1 X117.45 Y118.05 E.00542
G1 X117.45 Y118.2 E.00542
G1 X117.3 Y118.2 E.00542
G1 X117.3 Y118.35 E.00542
G1 X117.15 Y118.35 E.00542
G1 X117.15 Y118.5 E.00542
G1 X117 Y118.5 E.00542
G1 X117 Y118.8 E.01083
G1 X116.85 Y118.8 E.00542
G1 X116.85 Y118.95 E.00542
G1 X116.7 Y118.95 E.00542
G1 X116.7 Y119.1 E.00542
G1 X116.55 Y119.1 E.00542
G1 X116.55 Y119.25 E.00542
G1 X116.4 Y119.25 E.00542
G1 X116.4 Y119.55 E.01083
G1 X116.25 Y119.55 E.00542
G1 X116.25 Y119.7 E.00542
G1 X116.1 Y119.7 E.00542
G1 X116.1 Y119.85 E.00542
G1 X115.95 Y119.85 E.00542
G1 X115.95 Y120.15 E.01083
G1 X115.8 Y120.15 E.00542
G1 X115.8 Y120.45 E.01083
G1 X115.65 Y120.45 E.00542
G1 X115.65 Y120.6 E.00542
G1 X115.5 Y120.6 E.00542
G1 X115.5 Y120.9 E.01083
G1 X115.35 Y120.9 E.00542
G1 X115.35 Y121.2 E.01083
G1 X115.2 Y121.2 E.00542
G1 X115.2 Y121.35 E.00542
G1 X115.05 Y121.35 E.00542
G1 X115.05 Y121.65 E.01083
G1 X114.9 Y121.65 E.00542
G1 X114.9 Y121.95 E.01083
G1 X114.75 Y121.95 E.00542
G1 X114.75 Y122.4 E.01625
G1 X114.6 Y122.4 E.00542
G1 X114.6 Y122.7 E.01083
G1 X114.45 Y122.7 E.00542
G1 X114.45 Y123.15 E.01625
G1 X114.3 Y123.15 E.00542
G1 X114.3 Y123.45 E.01083
G1 X114.15 Y123.45 E.00542
G1 X114.15 Y123.9 E.01625
G1 X114 Y123.9 E.00542
G1 X114 Y124.5 E.02166
G1 X113.85 Y124.5 E.00542
G1 X113.85 Y125.1 E.02166
G1 X113.7 Y125.1 E.00542
G1 X113.7 Y125.85 E.02708
G1 X113.55 Y125.85 E.00542
G1 X113.55 Y126.9 E.03791
G1 X113.4 Y126.9 E.00542
G1 X113.4 Y129.1 E.07943
G1 X113.55 Y129.1 E.00542
G1 X113.55 Y130.15 E.03791
G1 X113.7 Y130.15 E.00542
G1 X113.7 Y130.9 E.02708
G1 X113.85 Y130.9 E.00542
G1 X113.85 Y131.5 E.02166
G1 X114 Y131.5 E.00542
G1 X114 Y132.1 E.02166
G1 X114.15 Y132.1 E.00542
G1 X114.15 Y132.55 E.01625
G1 X114.3 Y132.55 E.00542
G1 X114.3 Y132.85 E.01083
G1 X114.45 Y132.85 E.00542
G1 X114.45 Y133.3 E.01625
G1 X114.6 Y133.3 E.00542
G1 X114.6 Y133.6 E.01083
G1 X114.75 Y133.6 E.00542
G1 X114.75 Y134.05 E.01625
G1 X114.9 Y134.05 E.00542
G1 X114.9 Y134.35 E.01083
G1 X115.05 Y134.35 E.00542
G1 X115.05 Y134.65 E.01083
G1 X115.2 Y134.65 E.00542
G1 X115.2 Y134.8 E.00542
G1 X115.35 Y134.8 E.00542
G1 X115.35 Y135.1 E.01083
G1 X115.5 Y135.1 E.00542
G1 X115.5 Y135.4 E.01083
G1 X115.65 Y135.4 E.00542
G1 X115.65 Y135.55 E.00542
G1 X115.8 Y135.55 E.00542
G1 X115.8 Y135.85 E.01083
G1 X115.95 Y135.85 E.00542
G1 X115.95 Y136.15 E.01083
G1 X116.1 Y136.15 E.00542
G1 X116.1 Y136.3 E.00542
G1 X116.19 Y136.3 E.00325
; WIPE_START
G1 X116.25 Y136.45 E-.06139
G1 X116.4 Y136.45 E-.057
G1 X116.4 Y136.75 E-.114
G1 X116.55 Y136.75 E-.057
G1 X116.55 Y136.9 E-.057
G1 X116.7 Y136.9 E-.057
G1 X116.7 Y137.05 E-.057
G1 X116.85 Y137.05 E-.057
G1 X116.85 Y137.2 E-.057
G1 X117 Y137.2 E-.057
G1 X117 Y137.5 E-.114
G1 X117.038 Y137.5 E-.01461
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X121.811 Y131.544 Z.6 F36000
G1 X134.276 Y115.99 Z.6
G1 Z.2
G1 E.8 F1800
; FEATURE: Bottom surface
; LINE_WIDTH: 0.50471
G1 F6300
M204 S500
G1 X140.01 Y121.724 E.2958
; WIPE_START
G1 X138.596 Y120.31 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X140.61 Y122.977 Z.6 F36000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X133.379 Y115.746 E.37305
G1 X133.204 Y115.746 E.00636
G1 X133.204 Y115.596 E.00547
G1 X132.754 Y115.596 E.01642
G1 X132.754 Y115.446 E.00547
G1 X132.454 Y115.446 E.01094
G1 X132.454 Y115.296 E.00547
G1 X132.276 Y115.296 E.00652
G1 X141.06 Y124.08 E.45317
M204 S6000
G1 X141.36 Y125.033 F36000
G1 F6300
M204 S500
G1 X131.173 Y114.846 E.52555
G1 X130.654 Y114.846 E.0189
G1 X130.654 Y114.696 E.00547
G1 X130.37 Y114.696 E.01039
G1 X141.304 Y125.63 E.56411
G1 X141.304 Y125.946 E.01149
G1 X141.454 Y125.946 E.00547
G1 X141.454 Y126.434 E.0178
G1 X129.566 Y114.546 E.61327
G1 X129.304 Y114.546 E.00956
G1 X129.304 Y114.396 E.00547
G1 X128.763 Y114.396 E.01974
G1 X141.604 Y127.237 E.66244
G1 X141.604 Y127.746 E.01857
G1 X141.754 Y127.746 E.00547
G1 X141.754 Y128.04 E.01073
G1 X127.96 Y114.246 E.71161
G1 X127.746 Y114.246 E.00783
M73 P75 R2
G1 X127.746 Y114.396 E.00547
G1 X127.457 Y114.396 E.01052
G1 X141.604 Y128.543 E.72982
G1 X141.604 Y129.196 E.02382
G1 X126.804 Y114.396 E.76351
G1 X126.696 Y114.396 E.00396
G1 X126.696 Y114.546 E.00547
G1 X126.301 Y114.546 E.01439
G1 X141.454 Y129.699 E.78173
G1 X141.454 Y130.054 E.01297
G1 X141.304 Y130.054 E.00547
G1 X141.304 Y130.202 E.00538
G1 X125.798 Y114.696 E.79994
G1 X125.346 Y114.696 E.01651
G1 X125.346 Y114.846 E.00547
G1 X125.295 Y114.846 E.00185
G1 X141.154 Y130.705 E.81815
G1 X141.154 Y131.254 E.02004
G1 X141.051 Y131.254 E.00378
G1 X124.746 Y114.949 E.84115
G1 X124.746 Y114.996 E.00169
G1 X124.296 Y114.996 E.01641
G1 X124.289 Y115.146 E.00548
G1 X140.854 Y131.711 E.85458
G1 X140.854 Y132.004 E.0107
G1 X140.704 Y132.004 E.00547
G1 X140.704 Y132.214 E.00765
G1 X123.786 Y115.296 E.8728
G1 X123.546 Y115.296 E.00876
G1 X123.546 Y115.446 E.00547
G1 X123.283 Y115.446 E.00959
G1 X140.554 Y132.717 E.89101
G1 X140.554 Y132.754 E.00135
G1 X140.404 Y132.754 E.00547
G1 X140.404 Y133.204 E.01642
G1 X140.389 Y133.204 E.00058
G1 X122.796 Y115.611 E.90758
G1 X122.796 Y115.746 E.00489
G1 X122.496 Y115.746 E.01094
G1 X122.496 Y115.896 E.00547
G1 X122.427 Y115.896 E.00252
G1 X140.104 Y133.573 E.91196
G1 X140.104 Y133.804 E.00843
G1 X139.954 Y133.804 E.00547
G1 X139.954 Y133.954 E.00547
G1 X139.832 Y133.954 E.00445
G1 X122.046 Y116.168 E.91758
G1 X122.046 Y116.196 E.00102
G1 X121.746 Y116.196 E.01094
G1 X121.746 Y116.346 E.00547
G1 X121.57 Y116.346 E.00639
G1 X139.654 Y134.43 E.93292
G1 X139.654 Y134.554 E.00455
G1 X139.504 Y134.554 E.00547
G1 X139.504 Y134.704 E.00547
G1 X139.354 Y134.704 E.00547
M73 P76 R2
G1 X139.354 Y134.783 E.00285
G1 X121.217 Y116.646 E.93565
G1 X120.996 Y116.646 E.00809
G1 X120.996 Y116.796 E.00547
G1 X120.714 Y116.796 E.01026
G1 X139.204 Y135.286 E.95387
G1 X139.204 Y135.304 E.00068
G1 X139.054 Y135.304 E.00547
G1 X139.054 Y135.454 E.00547
G1 X138.904 Y135.454 E.00547
G1 X138.904 Y135.604 E.00547
G1 X138.87 Y135.604 E.00125
G1 X120.396 Y117.13 E.95306
G1 X120.396 Y117.246 E.00422
G1 X120.096 Y117.246 E.01094
G1 X120.096 Y117.396 E.00547
G1 X120.008 Y117.396 E.00319
G1 X138.604 Y135.992 E.95934
G1 X138.604 Y136.054 E.00228
G1 X138.454 Y136.054 E.00547
G1 X138.454 Y136.204 E.00547
G1 X138.304 Y136.204 E.00547
G1 X138.304 Y136.345 E.00512
G1 X119.655 Y117.696 E.96208
G1 X119.646 Y117.846 E.00548
G1 X119.346 Y117.846 E.01094
G1 X119.346 Y117.996 E.00547
G1 X119.302 Y117.996 E.00159
G1 X138.004 Y136.698 E.96482
G1 X138.004 Y136.804 E.00388
G1 X137.854 Y136.804 E.00547
G1 X137.854 Y136.954 E.00547
G1 X137.704 Y136.954 E.00547
G1 X137.704 Y137.051 E.00352
G1 X118.949 Y118.296 E.96756
G1 X118.896 Y118.296 E.00195
G1 X118.896 Y118.446 E.00547
G1 X118.746 Y118.446 E.00547
G1 X118.746 Y118.596 E.00547
G1 X118.596 Y118.596 E.00546
G1 X137.404 Y137.404 E.97029
G1 X137.254 Y137.404 E.00547
G1 X137.254 Y137.554 E.00547
G1 X137.104 Y137.554 E.00547
G1 X137.104 Y137.704 E.00547
G1 X137.052 Y137.704 E.00192
G1 X118.296 Y118.948 E.96759
G1 X118.296 Y119.046 E.00355
G1 X118.146 Y119.046 E.00547
G1 X118.146 Y119.196 E.00547
G1 X117.996 Y119.196 E.00547
G1 X117.996 Y119.301 E.00386
G1 X136.699 Y138.004 E.96485
G1 X136.654 Y138.004 E.00161
G1 X136.654 Y138.154 E.00547
G1 X136.354 Y138.154 E.01094
G1 X136.346 Y138.304 E.00548
G1 X117.696 Y119.654 E.96211
G1 X117.696 Y119.796 E.00515
G1 X117.546 Y119.796 E.00547
G1 X117.546 Y119.946 E.00547
G1 X117.396 Y119.946 E.00547
G1 X117.396 Y120.008 E.00226
G1 X135.992 Y138.604 E.95937
G1 X135.904 Y138.604 E.00321
G1 X135.904 Y138.754 E.00547
G1 X135.604 Y138.754 E.01094
M73 P77 R2
G1 X135.604 Y138.869 E.0042
G1 X117.131 Y120.396 E.95303
G1 X117.096 Y120.396 E.00128
G1 X117.096 Y120.546 E.00547
G1 X116.946 Y120.546 E.00547
G1 X116.946 Y120.696 E.00547
G1 X116.796 Y120.696 E.00547
G1 X116.796 Y120.714 E.00066
G1 X135.286 Y139.204 E.9539
G1 X135.004 Y139.204 E.01028
G1 X135.004 Y139.354 E.00547
G1 X134.783 Y139.354 E.00807
G1 X116.646 Y121.217 E.93568
G1 X116.646 Y121.296 E.00288
G1 X116.496 Y121.296 E.00547
G1 X116.496 Y121.446 E.00547
G1 X116.346 Y121.446 E.00547
G1 X116.346 Y121.57 E.00453
G1 X134.43 Y139.654 E.93295
G1 X134.254 Y139.654 E.00641
G1 X134.254 Y139.804 E.00547
G1 X133.954 Y139.804 E.01094
G1 X133.954 Y139.832 E.001
G1 X116.168 Y122.046 E.91755
G1 X116.046 Y122.046 E.00447
G1 X116.046 Y122.196 E.00547
G1 X115.896 Y122.196 E.00547
G1 X115.896 Y122.426 E.0084
G1 X133.574 Y140.104 E.91199
G1 X133.504 Y140.104 E.00254
G1 X133.504 Y140.254 E.00547
G1 X133.204 Y140.254 E.01094
G1 X133.204 Y140.388 E.00487
G1 X115.596 Y122.796 E.90798
G1 X115.596 Y123.246 E.01642
G1 X115.446 Y123.246 E.00547
G1 X115.446 Y123.282 E.00133
G1 X132.718 Y140.554 E.89104
G1 X132.454 Y140.554 E.00961
G1 X132.454 Y140.704 E.00547
G1 X132.215 Y140.704 E.00874
G1 X115.296 Y123.785 E.87283
G1 X115.296 Y123.996 E.00767
G1 X115.146 Y123.996 E.00547
G1 X115.146 Y124.288 E.01068
G1 X131.712 Y140.854 E.85461
G1 X131.704 Y141.004 E.00548
G1 X131.254 Y141.004 E.01641
G1 X131.254 Y141.05 E.00167
G1 X114.95 Y124.746 E.84112
G1 X114.846 Y124.746 E.0038
G1 X114.846 Y125.294 E.02002
G1 X130.706 Y141.154 E.81818
G1 X130.654 Y141.154 E.00187
G1 X130.654 Y141.304 E.00547
G1 X130.203 Y141.304 E.01648
G1 X114.696 Y125.797 E.79997
G1 X114.696 Y125.946 E.0054
M73 P78 R2
G1 X114.546 Y125.946 E.00547
G1 X114.546 Y126.301 E.01295
G1 X129.699 Y141.454 E.78176
G1 X129.304 Y141.454 E.01441
G1 X129.304 Y141.604 E.00547
G1 X129.196 Y141.604 E.00394
G1 X114.396 Y126.804 E.76354
G1 X114.396 Y127.457 E.02382
G1 X128.543 Y141.604 E.72985
G1 X128.254 Y141.604 E.01054
G1 X128.254 Y141.754 E.00547
G1 X128.04 Y141.754 E.00781
G1 X114.246 Y127.96 E.71164
G1 X114.246 Y128.254 E.01075
G1 X114.396 Y128.254 E.00547
G1 X114.396 Y128.763 E.01855
G1 X127.237 Y141.604 E.66247
G1 X126.696 Y141.604 E.01976
G1 X126.696 Y141.454 E.00547
G1 X126.434 Y141.454 E.00954
G1 X114.546 Y129.566 E.6133
G1 X114.546 Y130.054 E.01782
G1 X114.696 Y130.054 E.00547
G1 X114.696 Y130.369 E.01147
G1 X125.631 Y141.304 E.56414
G1 X125.346 Y141.304 E.01041
G1 X125.346 Y141.154 E.00547
G1 X124.828 Y141.154 E.01888
G1 X114.64 Y130.966 E.52558
M204 S6000
G1 X114.94 Y131.919 F36000
G1 F6300
M204 S500
G1 X123.725 Y140.704 E.4532
G1 X123.546 Y140.704 E.00654
G1 X123.546 Y140.554 E.00547
G1 X123.246 Y140.554 E.01094
G1 X123.246 Y140.404 E.00547
G1 X122.796 Y140.404 E.01642
G1 X122.796 Y140.254 E.00547
G1 X122.622 Y140.254 E.00634
G1 X115.39 Y133.022 E.37308
; WIPE_START
G1 X116.804 Y134.437 E-.76
; WIPE_END
G1 E-.04 F1800
M204 S6000
G1 X115.99 Y134.276 Z.6 F36000
G1 Z.2
G1 E.8 F1800
G1 F6300
M204 S500
G1 X121.724 Y140.01 E.29583
; CHANGE_LAYER
; Z_HEIGHT: 0.4
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F6300
G1 X120.31 Y138.596 E-.76
; WIPE_END
G1 E-.04 F1800
;======== P2S layer_change gcode ==========
;===== 2026/05/15 ====





    

    M622.1 S0
    M1002 judge_flag ventobox_replace_aux1_fan_flag
    M622 J0
    M106 P10 S0; set first x_layer left aux fan
    M623
;not reset fan


; update layer progress
M73 L2
M991 S0 P1 ;notify layer change


; open powerlost recovery
M1003 S1
M204 S10000
G17
G3 Z.6 I1.217 J0 P1  F36000
;======== P2S timelapes gcode ==========
;===== 2025/06/16 ====
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
  M971 S11 C10 O0
  M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 175
G1 X116.413 Y136.098
G1 Z.4
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X116.452 Y136.098 E.00127
G1 X116.452 Y136.248 E.00482
G1 X116.602 Y136.248 E.00482
G1 X116.602 Y136.548 E.00965
G1 X116.752 Y136.548 E.00482
G1 X116.752 Y136.698 E.00482
G1 X116.902 Y136.698 E.00482
G1 X116.902 Y136.848 E.00482
G1 X117.052 Y136.848 E.00482
G1 X117.052 Y136.998 E.00482
G1 X117.202 Y136.998 E.00482
G1 X117.202 Y137.298 E.00965
G1 X117.352 Y137.298 E.00482
G1 X117.352 Y137.448 E.00482
G1 X117.502 Y137.448 E.00482
G1 X117.502 Y137.598 E.00482
G1 X117.652 Y137.598 E.00482
G1 X117.652 Y137.748 E.00482
G1 X117.802 Y137.748 E.00482
G1 X117.802 Y137.898 E.00482
G1 X117.952 Y137.898 E.00482
G1 X117.952 Y138.048 E.00482
G1 X118.102 Y138.048 E.00482
G1 X118.102 Y138.198 E.00482
G1 X118.252 Y138.198 E.00482
G1 X118.252 Y138.348 E.00482
G1 X118.402 Y138.348 E.00482
G1 X118.402 Y138.498 E.00482
G1 X118.552 Y138.498 E.00482
G1 X118.552 Y138.648 E.00482
G1 X118.702 Y138.648 E.00482
G1 X118.702 Y138.798 E.00482
G1 X119.002 Y138.798 E.00965
G1 X119.002 Y138.948 E.00482
G1 X119.152 Y138.948 E.00482
G1 X119.152 Y139.098 E.00482
G1 X119.302 Y139.098 E.00482
G1 X119.302 Y139.248 E.00482
G1 X119.452 Y139.248 E.00482
G1 X119.452 Y139.398 E.00482
G1 X119.752 Y139.398 E.00965
G1 X119.752 Y139.548 E.00482
G1 X119.902 Y139.548 E.00482
G1 X119.902 Y139.698 E.00482
G1 X120.052 Y139.698 E.00482
G1 X120.052 Y139.848 E.00482
G1 X120.352 Y139.848 E.00965
G1 X120.352 Y139.998 E.00482
G1 X120.652 Y139.998 E.00965
G1 X120.652 Y140.148 E.00482
G1 X120.802 Y140.148 E.00482
G1 X120.802 Y140.298 E.00482
G1 X121.102 Y140.298 E.00965
G1 X121.102 Y140.448 E.00482
G1 X121.402 Y140.448 E.00965
G1 X121.402 Y140.598 E.00482
G1 X121.552 Y140.598 E.00482
G1 X121.552 Y140.748 E.00482
G1 X121.852 Y140.748 E.00965
G1 X121.852 Y140.898 E.00482
G1 X122.152 Y140.898 E.00965
G1 X122.152 Y141.048 E.00482
G1 X122.602 Y141.048 E.01447
G1 X122.602 Y141.198 E.00482
G1 X122.902 Y141.198 E.00965
G1 X122.902 Y141.348 E.00482
G1 X123.352 Y141.348 E.01447
G1 X123.352 Y141.498 E.00482
G1 X123.652 Y141.498 E.00965
G1 X123.652 Y141.648 E.00482
G1 X124.102 Y141.648 E.01447
G1 X124.102 Y141.798 E.00482
G1 X124.702 Y141.798 E.01929
G1 X124.702 Y141.948 E.00482
G1 X125.302 Y141.948 E.01929
G1 X125.302 Y142.098 E.00482
G1 X126.052 Y142.098 E.02412
G1 X126.052 Y142.248 E.00482
G1 X127.102 Y142.248 E.03376
G1 X127.102 Y142.398 E.00482
G1 X128.898 Y142.398 E.05775
G1 X128.898 Y142.248 E.00482
G1 X129.948 Y142.248 E.03376
G1 X129.948 Y142.098 E.00482
G1 X130.698 Y142.098 E.02412
G1 X130.698 Y141.948 E.00482
G1 X131.298 Y141.948 E.01929
G1 X131.298 Y141.798 E.00482
M73 P79 R2
G1 X131.898 Y141.798 E.01929
G1 X131.898 Y141.648 E.00482
G1 X132.348 Y141.648 E.01447
G1 X132.348 Y141.498 E.00482
G1 X132.648 Y141.498 E.00965
G1 X132.648 Y141.348 E.00482
G1 X133.098 Y141.348 E.01447
G1 X133.098 Y141.198 E.00482
G1 X133.398 Y141.198 E.00965
G1 X133.398 Y141.048 E.00482
G1 X133.848 Y141.048 E.01447
G1 X133.848 Y140.898 E.00482
G1 X134.148 Y140.898 E.00965
G1 X134.148 Y140.748 E.00482
G1 X134.448 Y140.748 E.00965
G1 X134.448 Y140.598 E.00482
G1 X134.598 Y140.598 E.00482
G1 X134.598 Y140.448 E.00482
G1 X134.898 Y140.448 E.00965
G1 X134.898 Y140.298 E.00482
G1 X135.198 Y140.298 E.00965
G1 X135.198 Y140.148 E.00482
G1 X135.348 Y140.148 E.00482
G1 X135.348 Y139.998 E.00482
G1 X135.648 Y139.998 E.00965
G1 X135.648 Y139.848 E.00482
G1 X135.948 Y139.848 E.00965
G1 X135.948 Y139.698 E.00482
G1 X136.098 Y139.698 E.00482
G1 X136.098 Y139.548 E.00482
G1 X136.248 Y139.548 E.00482
G1 X136.248 Y139.398 E.00482
G1 X136.548 Y139.398 E.00965
G1 X136.548 Y139.248 E.00482
G1 X136.698 Y139.248 E.00482
G1 X136.698 Y139.098 E.00482
G1 X136.848 Y139.098 E.00482
G1 X136.848 Y138.948 E.00482
G1 X136.998 Y138.948 E.00482
G1 X136.998 Y138.798 E.00482
G1 X137.298 Y138.798 E.00965
G1 X137.298 Y138.648 E.00482
G1 X137.448 Y138.648 E.00482
G1 X137.448 Y138.498 E.00482
G1 X137.598 Y138.498 E.00482
G1 X137.598 Y138.348 E.00482
G1 X137.748 Y138.348 E.00482
G1 X137.748 Y138.198 E.00482
G1 X137.898 Y138.198 E.00482
G1 X137.898 Y138.048 E.00482
G1 X138.048 Y138.048 E.00482
G1 X138.048 Y137.898 E.00482
G1 X138.198 Y137.898 E.00482
G1 X138.198 Y137.748 E.00482
G1 X138.348 Y137.748 E.00482
G1 X138.348 Y137.598 E.00482
G1 X138.498 Y137.598 E.00482
G1 X138.498 Y137.448 E.00482
G1 X138.648 Y137.448 E.00482
G1 X138.648 Y137.298 E.00482
G1 X138.798 Y137.298 E.00482
G1 X138.798 Y136.998 E.00965
G1 X138.948 Y136.998 E.00482
G1 X138.948 Y136.848 E.00482
G1 X139.098 Y136.848 E.00482
G1 X139.098 Y136.698 E.00482
G1 X139.248 Y136.698 E.00482
G1 X139.248 Y136.548 E.00482
G1 X139.398 Y136.548 E.00482
G1 X139.398 Y136.248 E.00965
G1 X139.548 Y136.248 E.00482
G1 X139.548 Y136.098 E.00482
G1 X139.698 Y136.098 E.00482
G1 X139.698 Y135.948 E.00482
G1 X139.848 Y135.948 E.00482
G1 X139.848 Y135.648 E.00965
G1 X139.998 Y135.648 E.00482
G1 X139.998 Y135.348 E.00965
G1 X140.148 Y135.348 E.00482
G1 X140.148 Y135.198 E.00482
G1 X140.298 Y135.198 E.00482
G1 X140.298 Y134.898 E.00965
G1 X140.448 Y134.898 E.00482
G1 X140.448 Y134.598 E.00965
G1 X140.598 Y134.598 E.00482
G1 X140.598 Y134.448 E.00482
G1 X140.748 Y134.448 E.00482
G1 X140.748 Y134.148 E.00965
G1 X140.898 Y134.148 E.00482
G1 X140.898 Y133.848 E.00965
G1 X141.048 Y133.848 E.00482
G1 X141.048 Y133.398 E.01447
G1 X141.198 Y133.398 E.00482
G1 X141.198 Y133.098 E.00965
G1 X141.348 Y133.098 E.00482
G1 X141.348 Y132.648 E.01447
G1 X141.498 Y132.648 E.00482
G1 X141.498 Y132.348 E.00965
G1 X141.648 Y132.348 E.00482
G1 X141.648 Y131.898 E.01447
G1 X141.798 Y131.898 E.00482
G1 X141.798 Y131.298 E.01929
G1 X141.948 Y131.298 E.00482
G1 X141.948 Y130.698 E.01929
G1 X142.098 Y130.698 E.00482
G1 X142.098 Y129.948 E.02412
G1 X142.248 Y129.948 E.00482
G1 X142.248 Y128.898 E.03376
G1 X142.398 Y128.898 E.00482
G1 X142.398 Y127.102 E.05775
G1 X142.248 Y127.102 E.00482
G1 X142.248 Y126.052 E.03376
G1 X142.098 Y126.052 E.00482
G1 X142.098 Y125.302 E.02412
G1 X141.948 Y125.302 E.00482
G1 X141.948 Y124.702 E.01929
G1 X141.798 Y124.702 E.00482
G1 X141.798 Y124.102 E.01929
G1 X141.648 Y124.102 E.00482
G1 X141.648 Y123.652 E.01447
G1 X141.498 Y123.652 E.00482
G1 X141.498 Y123.352 E.00965
G1 X141.348 Y123.352 E.00482
G1 X141.348 Y122.902 E.01447
G1 X141.198 Y122.902 E.00482
G1 X141.198 Y122.602 E.00965
G1 X141.048 Y122.602 E.00482
G1 X141.048 Y122.152 E.01447
G1 X140.898 Y122.152 E.00482
G1 X140.898 Y121.852 E.00965
G1 X140.748 Y121.852 E.00482
G1 X140.748 Y121.552 E.00965
G1 X140.598 Y121.552 E.00482
G1 X140.598 Y121.402 E.00482
G1 X140.448 Y121.402 E.00482
G1 X140.448 Y121.102 E.00965
G1 X140.298 Y121.102 E.00482
G1 X140.298 Y120.802 E.00965
G1 X140.148 Y120.802 E.00482
G1 X140.148 Y120.652 E.00482
G1 X139.998 Y120.652 E.00482
G1 X139.998 Y120.352 E.00965
G1 X139.848 Y120.352 E.00482
G1 X139.848 Y120.052 E.00965
G1 X139.698 Y120.052 E.00482
G1 X139.698 Y119.902 E.00482
G1 X139.548 Y119.902 E.00482
G1 X139.548 Y119.752 E.00482
G1 X139.398 Y119.752 E.00482
G1 X139.398 Y119.452 E.00965
G1 X139.248 Y119.452 E.00482
G1 X139.248 Y119.302 E.00482
G1 X139.098 Y119.302 E.00482
G1 X139.098 Y119.152 E.00482
G1 X138.948 Y119.152 E.00482
G1 X138.948 Y119.002 E.00482
G1 X138.798 Y119.002 E.00482
G1 X138.798 Y118.702 E.00965
G1 X138.648 Y118.702 E.00482
G1 X138.648 Y118.552 E.00482
G1 X138.498 Y118.552 E.00482
G1 X138.498 Y118.402 E.00482
G1 X138.348 Y118.402 E.00482
G1 X138.348 Y118.252 E.00482
G1 X138.198 Y118.252 E.00482
G1 X138.198 Y118.102 E.00482
G1 X138.048 Y118.102 E.00482
G1 X138.048 Y117.952 E.00482
G1 X137.898 Y117.952 E.00482
G1 X137.898 Y117.802 E.00482
G1 X137.748 Y117.802 E.00482
G1 X137.748 Y117.652 E.00482
G1 X137.598 Y117.652 E.00482
G1 X137.598 Y117.502 E.00482
G1 X137.448 Y117.502 E.00482
G1 X137.448 Y117.352 E.00482
G1 X137.298 Y117.352 E.00482
G1 X137.298 Y117.202 E.00482
G1 X136.998 Y117.202 E.00965
G1 X136.998 Y117.052 E.00482
G1 X136.848 Y117.052 E.00482
G1 X136.848 Y116.902 E.00482
G1 X136.698 Y116.902 E.00482
G1 X136.698 Y116.752 E.00482
G1 X136.548 Y116.752 E.00482
G1 X136.548 Y116.602 E.00482
G1 X136.248 Y116.602 E.00965
G1 X136.248 Y116.452 E.00482
G1 X136.098 Y116.452 E.00482
G1 X136.098 Y116.302 E.00482
G1 X135.948 Y116.302 E.00482
G1 X135.948 Y116.152 E.00482
G1 X135.648 Y116.152 E.00965
G1 X135.648 Y116.002 E.00482
G1 X135.348 Y116.002 E.00965
G1 X135.348 Y115.852 E.00482
G1 X135.198 Y115.852 E.00482
G1 X135.198 Y115.702 E.00482
G1 X134.898 Y115.702 E.00965
G1 X134.898 Y115.552 E.00482
G1 X134.598 Y115.552 E.00965
G1 X134.598 Y115.402 E.00482
G1 X134.448 Y115.402 E.00482
G1 X134.448 Y115.252 E.00482
G1 X134.148 Y115.252 E.00965
G1 X134.148 Y115.102 E.00482
G1 X133.848 Y115.102 E.00965
G1 X133.848 Y114.952 E.00482
G1 X133.398 Y114.952 E.01447
G1 X133.398 Y114.802 E.00482
G1 X133.098 Y114.802 E.00965
G1 X133.098 Y114.652 E.00482
G1 X132.648 Y114.652 E.01447
G1 X132.648 Y114.502 E.00482
G1 X132.348 Y114.502 E.00965
G1 X132.348 Y114.352 E.00482
G1 X131.898 Y114.352 E.01447
G1 X131.898 Y114.202 E.00482
G1 X131.298 Y114.202 E.01929
G1 X131.298 Y114.052 E.00482
G1 X130.698 Y114.052 E.01929
G1 X130.698 Y113.902 E.00482
G1 X129.948 Y113.902 E.02412
G1 X129.948 Y113.752 E.00482
G1 X128.898 Y113.752 E.03376
G1 X128.898 Y113.602 E.00482
G1 X127.102 Y113.602 E.05775
G1 X127.102 Y113.752 E.00482
G1 X126.052 Y113.752 E.03376
G1 X126.052 Y113.902 E.00482
G1 X125.302 Y113.902 E.02412
G1 X125.302 Y114.052 E.00482
G1 X124.702 Y114.052 E.01929
G1 X124.702 Y114.202 E.00482
G1 X124.102 Y114.202 E.01929
G1 X124.102 Y114.352 E.00482
G1 X123.652 Y114.352 E.01447
G1 X123.652 Y114.502 E.00482
G1 X123.352 Y114.502 E.00965
G1 X123.352 Y114.652 E.00482
G1 X122.902 Y114.652 E.01447
G1 X122.902 Y114.802 E.00482
G1 X122.602 Y114.802 E.00965
G1 X122.602 Y114.952 E.00482
G1 X122.152 Y114.952 E.01447
G1 X122.152 Y115.102 E.00482
G1 X121.852 Y115.102 E.00965
G1 X121.852 Y115.252 E.00482
G1 X121.552 Y115.252 E.00965
G1 X121.552 Y115.402 E.00482
G1 X121.402 Y115.402 E.00482
G1 X121.402 Y115.552 E.00482
G1 X121.102 Y115.552 E.00965
G1 X121.102 Y115.702 E.00482
G1 X120.802 Y115.702 E.00965
G1 X120.802 Y115.852 E.00482
G1 X120.652 Y115.852 E.00482
G1 X120.652 Y116.002 E.00482
G1 X120.352 Y116.002 E.00965
G1 X120.352 Y116.152 E.00482
G1 X120.052 Y116.152 E.00965
G1 X120.052 Y116.302 E.00482
G1 X119.902 Y116.302 E.00482
G1 X119.902 Y116.452 E.00482
G1 X119.752 Y116.452 E.00482
G1 X119.752 Y116.602 E.00482
G1 X119.452 Y116.602 E.00965
G1 X119.452 Y116.752 E.00482
G1 X119.302 Y116.752 E.00482
G1 X119.302 Y116.902 E.00482
G1 X119.152 Y116.902 E.00482
G1 X119.152 Y117.052 E.00482
G1 X119.002 Y117.052 E.00482
G1 X119.002 Y117.202 E.00482
G1 X118.702 Y117.202 E.00965
G1 X118.702 Y117.352 E.00482
G1 X118.552 Y117.352 E.00482
G1 X118.552 Y117.502 E.00482
G1 X118.402 Y117.502 E.00482
G1 X118.402 Y117.652 E.00482
G1 X118.252 Y117.652 E.00482
G1 X118.252 Y117.802 E.00482
G1 X118.102 Y117.802 E.00482
G1 X118.102 Y117.952 E.00482
G1 X117.952 Y117.952 E.00482
G1 X117.952 Y118.102 E.00482
G1 X117.802 Y118.102 E.00482
G1 X117.802 Y118.252 E.00482
G1 X117.652 Y118.252 E.00482
G1 X117.652 Y118.402 E.00482
G1 X117.502 Y118.402 E.00482
G1 X117.502 Y118.552 E.00482
G1 X117.352 Y118.552 E.00482
G1 X117.352 Y118.702 E.00482
G1 X117.202 Y118.702 E.00482
G1 X117.202 Y119.002 E.00965
G1 X117.052 Y119.002 E.00482
G1 X117.052 Y119.152 E.00482
G1 X116.902 Y119.152 E.00482
G1 X116.902 Y119.302 E.00482
G1 X116.752 Y119.302 E.00482
G1 X116.752 Y119.452 E.00482
G1 X116.602 Y119.452 E.00482
G1 X116.602 Y119.752 E.00965
G1 X116.452 Y119.752 E.00482
G1 X116.452 Y119.902 E.00482
G1 X116.302 Y119.902 E.00482
G1 X116.302 Y120.052 E.00482
G1 X116.152 Y120.052 E.00482
G1 X116.152 Y120.352 E.00965
G1 X116.002 Y120.352 E.00482
G1 X116.002 Y120.652 E.00965
G1 X115.852 Y120.652 E.00482
G1 X115.852 Y120.802 E.00482
G1 X115.702 Y120.802 E.00482
G1 X115.702 Y121.102 E.00965
G1 X115.552 Y121.102 E.00482
G1 X115.552 Y121.402 E.00965
G1 X115.402 Y121.402 E.00482
G1 X115.402 Y121.552 E.00482
G1 X115.252 Y121.552 E.00482
G1 X115.252 Y121.852 E.00965
G1 X115.102 Y121.852 E.00482
G1 X115.102 Y122.152 E.00965
G1 X114.952 Y122.152 E.00482
G1 X114.952 Y122.602 E.01447
G1 X114.802 Y122.602 E.00482
G1 X114.802 Y122.902 E.00965
G1 X114.652 Y122.902 E.00482
G1 X114.652 Y123.352 E.01447
G1 X114.502 Y123.352 E.00482
G1 X114.502 Y123.652 E.00965
G1 X114.352 Y123.652 E.00482
G1 X114.352 Y124.102 E.01447
G1 X114.202 Y124.102 E.00482
G1 X114.202 Y124.702 E.01929
G1 X114.052 Y124.702 E.00482
G1 X114.052 Y125.302 E.01929
G1 X113.902 Y125.302 E.00482
G1 X113.902 Y126.052 E.02412
G1 X113.752 Y126.052 E.00482
G1 X113.752 Y127.102 E.03376
G1 X113.602 Y127.102 E.00482
G1 X113.602 Y128.898 E.05775
G1 X113.752 Y128.898 E.00482
G1 X113.752 Y129.948 E.03376
G1 X113.902 Y129.948 E.00482
G1 X113.902 Y130.698 E.02412
G1 X114.052 Y130.698 E.00482
G1 X114.052 Y131.298 E.01929
G1 X114.202 Y131.298 E.00482
G1 X114.202 Y131.898 E.01929
G1 X114.352 Y131.898 E.00482
G1 X114.352 Y132.348 E.01447
G1 X114.502 Y132.348 E.00482
G1 X114.502 Y132.648 E.00965
G1 X114.652 Y132.648 E.00482
G1 X114.652 Y133.098 E.01447
G1 X114.802 Y133.098 E.00482
G1 X114.802 Y133.398 E.00965
G1 X114.952 Y133.398 E.00482
G1 X114.952 Y133.848 E.01447
G1 X115.102 Y133.848 E.00482
G1 X115.102 Y134.148 E.00965
G1 X115.252 Y134.148 E.00482
G1 X115.252 Y134.448 E.00965
G1 X115.402 Y134.448 E.00482
G1 X115.402 Y134.598 E.00482
G1 X115.552 Y134.598 E.00482
G1 X115.552 Y134.898 E.00965
G1 X115.702 Y134.898 E.00482
G1 X115.702 Y135.198 E.00965
G1 X115.852 Y135.198 E.00482
G1 X115.852 Y135.348 E.00482
G1 X116.002 Y135.348 E.00482
G1 X116.002 Y135.648 E.00965
G1 X116.152 Y135.648 E.00482
G1 X116.152 Y135.948 E.00965
G1 X116.302 Y135.948 E.00482
G1 X116.302 Y136.098 E.00482
G1 X116.353 Y136.098 E.00163
M204 S250
G1 X116.06 Y136.49 F36000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S6000
G1 X116.06 Y136.64 E.00447
G1 X116.21 Y136.64 E.00447
G1 X116.21 Y136.94 E.00894
G1 X116.36 Y136.94 E.00447
G1 X116.36 Y137.09 E.00447
G1 X116.51 Y137.09 E.00447
G1 X116.51 Y137.24 E.00447
G1 X116.66 Y137.24 E.00447
G1 X116.66 Y137.39 E.00447
G1 X116.81 Y137.39 E.00447
G1 X116.81 Y137.69 E.00894
G1 X116.96 Y137.69 E.00447
G1 X116.96 Y137.84 E.00447
G1 X117.11 Y137.84 E.00447
G1 X117.11 Y137.99 E.00447
G1 X117.26 Y137.99 E.00447
G1 X117.26 Y138.14 E.00447
G1 X117.41 Y138.14 E.00447
G1 X117.41 Y138.29 E.00447
G1 X117.56 Y138.29 E.00447
G1 X117.56 Y138.44 E.00447
G1 X117.71 Y138.44 E.00447
G1 X117.71 Y138.59 E.00447
G1 X117.86 Y138.59 E.00447
G1 X117.86 Y138.74 E.00447
G1 X118.01 Y138.74 E.00447
G1 X118.01 Y138.89 E.00447
G1 X118.16 Y138.89 E.00447
G1 X118.16 Y139.04 E.00447
G1 X118.31 Y139.04 E.00447
G1 X118.31 Y139.19 E.00447
G1 X118.61 Y139.19 E.00894
G1 X118.61 Y139.34 E.00447
G1 X118.76 Y139.34 E.00447
G1 X118.76 Y139.49 E.00447
G1 X118.91 Y139.49 E.00447
G1 X118.91 Y139.64 E.00447
G1 X119.06 Y139.64 E.00447
G1 X119.06 Y139.79 E.00447
G1 X119.36 Y139.79 E.00894
G1 X119.36 Y139.94 E.00447
G1 X119.51 Y139.94 E.00447
G1 X119.51 Y140.09 E.00447
G1 X119.66 Y140.09 E.00447
G1 X119.66 Y140.24 E.00447
G1 X119.96 Y140.24 E.00894
G1 X119.96 Y140.39 E.00447
G1 X120.26 Y140.39 E.00894
G1 X120.26 Y140.54 E.00447
G1 X120.41 Y140.54 E.00447
G1 X120.41 Y140.69 E.00447
G1 X120.71 Y140.69 E.00894
G1 X120.71 Y140.84 E.00447
G1 X121.01 Y140.84 E.00894
G1 X121.01 Y140.99 E.00447
G1 X121.16 Y140.99 E.00447
G1 X121.16 Y141.14 E.00447
G1 X121.46 Y141.14 E.00894
G1 X121.46 Y141.29 E.00447
G1 X121.76 Y141.29 E.00894
G1 X121.76 Y141.44 E.00447
G1 X122.21 Y141.44 E.0134
G1 X122.21 Y141.59 E.00447
G1 X122.51 Y141.59 E.00894
G1 X122.51 Y141.74 E.00447
G1 X122.96 Y141.74 E.0134
G1 X122.96 Y141.89 E.00447
G1 X123.26 Y141.89 E.00894
G1 X123.26 Y142.04 E.00447
G1 X123.71 Y142.04 E.0134
G1 X123.71 Y142.19 E.00447
G1 X124.31 Y142.19 E.01787
G1 X124.31 Y142.34 E.00447
G1 X124.91 Y142.34 E.01787
G1 X124.91 Y142.49 E.00447
G1 X125.66 Y142.49 E.02234
G1 X125.66 Y142.64 E.00447
G1 X126.71 Y142.64 E.03128
G1 X126.71 Y142.79 E.00447
G1 X129.29 Y142.79 E.07685
G1 X129.29 Y142.64 E.00447
G1 X130.34 Y142.64 E.03128
G1 X130.34 Y142.49 E.00447
G1 X131.09 Y142.49 E.02234
G1 X131.09 Y142.34 E.00447
G1 X131.69 Y142.34 E.01787
G1 X131.69 Y142.19 E.00447
G1 X132.29 Y142.19 E.01787
G1 X132.29 Y142.04 E.00447
G1 X132.74 Y142.04 E.0134
G1 X132.74 Y141.89 E.00447
G1 X133.04 Y141.89 E.00894
G1 X133.04 Y141.74 E.00447
G1 X133.49 Y141.74 E.0134
G1 X133.49 Y141.59 E.00447
G1 X133.79 Y141.59 E.00894
G1 X133.79 Y141.44 E.00447
G1 X134.24 Y141.44 E.0134
G1 X134.24 Y141.29 E.00447
G1 X134.54 Y141.29 E.00894
G1 X134.54 Y141.14 E.00447
G1 X134.84 Y141.14 E.00894
G1 X134.84 Y140.99 E.00447
G1 X134.99 Y140.99 E.00447
G1 X134.99 Y140.84 E.00447
G1 X135.29 Y140.84 E.00894
G1 X135.29 Y140.69 E.00447
G1 X135.59 Y140.69 E.00894
G1 X135.59 Y140.54 E.00447
G1 X135.74 Y140.54 E.00447
G1 X135.74 Y140.39 E.00447
G1 X136.04 Y140.39 E.00894
G1 X136.04 Y140.24 E.00447
G1 X136.34 Y140.24 E.00894
G1 X136.34 Y140.09 E.00447
G1 X136.49 Y140.09 E.00447
G1 X136.49 Y139.94 E.00447
G1 X136.64 Y139.94 E.00447
G1 X136.64 Y139.79 E.00447
G1 X136.94 Y139.79 E.00894
G1 X136.94 Y139.64 E.00447
G1 X137.09 Y139.64 E.00447
G1 X137.09 Y139.49 E.00447
G1 X137.24 Y139.49 E.00447
G1 X137.24 Y139.34 E.00447
G1 X137.39 Y139.34 E.00447
G1 X137.39 Y139.19 E.00447
G1 X137.69 Y139.19 E.00894
G1 X137.69 Y139.04 E.00447
G1 X137.84 Y139.04 E.00447
G1 X137.84 Y138.89 E.00447
G1 X137.99 Y138.89 E.00447
G1 X137.99 Y138.74 E.00447
G1 X138.14 Y138.74 E.00447
G1 X138.14 Y138.59 E.00447
G1 X138.29 Y138.59 E.00447
G1 X138.29 Y138.44 E.00447
G1 X138.44 Y138.44 E.00447
G1 X138.44 Y138.29 E.00447
G1 X138.59 Y138.29 E.00447
G1 X138.59 Y138.14 E.00447
G1 X138.74 Y138.14 E.00447
G1 X138.74 Y137.99 E.00447
G1 X138.89 Y137.99 E.00447
G1 X138.89 Y137.84 E.00447
G1 X139.04 Y137.84 E.00447
G1 X139.04 Y137.69 E.00447
G1 X139.19 Y137.69 E.00447
G1 X139.19 Y137.39 E.00894
G1 X139.34 Y137.39 E.00447
G1 X139.34 Y137.24 E.00447
G1 X139.49 Y137.24 E.00447
G1 X139.49 Y137.09 E.00447
G1 X139.64 Y137.09 E.00447
G1 X139.64 Y136.94 E.00447
G1 X139.79 Y136.94 E.00447
G1 X139.79 Y136.64 E.00894
G1 X139.94 Y136.64 E.00447
G1 X139.94 Y136.49 E.00447
G1 X140.09 Y136.49 E.00447
G1 X140.09 Y136.34 E.00447
G1 X140.24 Y136.34 E.00447
G1 X140.24 Y136.04 E.00894
G1 X140.39 Y136.04 E.00447
G1 X140.39 Y135.74 E.00894
G1 X140.54 Y135.74 E.00447
G1 X140.54 Y135.59 E.00447
G1 X140.69 Y135.59 E.00447
G1 X140.69 Y135.29 E.00894
G1 X140.84 Y135.29 E.00447
G1 X140.84 Y134.99 E.00894
G1 X140.99 Y134.99 E.00447
G1 X140.99 Y134.84 E.00447
G1 X141.14 Y134.84 E.00447
G1 X141.14 Y134.54 E.00894
G1 X141.29 Y134.54 E.00447
G1 X141.29 Y134.24 E.00894
G1 X141.44 Y134.24 E.00447
G1 X141.44 Y133.79 E.0134
G1 X141.59 Y133.79 E.00447
G1 X141.59 Y133.49 E.00894
G1 X141.74 Y133.49 E.00447
G1 X141.74 Y133.04 E.0134
G1 X141.89 Y133.04 E.00447
G1 X141.89 Y132.74 E.00894
G1 X142.04 Y132.74 E.00447
G1 X142.04 Y132.29 E.0134
G1 X142.19 Y132.29 E.00447
G1 X142.19 Y131.69 E.01787
G1 X142.34 Y131.69 E.00447
M73 P79 R1
G1 X142.34 Y131.09 E.01787
G1 X142.49 Y131.09 E.00447
G1 X142.49 Y130.34 E.02234
G1 X142.64 Y130.34 E.00447
G1 X142.64 Y129.29 E.03128
G1 X142.79 Y129.29 E.00447
G1 X142.79 Y126.71 E.07685
G1 X142.64 Y126.71 E.00447
G1 X142.64 Y125.66 E.03128
G1 X142.49 Y125.66 E.00447
G1 X142.49 Y124.91 E.02234
G1 X142.34 Y124.91 E.00447
G1 X142.34 Y124.31 E.01787
G1 X142.19 Y124.31 E.00447
G1 X142.19 Y123.71 E.01787
G1 X142.04 Y123.71 E.00447
G1 X142.04 Y123.26 E.0134
G1 X141.89 Y123.26 E.00447
G1 X141.89 Y122.96 E.00894
G1 X141.74 Y122.96 E.00447
G1 X141.74 Y122.51 E.0134
G1 X141.59 Y122.51 E.00447
G1 X141.59 Y122.21 E.00894
G1 X141.44 Y122.21 E.00447
G1 X141.44 Y121.76 E.0134
G1 X141.29 Y121.76 E.00447
G1 X141.29 Y121.46 E.00894
G1 X141.14 Y121.46 E.00447
G1 X141.14 Y121.16 E.00894
G1 X140.99 Y121.16 E.00447
G1 X140.99 Y121.01 E.00447
G1 X140.84 Y121.01 E.00447
G1 X140.84 Y120.71 E.00894
G1 X140.69 Y120.71 E.00447
G1 X140.69 Y120.41 E.00894
G1 X140.54 Y120.41 E.00447
G1 X140.54 Y120.26 E.00447
G1 X140.39 Y120.26 E.00447
G1 X140.39 Y119.96 E.00894
G1 X140.24 Y119.96 E.00447
G1 X140.24 Y119.66 E.00894
G1 X140.09 Y119.66 E.00447
G1 X140.09 Y119.51 E.00447
G1 X139.94 Y119.51 E.00447
G1 X139.94 Y119.36 E.00447
G1 X139.79 Y119.36 E.00447
G1 X139.79 Y119.06 E.00894
G1 X139.64 Y119.06 E.00447
G1 X139.64 Y118.91 E.00447
G1 X139.49 Y118.91 E.00447
G1 X139.49 Y118.76 E.00447
G1 X139.34 Y118.76 E.00447
G1 X139.34 Y118.61 E.00447
G1 X139.19 Y118.61 E.00447
G1 X139.19 Y118.31 E.00894
G1 X139.04 Y118.31 E.00447
G1 X139.04 Y118.16 E.00447
G1 X138.89 Y118.16 E.00447
G1 X138.89 Y118.01 E.00447
G1 X138.74 Y118.01 E.00447
G1 X138.74 Y117.86 E.00447
G1 X138.59 Y117.86 E.00447
G1 X138.59 Y117.71 E.00447
G1 X138.44 Y117.71 E.00447
G1 X138.44 Y117.56 E.00447
G1 X138.29 Y117.56 E.00447
G1 X138.29 Y117.41 E.00447
G1 X138.14 Y117.41 E.00447
G1 X138.14 Y117.26 E.00447
G1 X137.99 Y117.26 E.00447
G1 X137.99 Y117.11 E.00447
G1 X137.84 Y117.11 E.00447
G1 X137.84 Y116.96 E.00447
G1 X137.69 Y116.96 E.00447
G1 X137.69 Y116.81 E.00447
G1 X137.39 Y116.81 E.00894
G1 X137.39 Y116.66 E.00447
G1 X137.24 Y116.66 E.00447
G1 X137.24 Y116.51 E.00447
G1 X137.09 Y116.51 E.00447
G1 X137.09 Y116.36 E.00447
G1 X136.94 Y116.36 E.00447
G1 X136.94 Y116.21 E.00447
G1 X136.64 Y116.21 E.00894
G1 X136.64 Y116.06 E.00447
G1 X136.49 Y116.06 E.00447
G1 X136.49 Y115.91 E.00447
G1 X136.34 Y115.91 E.00447
G1 X136.34 Y115.76 E.00447
G1 X136.04 Y115.76 E.00894
G1 X136.04 Y115.61 E.00447
G1 X135.74 Y115.61 E.00894
G1 X135.74 Y115.46 E.00447
G1 X135.59 Y115.46 E.00447
G1 X135.59 Y115.31 E.00447
G1 X135.29 Y115.31 E.00894
G1 X135.29 Y115.16 E.00447
G1 X134.99 Y115.16 E.00894
G1 X134.99 Y115.01 E.00447
G1 X134.84 Y115.01 E.00447
G1 X134.84 Y114.86 E.00447
G1 X134.54 Y114.86 E.00894
G1 X134.54 Y114.71 E.00447
G1 X134.24 Y114.71 E.00894
G1 X134.24 Y114.56 E.00447
G1 X133.79 Y114.56 E.0134
G1 X133.79 Y114.41 E.00447
G1 X133.49 Y114.41 E.00894
G1 X133.49 Y114.26 E.00447
G1 X133.04 Y114.26 E.0134
G1 X133.04 Y114.11 E.00447
G1 X132.74 Y114.11 E.00894
G1 X132.74 Y113.96 E.00447
G1 X132.29 Y113.96 E.0134
G1 X132.29 Y113.81 E.00447
G1 X131.69 Y113.81 E.01787
G1 X131.69 Y113.66 E.00447
G1 X131.09 Y113.66 E.01787
G1 X131.09 Y113.51 E.00447
G1 X130.34 Y113.51 E.02234
G1 X130.34 Y113.36 E.00447
M73 P80 R1
G1 X129.29 Y113.36 E.03128
G1 X129.29 Y113.21 E.00447
G1 X126.71 Y113.21 E.07685
G1 X126.71 Y113.36 E.00447
G1 X125.66 Y113.36 E.03128
G1 X125.66 Y113.51 E.00447
G1 X124.91 Y113.51 E.02234
G1 X124.91 Y113.66 E.00447
G1 X124.31 Y113.66 E.01787
G1 X124.31 Y113.81 E.00447
G1 X123.71 Y113.81 E.01787
G1 X123.71 Y113.96 E.00447
G1 X123.26 Y113.96 E.0134
G1 X123.26 Y114.11 E.00447
G1 X122.96 Y114.11 E.00894
G1 X122.96 Y114.26 E.00447
G1 X122.51 Y114.26 E.0134
G1 X122.51 Y114.41 E.00447
G1 X122.21 Y114.41 E.00894
G1 X122.21 Y114.56 E.00447
G1 X121.76 Y114.56 E.0134
G1 X121.76 Y114.71 E.00447
G1 X121.46 Y114.71 E.00894
G1 X121.46 Y114.86 E.00447
G1 X121.16 Y114.86 E.00894
G1 X121.16 Y115.01 E.00447
G1 X121.01 Y115.01 E.00447
G1 X121.01 Y115.16 E.00447
G1 X120.71 Y115.16 E.00894
G1 X120.71 Y115.31 E.00447
G1 X120.41 Y115.31 E.00894
G1 X120.41 Y115.46 E.00447
G1 X120.26 Y115.46 E.00447
G1 X120.26 Y115.61 E.00447
G1 X119.96 Y115.61 E.00894
G1 X119.96 Y115.76 E.00447
G1 X119.66 Y115.76 E.00894
G1 X119.66 Y115.91 E.00447
G1 X119.51 Y115.91 E.00447
G1 X119.51 Y116.06 E.00447
G1 X119.36 Y116.06 E.00447
G1 X119.36 Y116.21 E.00447
G1 X119.06 Y116.21 E.00894
G1 X119.06 Y116.36 E.00447
G1 X118.91 Y116.36 E.00447
G1 X118.91 Y116.51 E.00447
G1 X118.76 Y116.51 E.00447
G1 X118.76 Y116.66 E.00447
G1 X118.61 Y116.66 E.00447
G1 X118.61 Y116.81 E.00447
G1 X118.31 Y116.81 E.00894
G1 X118.31 Y116.96 E.00447
G1 X118.16 Y116.96 E.00447
G1 X118.16 Y117.11 E.00447
G1 X118.01 Y117.11 E.00447
G1 X118.01 Y117.26 E.00447
G1 X117.86 Y117.26 E.00447
G1 X117.86 Y117.41 E.00447
G1 X117.71 Y117.41 E.00447
G1 X117.71 Y117.56 E.00447
G1 X117.56 Y117.56 E.00447
G1 X117.56 Y117.71 E.00447
G1 X117.41 Y117.71 E.00447
G1 X117.41 Y117.86 E.00447
G1 X117.26 Y117.86 E.00447
G1 X117.26 Y118.01 E.00447
G1 X117.11 Y118.01 E.00447
G1 X117.11 Y118.16 E.00447
G1 X116.96 Y118.16 E.00447
G1 X116.96 Y118.31 E.00447
G1 X116.81 Y118.31 E.00447
G1 X116.81 Y118.61 E.00894
G1 X116.66 Y118.61 E.00447
G1 X116.66 Y118.76 E.00447
G1 X116.51 Y118.76 E.00447
G1 X116.51 Y118.91 E.00447
G1 X116.36 Y118.91 E.00447
G1 X116.36 Y119.06 E.00447
G1 X116.21 Y119.06 E.00447
G1 X116.21 Y119.36 E.00894
G1 X116.06 Y119.36 E.00447
G1 X116.06 Y119.51 E.00447
G1 X115.91 Y119.51 E.00447
G1 X115.91 Y119.66 E.00447
G1 X115.76 Y119.66 E.00447
G1 X115.76 Y119.96 E.00894
G1 X115.61 Y119.96 E.00447
G1 X115.61 Y120.26 E.00894
G1 X115.46 Y120.26 E.00447
G1 X115.46 Y120.41 E.00447
G1 X115.31 Y120.41 E.00447
G1 X115.31 Y120.71 E.00894
G1 X115.16 Y120.71 E.00447
G1 X115.16 Y121.01 E.00894
G1 X115.01 Y121.01 E.00447
G1 X115.01 Y121.16 E.00447
G1 X114.86 Y121.16 E.00447
G1 X114.86 Y121.46 E.00894
G1 X114.71 Y121.46 E.00447
G1 X114.71 Y121.76 E.00894
G1 X114.56 Y121.76 E.00447
G1 X114.56 Y122.21 E.0134
G1 X114.41 Y122.21 E.00447
G1 X114.41 Y122.51 E.00894
G1 X114.26 Y122.51 E.00447
G1 X114.26 Y122.96 E.0134
G1 X114.11 Y122.96 E.00447
G1 X114.11 Y123.26 E.00894
G1 X113.96 Y123.26 E.00447
G1 X113.96 Y123.71 E.0134
G1 X113.81 Y123.71 E.00447
G1 X113.81 Y124.31 E.01787
G1 X113.66 Y124.31 E.00447
G1 X113.66 Y124.91 E.01787
G1 X113.51 Y124.91 E.00447
G1 X113.51 Y125.66 E.02234
G1 X113.36 Y125.66 E.00447
G1 X113.36 Y126.71 E.03128
G1 X113.21 Y126.71 E.00447
G1 X113.21 Y129.29 E.07685
G1 X113.36 Y129.29 E.00447
G1 X113.36 Y130.34 E.03128
G1 X113.51 Y130.34 E.00447
G1 X113.51 Y131.09 E.02234
G1 X113.66 Y131.09 E.00447
G1 X113.66 Y131.69 E.01787
G1 X113.81 Y131.69 E.00447
G1 X113.81 Y132.29 E.01787
G1 X113.96 Y132.29 E.00447
G1 X113.96 Y132.74 E.0134
G1 X114.11 Y132.74 E.00447
G1 X114.11 Y133.04 E.00894
G1 X114.26 Y133.04 E.00447
G1 X114.26 Y133.49 E.0134
G1 X114.41 Y133.49 E.00447
G1 X114.41 Y133.79 E.00894
G1 X114.56 Y133.79 E.00447
G1 X114.56 Y134.24 E.0134
G1 X114.71 Y134.24 E.00447
G1 X114.71 Y134.54 E.00894
G1 X114.86 Y134.54 E.00447
G1 X114.86 Y134.84 E.00894
G1 X115.01 Y134.84 E.00447
G1 X115.01 Y134.99 E.00447
G1 X115.16 Y134.99 E.00447
G1 X115.16 Y135.29 E.00894
G1 X115.31 Y135.29 E.00447
G1 X115.31 Y135.59 E.00894
G1 X115.46 Y135.59 E.00447
G1 X115.46 Y135.74 E.00447
G1 X115.61 Y135.74 E.00447
G1 X115.61 Y136.04 E.00894
G1 X115.76 Y136.04 E.00447
G1 X115.76 Y136.34 E.00894
G1 X115.91 Y136.34 E.00447
G1 X115.91 Y136.49 E.00447
G1 X116 Y136.49 E.00268
; WIPE_START
M204 S10000
G1 X116.06 Y136.64 E-.06139
G1 X116.21 Y136.64 E-.057
G1 X116.21 Y136.94 E-.114
G1 X116.36 Y136.94 E-.057
G1 X116.36 Y137.09 E-.057
G1 X116.51 Y137.09 E-.057
G1 X116.51 Y137.24 E-.057
G1 X116.66 Y137.24 E-.057
G1 X116.66 Y137.39 E-.057
G1 X116.81 Y137.39 E-.057
G1 X116.81 Y137.69 E-.114
G1 X116.848 Y137.69 E-.01461
; WIPE_END
G1 E-.04 F1800
G1 X115.558 Y130.167 Z.8 F36000
G1 X114.516 Y124.087 Z.8
G1 Z.4
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42144
G1 F9510.725
G1 X123.767 Y114.835 E.3912
G1 X123.985 Y114.835 E.00652
G1 X123.985 Y114.685 E.00449
G1 X124.435 Y114.685 E.01346
G1 X124.435 Y114.535 E.00449
G1 X124.602 Y114.535 E.005
G1 X114.535 Y124.602 E.42569
G1 X114.535 Y125.035 E.01294
G1 X114.385 Y125.035 E.00449
G1 X114.385 Y125.288 E.00755
G1 X125.288 Y114.385 E.46101
G1 X125.635 Y114.385 E.01039
G1 X125.635 Y114.235 E.00449
G1 X125.973 Y114.235 E.0101
G1 X114.235 Y125.973 E.49634
G1 X114.235 Y126.385 E.01233
G1 X114.085 Y126.385 E.00449
G1 X114.085 Y126.658 E.00816
G1 X126.658 Y114.085 E.53166
G1 X127.194 Y114.085 E.01601
G1 X114.085 Y127.194 E.55429
G1 X114.085 Y127.435 E.00723
G1 X113.935 Y127.435 E.00449
G1 X113.935 Y127.879 E.01326
G1 X127.879 Y113.935 E.58961
G1 X128.414 Y113.935 E.01601
G1 X113.935 Y128.414 E.61225
G1 X113.935 Y128.565 E.0045
G1 X114.085 Y128.565 E.00449
G1 X114.085 Y128.8 E.00702
G1 X128.8 Y114.085 E.6222
G1 X129.335 Y114.085 E.01601
G1 X114.085 Y129.335 E.64484
G1 X114.085 Y129.615 E.00837
G1 X114.235 Y129.615 E.00449
G1 X114.235 Y129.72 E.00316
G1 X129.72 Y114.235 E.65479
G1 X130.255 Y114.235 E.01601
G1 X114.235 Y130.255 E.67742
G1 X114.235 Y130.365 E.00326
G1 X114.385 Y130.365 E.00449
G1 X114.385 Y130.641 E.00826
G1 X130.641 Y114.385 E.68737
G1 X130.965 Y114.385 E.00968
G1 X130.965 Y114.535 E.00449
G1 X131.026 Y114.535 E.00184
G1 X114.535 Y131.026 E.69732
G1 X114.535 Y131.561 E.01601
G1 X131.561 Y114.535 E.71996
G1 X131.565 Y114.685 E.00449
G1 X131.947 Y114.685 E.01142
G1 X114.685 Y131.947 E.72991
G1 X114.685 Y132.015 E.00203
G1 X114.835 Y132.015 E.00449
G1 X114.835 Y132.315 E.00897
G1 X114.853 Y132.315 E.00052
G1 X132.315 Y114.853 E.73839
G1 X132.315 Y114.985 E.00397
G1 X132.717 Y114.985 E.01204
G1 X114.985 Y132.717 E.74981
G1 X114.985 Y132.765 E.00142
G1 X115.135 Y132.765 E.00449
G1 X115.135 Y133.065 E.00897
G1 X115.173 Y133.065 E.00114
G1 X133.065 Y115.173 E.75655
G1 X133.065 Y115.285 E.00335
G1 X133.488 Y115.285 E.01266
G1 X115.285 Y133.488 E.76971
G1 X115.285 Y133.515 E.0008
G1 X115.435 Y133.515 E.00449
G1 X115.435 Y133.815 E.00897
G1 X115.494 Y133.815 E.00175
G1 X133.815 Y115.494 E.7747
G1 X133.815 Y115.585 E.00273
G1 X134.115 Y115.585 E.00897
G1 X134.115 Y115.729 E.0043
G1 X115.729 Y134.115 E.77744
G1 X115.735 Y134.265 E.00449
G1 X115.885 Y134.265 E.00448
G1 X115.885 Y134.494 E.00685
G1 X134.494 Y115.885 E.78687
G1 X134.565 Y115.885 E.00212
G1 X134.565 Y116.035 E.00449
G1 X134.865 Y116.035 E.00897
G1 X116.05 Y134.865 E.7959
G1 X116.185 Y134.865 E.00405
G1 X116.185 Y135.015 E.00449
G1 X116.335 Y135.015 E.00449
G1 X116.335 Y135.114 E.00298
G1 X135.115 Y116.335 E.79409
M73 P81 R1
G1 X135.315 Y116.335 E.00599
G1 X135.315 Y116.485 E.00449
G1 X135.5 Y116.485 E.00554
G1 X116.485 Y135.5 E.80404
G1 X116.485 Y135.615 E.00343
G1 X116.635 Y135.615 E.00448
G1 X116.635 Y135.765 E.00448
G1 X116.756 Y135.765 E.0036
G1 X135.765 Y116.756 E.8038
G1 X135.765 Y116.785 E.00088
G1 X135.915 Y116.785 E.00448
G1 X135.915 Y116.935 E.00448
G1 X136.12 Y116.935 E.00615
G1 X116.935 Y136.12 E.81125
G1 X116.935 Y136.215 E.00282
G1 X117.085 Y136.215 E.00449
G1 X117.085 Y136.365 E.00449
G1 X117.226 Y136.365 E.00422
G1 X136.365 Y117.226 E.80927
G1 X136.515 Y117.235 E.00449
G1 X136.515 Y117.385 E.00449
G1 X136.665 Y117.385 E.00449
G1 X136.665 Y117.462 E.00228
G1 X117.462 Y136.665 E.81201
G1 X117.535 Y136.665 E.0022
G1 X117.535 Y136.965 E.00897
G1 X117.685 Y136.976 E.0045
G1 X136.976 Y117.685 E.81573
G1 X137.115 Y117.685 E.00414
G1 X137.115 Y117.835 E.00449
G1 X137.265 Y117.835 E.00448
G1 X137.265 Y117.932 E.0029
G1 X117.932 Y137.265 E.81748
G1 X117.985 Y137.265 E.00159
G1 X117.985 Y137.415 E.00449
G1 X118.135 Y137.415 E.00448
G1 X118.135 Y137.565 E.00449
G1 X118.168 Y137.565 E.00097
G1 X137.565 Y118.168 E.82021
G1 X137.565 Y118.285 E.00352
G1 X137.715 Y118.285 E.00449
G1 X137.715 Y118.435 E.00448
G1 X137.832 Y118.435 E.00352
G1 X118.435 Y137.832 E.82021
G1 X118.435 Y137.865 E.00097
G1 X118.585 Y137.865 E.00448
G1 X118.585 Y138.015 E.00448
G1 X118.735 Y138.015 E.00448
G1 X118.735 Y138.068 E.00158
G1 X138.068 Y118.735 E.81747
G1 X138.165 Y118.735 E.0029
G1 X138.165 Y118.885 E.00448
G1 X138.315 Y118.885 E.00448
G1 X138.315 Y119.024 E.00413
G1 X119.024 Y138.315 E.81574
G1 X119.035 Y138.465 E.0045
G1 X119.335 Y138.465 E.00897
G1 X119.335 Y138.538 E.0022
G1 X138.538 Y119.335 E.812
G1 X138.615 Y119.335 E.00229
G1 X138.615 Y119.485 E.00449
G1 X138.765 Y119.485 E.00449
G1 X138.774 Y119.635 E.00449
G1 X119.635 Y138.773 E.80927
G1 X119.635 Y138.915 E.00422
G1 X119.785 Y138.915 E.00448
G1 X119.785 Y139.065 E.00449
G1 X119.879 Y139.065 E.00281
G1 X139.065 Y119.879 E.81126
G1 X139.065 Y120.085 E.00615
G1 X139.215 Y120.085 E.00449
G1 X139.215 Y120.235 E.00449
G1 X139.244 Y120.235 E.00088
G1 X120.235 Y139.244 E.8038
G1 X120.235 Y139.365 E.0036
G1 X120.385 Y139.365 E.00448
G1 X120.385 Y139.515 E.00449
G1 X120.5 Y139.515 E.00343
G1 X139.515 Y120.5 E.80404
G1 X139.515 Y120.685 E.00554
G1 X139.665 Y120.685 E.00449
G1 X139.665 Y120.885 E.00598
G1 X120.885 Y139.665 E.79409
G1 X120.985 Y139.665 E.00299
G1 X120.985 Y139.815 E.00449
G1 X121.135 Y139.815 E.00448
G1 X121.135 Y139.95 E.00405
G1 X139.965 Y121.135 E.7959
G1 X139.965 Y121.435 E.00897
G1 X140.115 Y121.435 E.00449
G1 X140.115 Y121.506 E.00211
G1 X121.506 Y140.115 E.78688
G1 X121.735 Y140.115 E.00686
G1 X121.735 Y140.265 E.00449
G1 X121.885 Y140.271 E.00449
G1 X140.271 Y121.885 E.77743
G1 X140.415 Y121.885 E.00431
G1 X140.415 Y122.185 E.00897
G1 X140.506 Y122.185 E.00273
G1 X122.185 Y140.506 E.7747
G1 X122.185 Y140.565 E.00176
G1 X122.485 Y140.565 E.00897
G1 X122.485 Y140.715 E.00448
G1 X122.512 Y140.715 E.0008
G1 X140.715 Y122.512 E.76971
G1 X140.715 Y122.935 E.01266
G1 X140.827 Y122.935 E.00335
G1 X122.935 Y140.827 E.75654
G1 X122.935 Y140.865 E.00114
G1 X123.235 Y140.865 E.00897
G1 X123.235 Y141.015 E.00449
G1 X123.283 Y141.015 E.00141
G1 X141.015 Y123.283 E.74981
G1 X141.015 Y123.685 E.01204
G1 X141.147 Y123.685 E.00396
G1 X123.685 Y141.147 E.73838
G1 X123.685 Y141.165 E.00052
G1 X123.985 Y141.165 E.00897
G1 X123.985 Y141.315 E.00449
G1 X124.053 Y141.315 E.00203
G1 X141.315 Y124.053 E.72991
G1 X141.315 Y124.435 E.01143
G1 X141.465 Y124.438 E.00449
G1 X124.438 Y141.465 E.71996
G1 X124.974 Y141.465 E.01601
G1 X141.465 Y124.974 E.69733
G1 X141.465 Y125.035 E.00184
G1 X141.615 Y125.035 E.00449
G1 X141.615 Y125.359 E.00968
G1 X125.359 Y141.615 E.68738
G1 X125.635 Y141.615 E.00826
G1 X125.635 Y141.765 E.00449
G1 X125.744 Y141.765 E.00326
M73 P82 R1
G1 X141.765 Y125.744 E.67743
G1 X141.765 Y126.28 E.01601
G1 X126.28 Y141.765 E.65479
G1 X126.385 Y141.765 E.00316
G1 X126.385 Y141.915 E.00449
G1 X126.665 Y141.915 E.00836
G1 X141.915 Y126.665 E.64484
G1 X141.915 Y127.2 E.01601
G1 X127.2 Y141.915 E.6222
G1 X127.435 Y141.915 E.00703
G1 X127.435 Y142.065 E.00449
G1 X127.586 Y142.065 E.00449
G1 X142.065 Y127.586 E.61225
G1 X142.065 Y128.121 E.01601
G1 X128.121 Y142.065 E.58962
G1 X128.565 Y142.065 E.01327
G1 X128.565 Y141.915 E.00449
G1 X128.806 Y141.915 E.00722
G1 X141.915 Y128.806 E.5543
G1 X141.915 Y129.342 E.01601
G1 X129.342 Y141.915 E.53166
G1 X129.615 Y141.915 E.00817
G1 X129.615 Y141.765 E.00449
G1 X130.027 Y141.765 E.01232
G1 X141.765 Y130.027 E.49634
G1 X141.765 Y130.365 E.0101
G1 X141.615 Y130.365 E.00449
G1 X141.615 Y130.712 E.01039
G1 X130.712 Y141.615 E.46102
G1 X130.965 Y141.615 E.00755
G1 X130.965 Y141.465 E.00449
G1 X131.397 Y141.465 E.01294
G1 X141.465 Y131.397 E.4257
G1 X141.465 Y131.565 E.005
G1 X141.315 Y131.565 E.00449
G1 X141.315 Y132.015 E.01346
G1 X141.165 Y132.015 E.00449
G1 X141.165 Y132.233 E.00652
G1 X131.913 Y141.484 E.39121
G1 X132.748 Y141.184 F36000
G1 F9510.725
G1 X140.715 Y133.218 E.33686
G1 X140.715 Y133.515 E.00887
G1 X140.565 Y133.515 E.00448
G1 X140.565 Y133.815 E.00897
G1 X140.415 Y133.815 E.00449
G1 X140.415 Y134.053 E.00714
G1 X133.734 Y140.734 E.28251
; WIPE_START
G1 X135.148 Y139.32 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.869 Y140.134 Z.8 F36000
G1 Z.4
G1 E.8 F1800
G1 F9510.725
G1 X140.134 Y134.869 E.22265
; WIPE_START
G1 X138.72 Y136.283 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.739 Y130.501 Z.8 F36000
G1 X121.131 Y115.866 Z.8
G1 Z.4
G1 E.8 F1800
G1 F9510.725
G1 X115.866 Y121.131 E.22264
; WIPE_START
G1 X117.28 Y119.717 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.266 Y122.266 Z.8 F36000
G1 Z.4
G1 E.8 F1800
G1 F9510.725
G1 X121.946 Y115.585 E.2825
G1 X122.185 Y115.585 E.00714
G1 X122.185 Y115.435 E.00449
G1 X122.485 Y115.435 E.00897
G1 X122.485 Y115.285 E.00449
G1 X122.782 Y115.285 E.00886
G1 X114.816 Y123.251 E.33685
; CHANGE_LAYER
; Z_HEIGHT: 0.6
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9510.725
G1 X116.23 Y121.837 E-.76
; WIPE_END
G1 E-.04 F1800
;======== P2S layer_change gcode ==========
;===== 2026/05/15 ====





    

    M622.1 S0
    M1002 judge_flag ventobox_replace_aux1_fan_flag
    M622 J0
    M106 P10 S0; set first x_layer left aux fan
    M623
;not reset fan


; update layer progress
M73 L3
M991 S0 P2 ;notify layer change


G17
G3 Z.8 I1.217 J0 P1  F36000
;======== P2S timelapes gcode ==========
;===== 2025/06/16 ====
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
  M971 S11 C10 O0
  M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 175
G1 X123.172 Y127.578
G1 Z.6
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F8843.478
G1 X122.628 Y127.578 E.01751
G1 X122.628 Y127.728 E.00482
G1 X122.178 Y127.728 E.01447
G1 X122.178 Y127.878 E.00482
G1 X121.878 Y127.878 E.00965
G1 X121.878 Y128.028 E.00482
G1 X121.578 Y128.028 E.00965
G1 X121.578 Y128.178 E.00482
G1 X121.278 Y128.178 E.00965
G1 X121.278 Y128.328 E.00482
G1 X120.978 Y128.328 E.00965
G1 X120.978 Y128.478 E.00482
G1 X120.678 Y128.478 E.00965
G1 X120.678 Y128.628 E.00482
G1 X120.528 Y128.628 E.00482
G1 X120.528 Y128.778 E.00482
G1 X120.378 Y128.778 E.00482
G1 X120.378 Y128.928 E.00482
G1 X120.078 Y128.928 E.00965
G1 X120.078 Y129.078 E.00482
G1 X119.928 Y129.078 E.00482
G1 X119.928 Y129.228 E.00482
G1 X119.778 Y129.228 E.00482
G1 X119.778 Y129.528 E.00965
G1 X119.628 Y129.528 E.00482
G1 X119.628 Y129.678 E.00482
G1 X119.478 Y129.678 E.00482
G1 X119.478 Y129.828 E.00482
G1 X119.328 Y129.828 E.00482
G1 X119.328 Y130.522 E.02233
G1 X119.478 Y130.522 E.00482
G1 X119.478 Y130.822 E.00965
G1 X119.628 Y130.822 E.00482
G1 X119.628 Y131.122 E.00965
G1 X119.778 Y131.122 E.00482
G1 X119.778 Y131.272 E.00482
G1 X119.928 Y131.272 E.00482
G1 X119.928 Y131.572 E.00965
G1 X120.078 Y131.572 E.00482
G1 X120.078 Y131.722 E.00482
G1 X120.228 Y131.722 E.00482
G1 X120.228 Y132.022 E.00965
G1 X120.378 Y132.022 E.00483
G1 X120.378 Y132.172 E.00483
G1 X120.622 Y132.172 E.00785
G1 X120.622 Y131.872 E.00964
G1 X120.772 Y131.872 E.00482
G1 X120.772 Y131.422 E.01447
G1 X120.922 Y131.422 E.00482
G1 X120.922 Y130.972 E.01447
G1 X121.072 Y130.972 E.00482
G1 X121.072 Y130.672 E.00965
G1 X121.222 Y130.672 E.00482
G1 X121.222 Y130.372 E.00965
G1 X121.372 Y130.372 E.00482
G1 X121.372 Y130.222 E.00482
G1 X121.522 Y130.222 E.00482
G1 X121.522 Y129.922 E.00965
G1 X121.672 Y129.922 E.00482
G1 X121.672 Y129.772 E.00482
G1 X121.822 Y129.772 E.00482
G1 X121.822 Y129.472 E.00965
G1 X121.972 Y129.472 E.00482
G1 X121.972 Y129.322 E.00482
G1 X122.122 Y129.322 E.00482
G1 X122.122 Y129.172 E.00482
G1 X122.272 Y129.172 E.00482
G1 X122.272 Y129.022 E.00482
G1 X122.422 Y129.022 E.00482
G1 X122.422 Y128.872 E.00482
G1 X122.572 Y128.872 E.00482
G1 X122.572 Y128.722 E.00482
G1 X122.722 Y128.722 E.00482
G1 X122.722 Y128.572 E.00482
G1 X122.872 Y128.572 E.00482
G1 X122.872 Y128.422 E.00482
G1 X123.022 Y128.422 E.00482
G1 X123.022 Y128.272 E.00482
G1 X123.172 Y128.272 E.00482
G1 X123.172 Y127.638 E.0204
; WIPE_START
G1 X122.628 Y127.578 E-.20815
G1 X122.628 Y127.728 E-.057
G1 X122.178 Y127.728 E-.171
G1 X122.178 Y127.878 E-.057
G1 X121.878 Y127.878 E-.114
G1 X121.878 Y128.028 E-.057
G1 X121.626 Y128.028 E-.09585
; WIPE_END
G1 E-.04 F1800
G1 X127.353 Y133.072 Z1 F36000
G1 X130.822 Y136.128 Z1
G1 Z.6
G1 E.8 F1800
G1 F8843.478
G1 X130.522 Y136.128 E.00965
G1 X130.522 Y135.978 E.00482
G1 X130.372 Y135.978 E.00482
G1 X130.372 Y135.828 E.00482
G1 X130.072 Y135.828 E.00965
G1 X130.072 Y135.678 E.00482
G1 X129.922 Y135.678 E.00482
G1 X129.922 Y135.528 E.00482
G1 X129.772 Y135.528 E.00482
G1 X129.772 Y135.378 E.00482
G1 X129.622 Y135.378 E.00482
G1 X129.622 Y135.228 E.00482
G1 X129.472 Y135.228 E.00482
G1 X129.472 Y135.078 E.00482
G1 X129.322 Y135.078 E.00482
G1 X129.322 Y134.928 E.00482
G1 X129.172 Y134.928 E.00482
G1 X129.172 Y134.778 E.00482
G1 X129.022 Y134.778 E.00482
G1 X129.022 Y134.628 E.00482
G1 X128.872 Y134.628 E.00482
G1 X128.872 Y134.328 E.00965
G1 X128.722 Y134.328 E.00482
G1 X128.722 Y134.178 E.00482
G1 X128.572 Y134.178 E.00482
G1 X128.572 Y133.878 E.00965
G1 X128.422 Y133.878 E.00482
G1 X128.422 Y133.578 E.00965
G1 X128.272 Y133.578 E.00482
G1 X128.272 Y133.428 E.00482
G1 X128.122 Y133.428 E.00482
G1 X128.122 Y133.128 E.00965
G1 X127.972 Y133.128 E.00482
G1 X127.972 Y132.678 E.01447
G1 X126.228 Y132.678 E.0561
G1 X126.228 Y133.522 E.02715
G1 X126.378 Y133.522 E.00482
G1 X126.378 Y133.972 E.01447
G1 X126.528 Y133.972 E.00482
G1 X126.528 Y134.422 E.01447
G1 X126.678 Y134.422 E.00482
G1 X126.678 Y134.722 E.00965
G1 X126.828 Y134.722 E.00482
G1 X126.828 Y135.022 E.00965
G1 X126.978 Y135.022 E.00482
G1 X126.978 Y135.322 E.00965
G1 X127.128 Y135.322 E.00482
G1 X127.128 Y135.622 E.00965
G1 X127.278 Y135.622 E.00482
G1 X127.278 Y135.772 E.00482
G1 X127.428 Y135.772 E.00482
G1 X127.428 Y135.922 E.00482
G1 X127.578 Y135.922 E.00482
G1 X127.578 Y136.222 E.00965
G1 X127.728 Y136.222 E.00482
G1 X127.728 Y136.372 E.00482
G1 X128.028 Y136.372 E.00965
G1 X128.028 Y136.522 E.00482
G1 X128.178 Y136.522 E.00482
G1 X128.178 Y136.672 E.00482
G1 X128.478 Y136.672 E.00965
G1 X128.478 Y136.822 E.00482
G1 X128.628 Y136.822 E.00482
G1 X128.628 Y136.972 E.00482
G1 X128.928 Y136.972 E.00965
G1 X128.928 Y137.122 E.00483
G1 X129.172 Y137.122 E.00785
G1 X129.172 Y136.972 E.00482
G1 X129.772 Y136.972 E.01929
G1 X129.772 Y136.822 E.00482
G1 X130.222 Y136.822 E.01447
G1 X130.222 Y136.672 E.00482
G1 X130.672 Y136.672 E.01447
G1 X130.672 Y136.522 E.00483
G1 X130.972 Y136.522 E.00965
G1 X130.972 Y136.278 E.00785
G1 X130.822 Y136.278 E.00482
G1 X130.822 Y136.188 E.00289
; WIPE_START
G1 X130.522 Y136.128 E-.11626
G1 X130.522 Y135.978 E-.057
G1 X130.372 Y135.978 E-.057
G1 X130.372 Y135.828 E-.057
G1 X130.072 Y135.828 E-.114
G1 X130.072 Y135.678 E-.057
G1 X129.922 Y135.678 E-.057
G1 X129.922 Y135.528 E-.057
G1 X129.772 Y135.528 E-.057
G1 X129.772 Y135.378 E-.057
G1 X129.622 Y135.378 E-.057
G1 X129.622 Y135.334 E-.01674
; WIPE_END
G1 E-.04 F1800
G1 X132.528 Y130.672 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F8843.478
G1 X132.828 Y130.672 E.00965
G1 X132.828 Y130.822 E.00482
G1 X133.278 Y130.822 E.01447
G1 X133.278 Y130.972 E.00482
G1 X133.878 Y130.972 E.01929
G1 X133.878 Y131.122 E.00482
G1 X135.172 Y131.122 E.04163
G1 X135.172 Y130.972 E.00482
G1 X135.622 Y130.972 E.01447
G1 X135.622 Y130.822 E.00482
G1 X135.922 Y130.822 E.00965
G1 X135.922 Y130.672 E.00482
G1 X136.072 Y130.672 E.00482
G1 X136.072 Y130.522 E.00482
G1 X136.372 Y130.522 E.00965
G1 X136.372 Y130.372 E.00482
G1 X136.522 Y130.372 E.00482
G1 X136.522 Y130.222 E.00482
G1 X136.672 Y130.222 E.00482
G1 X136.672 Y130.072 E.00482
G1 X136.822 Y130.072 E.00482
G1 X136.822 Y129.922 E.00482
G1 X136.972 Y129.922 E.00482
G1 X136.972 Y129.622 E.00965
G1 X137.122 Y129.622 E.00482
G1 X137.122 Y129.322 E.00965
G1 X137.272 Y129.322 E.00482
G1 X137.272 Y128.722 E.01929
G1 X137.422 Y128.722 E.00483
G1 X137.422 Y127.878 E.02716
G1 X137.178 Y127.878 E.00785
G1 X137.178 Y128.028 E.00482
G1 X136.878 Y128.028 E.00965
G1 X136.878 Y128.178 E.00482
G1 X136.728 Y128.178 E.00482
G1 X136.728 Y128.328 E.00482
G1 X136.578 Y128.328 E.00482
G1 X136.578 Y128.478 E.00482
G1 X136.278 Y128.478 E.00965
G1 X136.278 Y128.628 E.00482
G1 X136.128 Y128.628 E.00482
G1 X136.128 Y128.778 E.00482
G1 X135.828 Y128.778 E.00965
G1 X135.828 Y128.928 E.00482
G1 X135.528 Y128.928 E.00965
G1 X135.528 Y129.078 E.00482
G1 X135.228 Y129.078 E.00965
G1 X135.228 Y129.228 E.00482
G1 X134.928 Y129.228 E.00965
G1 X134.928 Y129.378 E.00482
G1 X134.478 Y129.378 E.01447
G1 X134.478 Y129.528 E.00482
G1 X134.028 Y129.528 E.01447
G1 X134.028 Y129.678 E.00482
G1 X133.578 Y129.678 E.01447
G1 X133.578 Y129.828 E.00482
G1 X132.828 Y129.828 E.02412
G1 X132.828 Y129.978 E.00482
G1 X132.678 Y129.978 E.00482
G1 X132.678 Y130.278 E.00965
G1 X132.528 Y130.278 E.00482
G1 X132.528 Y130.612 E.01076
; WIPE_START
G1 X132.828 Y130.672 E-.11626
G1 X132.828 Y130.822 E-.057
G1 X133.278 Y130.822 E-.171
G1 X133.278 Y130.972 E-.057
G1 X133.878 Y130.972 E-.228
G1 X133.878 Y131.122 E-.057
G1 X134.072 Y131.122 E-.07374
; WIPE_END
G1 E-.04 F1800
G1 X131.478 Y124.072 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F8843.478
G1 X131.628 Y124.072 E.00482
G1 X131.628 Y124.222 E.00482
G1 X131.778 Y124.222 E.00482
G1 X131.778 Y124.372 E.00482
G1 X131.928 Y124.372 E.00483
G1 X131.928 Y124.522 E.00483
G1 X132.172 Y124.522 E.00785
G1 X132.172 Y124.222 E.00964
G1 X132.322 Y124.222 E.00482
G1 X132.322 Y124.072 E.00482
G1 X132.472 Y124.072 E.00482
G1 X132.472 Y123.922 E.00482
G1 X132.622 Y123.922 E.00482
G1 X132.622 Y123.622 E.00965
G1 X132.772 Y123.622 E.00482
G1 X132.772 Y123.472 E.00482
G1 X132.922 Y123.472 E.00482
G1 X132.922 Y123.172 E.00965
G1 X133.072 Y123.172 E.00482
G1 X133.072 Y123.022 E.00482
G1 X133.222 Y123.022 E.00482
G1 X133.222 Y122.722 E.00965
G1 X133.372 Y122.722 E.00482
G1 X133.372 Y122.422 E.00965
G1 X133.522 Y122.422 E.00482
G1 X133.522 Y122.122 E.00965
G1 X133.672 Y122.122 E.00483
G1 X133.672 Y121.878 E.00785
G1 X133.522 Y121.878 E.00482
G1 X133.522 Y121.578 E.00965
G1 X133.372 Y121.578 E.00482
G1 X133.372 Y121.428 E.00482
G1 X133.222 Y121.428 E.00482
G1 X133.222 Y121.278 E.00482
G1 X133.072 Y121.278 E.00482
G1 X133.072 Y121.128 E.00482
G1 X132.922 Y121.128 E.00482
G1 X132.922 Y120.978 E.00482
G1 X132.772 Y120.978 E.00482
G1 X132.772 Y120.828 E.00482
G1 X132.622 Y120.828 E.00482
G1 X132.622 Y120.678 E.00482
G1 X132.322 Y120.678 E.00965
G1 X132.322 Y118.278 E.07718
M73 P83 R1
G1 X131.872 Y118.278 E.01447
G1 X131.872 Y118.128 E.00482
G1 X131.328 Y118.128 E.01751
G1 X131.328 Y118.878 E.02412
G1 X131.028 Y118.878 E.00965
G1 X131.028 Y119.572 E.02233
G1 X131.178 Y119.572 E.00482
G1 X131.178 Y120.172 E.01929
G1 X131.328 Y120.172 E.00482
G1 X131.328 Y121.072 E.02894
G1 X131.478 Y121.072 E.00482
G1 X131.478 Y124.012 E.09454
; WIPE_START
G1 X131.628 Y124.072 E-.06139
G1 X131.628 Y124.222 E-.057
G1 X131.778 Y124.222 E-.057
G1 X131.778 Y124.372 E-.057
G1 X131.928 Y124.372 E-.05708
G1 X131.928 Y124.522 E-.05704
G1 X132.172 Y124.522 E-.09273
G1 X132.172 Y124.222 E-.11396
G1 X132.322 Y124.222 E-.057
G1 X132.322 Y124.072 E-.057
G1 X132.472 Y124.072 E-.057
G1 X132.472 Y123.978 E-.0358
; WIPE_END
G1 E-.04 F1800
G1 X124.944 Y122.722 Z1 F36000
G1 X122.244 Y122.272 Z1
G1 Z.6
G1 E.8 F1800
G1 F8843.478
G1 X123.078 Y122.272 E.0268
G1 X123.078 Y122.422 E.00482
G1 X123.978 Y122.422 E.02894
G1 X123.978 Y122.572 E.00482
G1 X124.428 Y122.572 E.01447
G1 X124.428 Y122.722 E.00482
G1 X125.028 Y122.722 E.01929
G1 X125.028 Y122.872 E.00482
G1 X125.328 Y122.872 E.00965
G1 X125.328 Y123.022 E.00482
G1 X125.628 Y123.022 E.00965
G1 X125.628 Y123.172 E.00482
G1 X126.172 Y123.172 E.01751
G1 X126.172 Y122.778 E.01268
G1 X126.022 Y122.778 E.00482
G1 X126.022 Y122.478 E.00965
G1 X125.872 Y122.478 E.00482
G1 X125.872 Y122.328 E.00482
G1 X125.722 Y122.328 E.00482
G1 X125.722 Y122.178 E.00482
G1 X125.572 Y122.178 E.00482
G1 X125.572 Y121.878 E.00965
G1 X125.422 Y121.878 E.00482
G1 X125.422 Y121.728 E.00482
G1 X125.272 Y121.728 E.00482
G1 X125.272 Y121.578 E.00482
G1 X125.122 Y121.578 E.00482
G1 X125.122 Y121.428 E.00482
G1 X124.972 Y121.428 E.00482
G1 X124.972 Y121.278 E.00482
G1 X124.822 Y121.278 E.00482
G1 X124.822 Y121.128 E.00482
G1 X124.522 Y121.128 E.00965
G1 X124.522 Y120.978 E.00482
G1 X124.372 Y120.978 E.00482
G1 X124.372 Y120.828 E.00482
G1 X124.072 Y120.828 E.00965
G1 X124.072 Y120.678 E.00482
G1 X123.772 Y120.678 E.00965
G1 X123.772 Y120.528 E.00482
G1 X123.472 Y120.528 E.00965
G1 X123.472 Y120.378 E.00482
G1 X123.078 Y120.378 E.01268
G1 X123.078 Y120.528 E.00482
G1 X122.628 Y120.528 E.01447
G1 X122.628 Y120.678 E.00482
G1 X122.478 Y120.678 E.00482
G1 X122.478 Y120.828 E.00482
G1 X122.178 Y120.828 E.00965
G1 X122.178 Y120.978 E.00482
G1 X122.028 Y120.978 E.00482
G1 X122.028 Y121.128 E.00482
G1 X121.878 Y121.128 E.00482
G1 X121.878 Y121.278 E.00482
G1 X121.728 Y121.278 E.00482
G1 X121.728 Y121.428 E.00482
G1 X121.578 Y121.428 E.00482
G1 X121.578 Y121.578 E.00482
G1 X121.278 Y121.578 E.00965
G1 X121.278 Y121.728 E.00482
G1 X121.128 Y121.728 E.00482
G1 X121.128 Y122.028 E.00965
G1 X120.978 Y122.028 E.00483
G1 X120.978 Y122.272 E.00785
G1 X122.184 Y122.272 E.03879
; WIPE_START
G1 X123.078 Y122.272 E-.33956
G1 X123.078 Y122.422 E-.057
G1 X123.978 Y122.422 E-.342
G1 X123.978 Y122.479 E-.02144
; WIPE_END
G1 E-.04 F1800
G1 X128.696 Y128.478 Z1 F36000
G1 X137.24 Y139.34 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S6000
G1 X137.39 Y139.34 E.00447
G1 X137.39 Y139.19 E.00447
G1 X137.69 Y139.19 E.00894
G1 X137.69 Y139.04 E.00447
G1 X137.84 Y139.04 E.00447
G1 X137.84 Y138.89 E.00447
G1 X137.99 Y138.89 E.00447
G1 X137.99 Y138.74 E.00447
G1 X138.14 Y138.74 E.00447
G1 X138.14 Y138.59 E.00447
G1 X138.29 Y138.59 E.00447
G1 X138.29 Y138.44 E.00447
G1 X138.44 Y138.44 E.00447
G1 X138.44 Y138.29 E.00447
G1 X138.59 Y138.29 E.00447
G1 X138.59 Y138.14 E.00447
G1 X138.74 Y138.14 E.00447
G1 X138.74 Y137.99 E.00447
G1 X138.89 Y137.99 E.00447
G1 X138.89 Y137.84 E.00447
G1 X139.04 Y137.84 E.00447
G1 X139.04 Y137.69 E.00447
G1 X139.19 Y137.69 E.00447
G1 X139.19 Y137.39 E.00894
G1 X139.34 Y137.39 E.00447
G1 X139.34 Y137.24 E.00447
G1 X139.49 Y137.24 E.00447
G1 X139.49 Y137.09 E.00447
G1 X139.64 Y137.09 E.00447
G1 X139.64 Y136.94 E.00447
G1 X139.79 Y136.94 E.00447
G1 X139.79 Y136.64 E.00894
G1 X139.94 Y136.64 E.00447
G1 X139.94 Y136.49 E.00447
G1 X140.09 Y136.49 E.00447
G1 X140.09 Y136.34 E.00447
G1 X140.24 Y136.34 E.00447
G1 X140.24 Y136.04 E.00894
G1 X140.39 Y136.04 E.00447
G1 X140.39 Y135.74 E.00894
G1 X140.54 Y135.74 E.00447
G1 X140.54 Y135.59 E.00447
G1 X140.69 Y135.59 E.00447
G1 X140.69 Y135.29 E.00894
G1 X140.84 Y135.29 E.00447
G1 X140.84 Y134.99 E.00894
G1 X140.99 Y134.99 E.00447
G1 X140.99 Y134.84 E.00447
G1 X141.14 Y134.84 E.00447
G1 X141.14 Y134.54 E.00894
G1 X141.29 Y134.54 E.00447
G1 X141.29 Y134.24 E.00894
G1 X141.44 Y134.24 E.00447
G1 X141.44 Y133.79 E.0134
G1 X141.59 Y133.79 E.00447
G1 X141.59 Y133.49 E.00894
G1 X141.74 Y133.49 E.00447
G1 X141.74 Y133.04 E.0134
G1 X141.89 Y133.04 E.00447
G1 X141.89 Y132.74 E.00894
G1 X142.04 Y132.74 E.00447
G1 X142.04 Y132.29 E.0134
G1 X142.19 Y132.29 E.00447
G1 X142.19 Y131.69 E.01787
G1 X142.34 Y131.69 E.00447
G1 X142.34 Y131.09 E.01787
G1 X142.49 Y131.09 E.00447
G1 X142.49 Y130.34 E.02234
G1 X142.64 Y130.34 E.00447
G1 X142.64 Y129.29 E.03128
G1 X142.79 Y129.29 E.00447
G1 X142.79 Y126.71 E.07685
G1 X142.64 Y126.71 E.00447
G1 X142.64 Y125.66 E.03128
G1 X142.49 Y125.66 E.00447
G1 X142.49 Y124.91 E.02234
G1 X142.34 Y124.91 E.00447
G1 X142.34 Y124.31 E.01787
G1 X142.19 Y124.31 E.00447
G1 X142.19 Y123.71 E.01787
G1 X142.04 Y123.71 E.00447
G1 X142.04 Y123.26 E.0134
G1 X141.89 Y123.26 E.00447
G1 X141.89 Y122.96 E.00894
G1 X141.74 Y122.96 E.00447
G1 X141.74 Y122.51 E.0134
G1 X141.59 Y122.51 E.00447
G1 X141.59 Y122.21 E.00894
G1 X141.44 Y122.21 E.00447
G1 X141.44 Y121.76 E.0134
G1 X141.29 Y121.76 E.00447
G1 X141.29 Y121.46 E.00894
G1 X141.14 Y121.46 E.00447
G1 X141.14 Y121.16 E.00894
G1 X140.99 Y121.16 E.00447
G1 X140.99 Y121.01 E.00447
G1 X140.84 Y121.01 E.00447
G1 X140.84 Y120.71 E.00894
G1 X140.69 Y120.71 E.00447
G1 X140.69 Y120.41 E.00894
G1 X140.54 Y120.41 E.00447
G1 X140.54 Y120.26 E.00447
G1 X140.39 Y120.26 E.00447
G1 X140.39 Y119.96 E.00894
G1 X140.24 Y119.96 E.00447
G1 X140.24 Y119.66 E.00894
G1 X140.09 Y119.66 E.00447
G1 X140.09 Y119.51 E.00447
G1 X139.94 Y119.51 E.00447
G1 X139.94 Y119.36 E.00447
G1 X139.79 Y119.36 E.00447
G1 X139.79 Y119.06 E.00894
G1 X139.64 Y119.06 E.00447
G1 X139.64 Y118.91 E.00447
G1 X139.49 Y118.91 E.00447
G1 X139.49 Y118.76 E.00447
G1 X139.34 Y118.76 E.00447
G1 X139.34 Y118.61 E.00447
G1 X139.19 Y118.61 E.00447
G1 X139.19 Y118.31 E.00894
G1 X139.04 Y118.31 E.00447
G1 X139.04 Y118.16 E.00447
G1 X138.89 Y118.16 E.00447
G1 X138.89 Y118.01 E.00447
G1 X138.74 Y118.01 E.00447
G1 X138.74 Y117.86 E.00447
G1 X138.59 Y117.86 E.00447
G1 X138.59 Y117.71 E.00447
G1 X138.44 Y117.71 E.00447
G1 X138.44 Y117.56 E.00447
G1 X138.29 Y117.56 E.00447
G1 X138.29 Y117.41 E.00447
G1 X138.14 Y117.41 E.00447
G1 X138.14 Y117.26 E.00447
G1 X137.99 Y117.26 E.00447
G1 X137.99 Y117.11 E.00447
G1 X137.84 Y117.11 E.00447
G1 X137.84 Y116.96 E.00447
G1 X137.69 Y116.96 E.00447
G1 X137.69 Y116.81 E.00447
G1 X137.39 Y116.81 E.00894
G1 X137.39 Y116.66 E.00447
G1 X137.24 Y116.66 E.00447
G1 X137.24 Y116.51 E.00447
G1 X137.09 Y116.51 E.00447
G1 X137.09 Y116.36 E.00447
G1 X136.94 Y116.36 E.00447
G1 X136.94 Y116.21 E.00447
G1 X136.64 Y116.21 E.00894
G1 X136.64 Y116.06 E.00447
G1 X136.49 Y116.06 E.00447
G1 X136.49 Y115.91 E.00447
G1 X136.34 Y115.91 E.00447
G1 X136.34 Y115.76 E.00447
G1 X136.04 Y115.76 E.00894
G1 X136.04 Y115.61 E.00447
G1 X135.74 Y115.61 E.00894
G1 X135.74 Y115.46 E.00447
G1 X135.59 Y115.46 E.00447
G1 X135.59 Y115.31 E.00447
G1 X135.29 Y115.31 E.00894
G1 X135.29 Y115.16 E.00447
G1 X134.99 Y115.16 E.00894
G1 X134.99 Y115.01 E.00447
G1 X134.84 Y115.01 E.00447
G1 X134.84 Y114.86 E.00447
G1 X134.54 Y114.86 E.00894
G1 X134.54 Y114.71 E.00447
G1 X134.24 Y114.71 E.00894
G1 X134.24 Y114.56 E.00447
G1 X133.79 Y114.56 E.0134
G1 X133.79 Y114.41 E.00447
G1 X133.49 Y114.41 E.00894
G1 X133.49 Y114.26 E.00447
G1 X133.04 Y114.26 E.0134
G1 X133.04 Y114.11 E.00447
G1 X132.74 Y114.11 E.00894
G1 X132.74 Y113.96 E.00447
G1 X132.29 Y113.96 E.0134
G1 X132.29 Y113.81 E.00447
G1 X131.69 Y113.81 E.01787
G1 X131.69 Y113.66 E.00447
G1 X131.09 Y113.66 E.01787
G1 X131.09 Y113.51 E.00447
G1 X130.34 Y113.51 E.02234
G1 X130.34 Y113.36 E.00447
G1 X129.29 Y113.36 E.03128
G1 X129.29 Y113.21 E.00447
G1 X126.71 Y113.21 E.07685
G1 X126.71 Y113.36 E.00447
G1 X125.66 Y113.36 E.03128
G1 X125.66 Y113.51 E.00447
G1 X124.91 Y113.51 E.02234
G1 X124.91 Y113.66 E.00447
G1 X124.31 Y113.66 E.01787
G1 X124.31 Y113.81 E.00447
G1 X123.71 Y113.81 E.01787
G1 X123.71 Y113.96 E.00447
G1 X123.26 Y113.96 E.0134
G1 X123.26 Y114.11 E.00447
G1 X122.96 Y114.11 E.00894
G1 X122.96 Y114.26 E.00447
G1 X122.51 Y114.26 E.0134
G1 X122.51 Y114.41 E.00447
G1 X122.21 Y114.41 E.00894
G1 X122.21 Y114.56 E.00447
G1 X121.76 Y114.56 E.0134
G1 X121.76 Y114.71 E.00447
G1 X121.46 Y114.71 E.00894
G1 X121.46 Y114.86 E.00447
G1 X121.16 Y114.86 E.00894
G1 X121.16 Y115.01 E.00447
G1 X121.01 Y115.01 E.00447
G1 X121.01 Y115.16 E.00447
G1 X120.71 Y115.16 E.00894
G1 X120.71 Y115.31 E.00447
G1 X120.41 Y115.31 E.00894
G1 X120.41 Y115.46 E.00447
G1 X120.26 Y115.46 E.00447
G1 X120.26 Y115.61 E.00447
G1 X119.96 Y115.61 E.00894
G1 X119.96 Y115.76 E.00447
G1 X119.66 Y115.76 E.00894
G1 X119.66 Y115.91 E.00447
G1 X119.51 Y115.91 E.00447
G1 X119.51 Y116.06 E.00447
G1 X119.36 Y116.06 E.00447
G1 X119.36 Y116.21 E.00447
G1 X119.06 Y116.21 E.00894
G1 X119.06 Y116.36 E.00447
G1 X118.91 Y116.36 E.00447
G1 X118.91 Y116.51 E.00447
G1 X118.76 Y116.51 E.00447
G1 X118.76 Y116.66 E.00447
G1 X118.61 Y116.66 E.00447
G1 X118.61 Y116.81 E.00447
G1 X118.31 Y116.81 E.00894
G1 X118.31 Y116.96 E.00447
G1 X118.16 Y116.96 E.00447
G1 X118.16 Y117.11 E.00447
G1 X118.01 Y117.11 E.00447
G1 X118.01 Y117.26 E.00447
G1 X117.86 Y117.26 E.00447
G1 X117.86 Y117.41 E.00447
G1 X117.71 Y117.41 E.00447
G1 X117.71 Y117.56 E.00447
G1 X117.56 Y117.56 E.00447
G1 X117.56 Y117.71 E.00447
G1 X117.41 Y117.71 E.00447
G1 X117.41 Y117.86 E.00447
G1 X117.26 Y117.86 E.00447
G1 X117.26 Y118.01 E.00447
G1 X117.11 Y118.01 E.00447
G1 X117.11 Y118.16 E.00447
G1 X116.96 Y118.16 E.00447
G1 X116.96 Y118.31 E.00447
G1 X116.81 Y118.31 E.00447
G1 X116.81 Y118.61 E.00894
G1 X116.66 Y118.61 E.00447
G1 X116.66 Y118.76 E.00447
G1 X116.51 Y118.76 E.00447
G1 X116.51 Y118.91 E.00447
G1 X116.36 Y118.91 E.00447
G1 X116.36 Y119.06 E.00447
G1 X116.21 Y119.06 E.00447
G1 X116.21 Y119.36 E.00894
G1 X116.06 Y119.36 E.00447
G1 X116.06 Y119.51 E.00447
G1 X115.91 Y119.51 E.00447
G1 X115.91 Y119.66 E.00447
G1 X115.76 Y119.66 E.00447
G1 X115.76 Y119.96 E.00894
G1 X115.61 Y119.96 E.00447
G1 X115.61 Y120.26 E.00894
G1 X115.46 Y120.26 E.00447
G1 X115.46 Y120.41 E.00447
G1 X115.31 Y120.41 E.00447
G1 X115.31 Y120.71 E.00894
G1 X115.16 Y120.71 E.00447
G1 X115.16 Y121.01 E.00894
G1 X115.01 Y121.01 E.00447
G1 X115.01 Y121.16 E.00447
G1 X114.86 Y121.16 E.00447
G1 X114.86 Y121.46 E.00894
G1 X114.71 Y121.46 E.00447
G1 X114.71 Y121.76 E.00894
G1 X114.56 Y121.76 E.00447
G1 X114.56 Y122.21 E.0134
G1 X114.41 Y122.21 E.00447
G1 X114.41 Y122.51 E.00894
G1 X114.26 Y122.51 E.00447
G1 X114.26 Y122.96 E.0134
G1 X114.11 Y122.96 E.00447
G1 X114.11 Y123.26 E.00894
G1 X113.96 Y123.26 E.00447
G1 X113.96 Y123.71 E.0134
G1 X113.81 Y123.71 E.00447
G1 X113.81 Y124.31 E.01787
G1 X113.66 Y124.31 E.00447
G1 X113.66 Y124.91 E.01787
G1 X113.51 Y124.91 E.00447
G1 X113.51 Y125.66 E.02234
G1 X113.36 Y125.66 E.00447
G1 X113.36 Y126.71 E.03128
G1 X113.21 Y126.71 E.00447
G1 X113.21 Y129.29 E.07685
G1 X113.36 Y129.29 E.00447
G1 X113.36 Y130.34 E.03128
G1 X113.51 Y130.34 E.00447
G1 X113.51 Y131.09 E.02234
G1 X113.66 Y131.09 E.00447
G1 X113.66 Y131.69 E.01787
G1 X113.81 Y131.69 E.00447
G1 X113.81 Y132.29 E.01787
G1 X113.96 Y132.29 E.00447
G1 X113.96 Y132.74 E.0134
G1 X114.11 Y132.74 E.00447
G1 X114.11 Y133.04 E.00894
G1 X114.26 Y133.04 E.00447
G1 X114.26 Y133.49 E.0134
G1 X114.41 Y133.49 E.00447
G1 X114.41 Y133.79 E.00894
G1 X114.56 Y133.79 E.00447
G1 X114.56 Y134.24 E.0134
G1 X114.71 Y134.24 E.00447
G1 X114.71 Y134.54 E.00894
G1 X114.86 Y134.54 E.00447
G1 X114.86 Y134.84 E.00894
G1 X115.01 Y134.84 E.00447
G1 X115.01 Y134.99 E.00447
G1 X115.16 Y134.99 E.00447
G1 X115.16 Y135.29 E.00894
G1 X115.31 Y135.29 E.00447
G1 X115.31 Y135.59 E.00894
G1 X115.46 Y135.59 E.00447
G1 X115.46 Y135.74 E.00447
G1 X115.61 Y135.74 E.00447
G1 X115.61 Y136.04 E.00894
G1 X115.76 Y136.04 E.00447
G1 X115.76 Y136.34 E.00894
G1 X115.91 Y136.34 E.00447
G1 X115.91 Y136.49 E.00447
G1 X116.06 Y136.49 E.00447
G1 X116.06 Y136.64 E.00447
G1 X116.21 Y136.64 E.00447
G1 X116.21 Y136.94 E.00894
G1 X116.36 Y136.94 E.00447
G1 X116.36 Y137.09 E.00447
G1 X116.51 Y137.09 E.00447
G1 X116.51 Y137.24 E.00447
G1 X116.66 Y137.24 E.00447
G1 X116.66 Y137.39 E.00447
G1 X116.81 Y137.39 E.00447
G1 X116.81 Y137.69 E.00894
G1 X116.96 Y137.69 E.00447
G1 X116.96 Y137.84 E.00447
G1 X117.11 Y137.84 E.00447
G1 X117.11 Y137.99 E.00447
G1 X117.26 Y137.99 E.00447
G1 X117.26 Y138.14 E.00447
G1 X117.41 Y138.14 E.00447
G1 X117.41 Y138.29 E.00447
G1 X117.56 Y138.29 E.00447
G1 X117.56 Y138.44 E.00447
G1 X117.71 Y138.44 E.00447
G1 X117.71 Y138.59 E.00447
G1 X117.86 Y138.59 E.00447
G1 X117.86 Y138.74 E.00447
G1 X118.01 Y138.74 E.00447
G1 X118.01 Y138.89 E.00447
G1 X118.16 Y138.89 E.00447
G1 X118.16 Y139.04 E.00447
G1 X118.31 Y139.04 E.00447
G1 X118.31 Y139.19 E.00447
G1 X118.61 Y139.19 E.00894
G1 X118.61 Y139.34 E.00447
G1 X118.76 Y139.34 E.00447
G1 X118.76 Y139.49 E.00447
G1 X118.91 Y139.49 E.00447
G1 X118.91 Y139.64 E.00447
G1 X119.06 Y139.64 E.00447
G1 X119.06 Y139.79 E.00447
G1 X119.36 Y139.79 E.00894
G1 X119.36 Y139.94 E.00447
G1 X119.51 Y139.94 E.00447
G1 X119.51 Y140.09 E.00447
G1 X119.66 Y140.09 E.00447
G1 X119.66 Y140.24 E.00447
G1 X119.96 Y140.24 E.00894
G1 X119.96 Y140.39 E.00447
G1 X120.26 Y140.39 E.00894
G1 X120.26 Y140.54 E.00447
G1 X120.41 Y140.54 E.00447
G1 X120.41 Y140.69 E.00447
G1 X120.71 Y140.69 E.00894
G1 X120.71 Y140.84 E.00447
G1 X121.01 Y140.84 E.00894
G1 X121.01 Y140.99 E.00447
G1 X121.16 Y140.99 E.00447
G1 X121.16 Y141.14 E.00447
G1 X121.46 Y141.14 E.00894
G1 X121.46 Y141.29 E.00447
G1 X121.76 Y141.29 E.00894
G1 X121.76 Y141.44 E.00447
G1 X122.21 Y141.44 E.0134
G1 X122.21 Y141.59 E.00447
G1 X122.51 Y141.59 E.00894
G1 X122.51 Y141.74 E.00447
G1 X122.96 Y141.74 E.0134
G1 X122.96 Y141.89 E.00447
G1 X123.26 Y141.89 E.00894
G1 X123.26 Y142.04 E.00447
G1 X123.71 Y142.04 E.0134
G1 X123.71 Y142.19 E.00447
G1 X124.31 Y142.19 E.01787
G1 X124.31 Y142.34 E.00447
G1 X124.91 Y142.34 E.01787
G1 X124.91 Y142.49 E.00447
G1 X125.66 Y142.49 E.02234
G1 X125.66 Y142.64 E.00447
G1 X126.71 Y142.64 E.03128
G1 X126.71 Y142.79 E.00447
G1 X129.29 Y142.79 E.07685
G1 X129.29 Y142.64 E.00447
G1 X130.34 Y142.64 E.03128
G1 X130.34 Y142.49 E.00447
G1 X131.09 Y142.49 E.02234
G1 X131.09 Y142.34 E.00447
G1 X131.69 Y142.34 E.01787
G1 X131.69 Y142.19 E.00447
G1 X132.29 Y142.19 E.01787
G1 X132.29 Y142.04 E.00447
G1 X132.74 Y142.04 E.0134
G1 X132.74 Y141.89 E.00447
G1 X133.04 Y141.89 E.00894
G1 X133.04 Y141.74 E.00447
G1 X133.49 Y141.74 E.0134
G1 X133.49 Y141.59 E.00447
G1 X133.79 Y141.59 E.00894
G1 X133.79 Y141.44 E.00447
G1 X134.24 Y141.44 E.0134
G1 X134.24 Y141.29 E.00447
G1 X134.54 Y141.29 E.00894
G1 X134.54 Y141.14 E.00447
G1 X134.84 Y141.14 E.00894
G1 X134.84 Y140.99 E.00447
G1 X134.99 Y140.99 E.00447
G1 X134.99 Y140.84 E.00447
G1 X135.29 Y140.84 E.00894
G1 X135.29 Y140.69 E.00447
G1 X135.59 Y140.69 E.00894
G1 X135.59 Y140.54 E.00447
G1 X135.74 Y140.54 E.00447
G1 X135.74 Y140.39 E.00447
G1 X136.04 Y140.39 E.00894
G1 X136.04 Y140.24 E.00447
G1 X136.34 Y140.24 E.00894
G1 X136.34 Y140.09 E.00447
G1 X136.49 Y140.09 E.00447
G1 X136.49 Y139.94 E.00447
G1 X136.64 Y139.94 E.00447
G1 X136.64 Y139.79 E.00447
G1 X136.94 Y139.79 E.00894
G1 X136.94 Y139.64 E.00447
G1 X137.09 Y139.64 E.00447
G1 X137.09 Y139.49 E.00447
G1 X137.24 Y139.49 E.00447
G1 X137.24 Y139.4 E.00268
; WIPE_START
M204 S10000
G1 X137.39 Y139.34 E-.06139
G1 X137.39 Y139.19 E-.057
G1 X137.69 Y139.19 E-.114
G1 X137.69 Y139.04 E-.057
G1 X137.84 Y139.04 E-.057
G1 X137.84 Y138.89 E-.057
G1 X137.99 Y138.89 E-.057
G1 X137.99 Y138.74 E-.057
G1 X138.14 Y138.74 E-.057
G1 X138.14 Y138.59 E-.057
G1 X138.29 Y138.59 E-.057
G1 X138.29 Y138.44 E-.057
G1 X138.328 Y138.44 E-.01461
; WIPE_END
G1 E-.04 F1800
G1 X130.941 Y136.523 Z1 F36000
G1 X130.469 Y136.4 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.18031
G1 F15000
G1 X130.319 Y136.4 E.00163
; LINE_WIDTH: 0.203217
G1 X130.273 Y136.377 E.00065
; LINE_WIDTH: 0.24901
G1 X130.227 Y136.354 E.00083
; LINE_WIDTH: 0.294804
G1 F14292.333
G1 X130.181 Y136.331 E.00102
; LINE_WIDTH: 0.326615
G1 F12689.688
G1 X130.169 Y136.325 E.00032
; LINE_WIDTH: 0.344522
G1 F11936.26
G1 X130.105 Y136.311 E.00156
; LINE_WIDTH: 0.356556
G1 F11478.288
G1 X130.041 Y136.297 E.00162
G3 X130.019 Y136.031 I.679 J-.19 E.00663
; WIPE_START
G1 X130.019 Y136.181 E-.34251
G1 X130.041 Y136.297 E-.26805
G1 X130.105 Y136.311 E-.14945
; WIPE_END
G1 E-.04 F1800
G1 X127.528 Y133.122 Z1 F36000
G1 Z.6
M73 P84 R1
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.518727
G1 F7566.101
G1 X127.047 Y133.122 E.01807
G1 X127.034 Y133.522 E.01504
; LINE_WIDTH: 0.478955
G1 F8256.218
G1 X126.999 Y133.575 E.00219
; LINE_WIDTH: 0.42058
G1 F9532.393
G3 X126.871 Y133.676 I-.161 J-.071 E.00507
G3 X126.92 Y134.048 I-.512 J.257 E.01138
G1 X127.053 Y134.14 E.00484
G1 X127.07 Y134.343 E.00606
G1 X127.196 Y134.427 E.00453
G1 X127.22 Y134.643 E.00648
G1 X127.346 Y134.727 E.00453
G1 X127.37 Y134.943 E.00648
G1 X127.494 Y135.023 E.00441
G1 X127.52 Y135.243 E.0066
G1 X127.645 Y135.326 E.00448
G1 X127.662 Y135.388 E.00193
G1 X127.785 Y135.459 E.00425
G1 X127.812 Y135.538 E.00248
G1 X127.944 Y135.623 E.00469
G1 X127.97 Y135.843 E.0066
G1 X128.082 Y135.906 E.00384
G1 X128.107 Y135.98 E.00235
G1 X128.341 Y136.015 E.00704
G1 X128.557 Y136.28 E.01021
G1 X128.759 Y136.297 E.00604
G1 X128.851 Y136.386 E.00382
G1 X128.863 Y136.437 E.00157
G1 X128.969 Y136.49 E.00356
G1 X129.005 Y136.58 E.00288
G1 X129.394 Y136.58 E.01161
G3 X129.493 Y136.467 I.106 J-.007 E.00499
G3 X129.447 Y135.852 I3.776 J-.592 E.01842
G1 X129.252 Y135.67 E.00794
G1 X129.238 Y135.612 E.00178
G1 X129.115 Y135.541 E.00424
G1 X129.088 Y135.462 E.00248
G1 X128.965 Y135.391 E.00424
G1 X128.938 Y135.312 E.00248
G1 X128.805 Y135.224 E.00476
G1 X128.788 Y135.162 E.00193
G1 X128.665 Y135.091 E.00425
G1 X128.638 Y135.012 E.00248
G1 X128.515 Y134.941 E.00424
G1 X128.48 Y134.707 E.00704
G1 X128.355 Y134.624 E.00448
G1 X128.338 Y134.562 E.00193
G1 X128.225 Y134.504 E.0038
G3 X128.18 Y134.257 I.313 J-.184 E.00763
G1 X128.054 Y134.173 E.00453
G1 X128.03 Y133.957 E.00648
G1 X127.904 Y133.872 E.00454
G1 X127.888 Y133.812 E.00186
G1 X127.763 Y133.738 E.00432
G3 X127.719 Y133.514 I.25 J-.165 E.00698
; LINE_WIDTH: 0.455928
G1 F8716.549
G1 X127.639 Y133.466 E.00306
; LINE_WIDTH: 0.484383
G1 F8154.713
G1 X127.558 Y133.418 E.00327
; LINE_WIDTH: 0.511625
G1 F7680.737
G1 X127.534 Y133.182 E.0088
G1 X127.34 Y133.819 F36000
; LINE_WIDTH: 0.519055
G1 F7560.881
G1 X127.492 Y134.085 E.01155
; LINE_WIDTH: 0.560051
G1 F6961.496
G2 X128.15 Y135.2 I12.368 J-6.55 E.0529
G1 X128.708 Y135.758 E.03221
; WIPE_START
G1 X128.15 Y135.2 E-.29964
G1 X127.882 Y134.795 E-.18437
G1 X127.532 Y134.159 E-.27599
; WIPE_END
G1 E-.04 F1800
G1 X126.506 Y133.319 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.19282
G1 F15000
G1 X126.506 Y132.881 E.00518
G1 X125.957 Y132.968 F36000
G1 F15000
G1 X125.957 Y132.632 E.00398
; WIPE_START
G1 X125.957 Y132.968 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.719 Y131.144 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X120.569 Y131.144 E.00178
; LINE_WIDTH: 0.217804
G1 X120.519 Y131.169 E.00077
; LINE_WIDTH: 0.26777
G1 X120.469 Y131.194 E.00099
; LINE_WIDTH: 0.317737
G1 F13099.642
G1 X120.419 Y131.219 E.00121
; LINE_WIDTH: 0.35993
G1 F11356.12
G1 X120.397 Y131.241 E.00079
G1 X120.425 Y131.369 E.00328
; LINE_WIDTH: 0.326613
G1 F12689.798
G1 X120.431 Y131.381 E.00032
; LINE_WIDTH: 0.294804
G1 F14292.333
G1 X120.454 Y131.427 E.00102
; LINE_WIDTH: 0.24901
G1 F15000
G1 X120.477 Y131.473 E.00083
; LINE_WIDTH: 0.18614
G1 X120.5 Y131.519 E.00058
G1 X120.5 Y131.669 E.0017
; WIPE_START
G1 X120.5 Y131.519 E-.56658
G1 X120.477 Y131.473 E-.19342
; WIPE_END
G1 E-.04 F1800
G1 X120.333 Y130.21 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.46308
G1 F8568.165
G1 X120.407 Y130.103 E.00433
; LINE_WIDTH: 0.432191
G1 F9248.075
G2 X120.542 Y129.864 I-.637 J-.516 E.00846
; WIPE_START
G1 X120.407 Y130.103 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.924 Y128.601 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.55051
G1 F7092.338
G1 X122.027 Y128.528 E.00507
; LINE_WIDTH: 0.500584
G1 F7866.039
G2 X122.322 Y128.258 I-.54 J-.883 E.01455
G2 X122.322 Y128.355 I-.028 J.049 E.00852
; LINE_WIDTH: 0.474837
G1 F8334.942
G1 X122.396 Y128.304 E.00307
; LINE_WIDTH: 0.43807
G1 F9110.464
G1 X122.469 Y128.252 E.00281
; LINE_WIDTH: 0.385028
G1 F10522.995
G1 X122.543 Y128.201 E.00243
G1 X122.479 Y128.238 E.00199
G1 X122.479 Y128.164 E.00199
G1 X122.522 Y128.164 E.00115
G1 X122.549 Y128.1 E.00188
G1 X122.888 Y127.988 E.00965
G1 X122.895 Y127.91 E.00213
; WIPE_START
G1 X122.888 Y127.988 E-.07619
G1 X122.549 Y128.1 E-.3458
G1 X122.522 Y128.164 E-.06719
G1 X122.479 Y128.164 E-.04114
G1 X122.479 Y128.238 E-.07127
G1 X122.543 Y128.201 E-.07126
G1 X122.469 Y128.252 E-.08715
; WIPE_END
G1 E-.04 F1800
G1 X121.924 Y128.601 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.546652
G1 F7146.668
G1 X121.781 Y128.629 E.00578
; LINE_WIDTH: 0.507354
G1 F7751.375
G1 X121.639 Y128.658 E.00533
; LINE_WIDTH: 0.468057
G1 F8467.873
G1 X121.496 Y128.686 E.00488
; LINE_WIDTH: 0.419302
G1 F9564.763
G1 X121.354 Y128.714 E.00432
G1 X121.278 Y128.838 E.0043
; LINE_WIDTH: 0.427465
G1 F9361.713
G1 X121.23 Y128.868 E.00174
; LINE_WIDTH: 0.472374
G1 F8382.75
G3 X121.076 Y128.899 I-.101 J-.105 E.00559
; LINE_WIDTH: 0.51056
G1 F7698.236
G1 X121.007 Y129.032 E.00555
G1 X120.949 Y129.049 E.00224
G1 X120.857 Y129.182 E.00598
G1 X120.799 Y129.199 E.00224
; LINE_WIDTH: 0.517151
G1 F7591.239
G1 X120.719 Y129.336 E.00595
G1 X120.483 Y129.359 E.00888
G1 X120.438 Y129.447 E.00369
; LINE_WIDTH: 0.47611
G1 F8310.442
G1 X120.326 Y129.476 E.00397
; LINE_WIDTH: 0.420326
G1 F9538.821
G1 X120.244 Y129.582 E.00399
G1 X120.17 Y129.607 E.00234
G1 X120.134 Y129.842 E.00709
G1 X119.84 Y130.109 E.01183
; LINE_WIDTH: 0.415842
G1 F9653.503
G1 X119.681 Y130.175 E.00506
G1 X119.84 Y130.241 E.00506
G1 X119.87 Y130.443 E.00601
G1 X119.972 Y130.494 E.00337
G1 X120.069 Y130.759 E.00833
G1 X120.276 Y130.616 E.00743
G2 X120.68 Y130.566 I.098 J-.869 E.0121
G1 X120.714 Y130.361 E.0061
G1 X120.83 Y130.293 E.00398
G1 X120.866 Y130.058 E.00701
; LINE_WIDTH: 0.441438
G1 F9033.481
G1 X120.889 Y130.011 E.00165
; LINE_WIDTH: 0.498388
G1 F7903.956
G3 X120.978 Y129.888 I.269 J.101 E.0055
; LINE_WIDTH: 0.525492
G1 F7460.037
G3 X121.072 Y129.804 I.1 J.018 E.0052
G1 X121.088 Y129.63 E.00667
G1 X121.193 Y129.518 E.00586
G1 X121.251 Y129.501 E.00231
G1 X121.327 Y129.38 E.00546
G1 X121.382 Y129.361 E.00223
; LINE_WIDTH: 0.496935
G1 F7929.253
G1 X121.415 Y129.192 E.00617
; LINE_WIDTH: 0.461393
G1 F8602.716
G1 X121.514 Y129.107 E.00431
; LINE_WIDTH: 0.427458
G1 F9361.896
G1 X121.612 Y129.022 E.00396
; LINE_WIDTH: 0.398955
G1 F10111.366
G1 X121.764 Y128.893 E.0056
; LINE_WIDTH: 0.412025
G1 F9753.323
G1 X121.781 Y128.844 E.00152
; LINE_WIDTH: 0.461235
G1 F8605.955
G1 X121.798 Y128.795 E.00172
; LINE_WIDTH: 0.510445
G1 F7700.123
G1 X121.815 Y128.745 E.00192
; LINE_WIDTH: 0.550675
G1 F7090.034
G1 X121.888 Y128.649 E.00484
; WIPE_START
G1 X121.815 Y128.745 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.032 Y127.307 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.19282
G1 F15000
G1 X123.368 Y127.307 E.00398
; WIPE_START
G1 X123.032 Y127.307 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.276 Y122.669 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.46782
G1 F8472.582
G1 X125.207 Y122.473 E.00697
; LINE_WIDTH: 0.41782
G1 F9602.562
G1 X125.138 Y122.277 E.00615
; LINE_WIDTH: 0.367806
G1 F11080.828
G1 X125.069 Y122.081 E.00533
; LINE_WIDTH: 0.317737
G1 F13099.642
G1 X125.044 Y122.031 E.00121
; LINE_WIDTH: 0.26777
G1 F15000
G1 X125.019 Y121.981 E.00099
; LINE_WIDTH: 0.199601
G1 X124.994 Y121.931 E.00069
G1 X124.994 Y121.781 E.00186
G1 X124.919 Y122.069 F36000
; LINE_WIDTH: 0.317872
G1 F13093.201
G1 X125.381 Y122.531 E.01421
; LINE_WIDTH: 0.2948
G1 F14292.522
G1 X125.427 Y122.554 E.00102
; LINE_WIDTH: 0.249
G1 F15000
G1 X125.473 Y122.577 E.00083
; LINE_WIDTH: 0.2032
G1 X125.519 Y122.6 E.00065
; LINE_WIDTH: 0.187031
G3 X125.588 Y122.612 I.006 J.174 E.00081
G2 X125.612 Y122.738 I1.761 J-.263 E.00146
G2 X125.819 Y122.75 I.132 J-.493 E.00238
G1 X126.443 Y122.732 F36000
; LINE_WIDTH: 0.198595
G1 F15000
G1 X126.443 Y123.032 E.00369
G1 X126.468 Y123.118 E.00111
; LINE_WIDTH: 0.231139
G2 X126.668 Y123.125 I.125 J-.742 E.00298
; WIPE_START
G1 X126.468 Y123.118 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.345 Y122.16 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.41999
G1 F9547.299
G1 X124.502 Y121.732 E.01358
G2 X124.443 Y121.52 I-.193 J-.061 E.00693
G1 X124.262 Y121.511 E.0054
G1 X124.151 Y121.418 E.00431
G1 X124.138 Y121.362 E.0017
G1 X124.018 Y121.294 E.0041
G1 X123.993 Y121.22 E.00234
G1 X123.79 Y121.203 E.00605
G3 X123.693 Y121.07 I.055 J-.142 E.00519
G1 X123.459 Y121.035 E.00703
G1 X123.396 Y120.92 E.00391
G1 X123.004 Y120.92 E.0117
G1 X122.922 Y121.046 E.00448
G1 X122.862 Y121.062 E.00186
G1 X122.833 Y121.144 E.00259
G1 X122.672 Y121.22 E.00529
G1 X122.558 Y121.22 E.00342
G1 X122.495 Y121.448 E.00704
G1 X122.564 Y121.566 E.00409
G1 X122.504 Y121.88 E.00952
G1 X123.281 Y121.88 E.02316
G1 X123.405 Y121.927 E.00394
G1 X123.452 Y122.03 E.00339
G1 X124.181 Y122.03 E.02171
G1 X124.282 Y122.059 E.00313
G1 X124.314 Y122.109 E.00176
; WIPE_START
G1 X124.282 Y122.059 E-.02243
G1 X124.181 Y122.03 E-.03989
G1 X123.452 Y122.03 E-.27701
G1 X123.405 Y121.927 E-.04322
G1 X123.281 Y121.88 E-.05031
G1 X122.504 Y121.88 E-.29544
G1 X122.52 Y121.798 E-.03171
; WIPE_END
G1 E-.04 F1800
G1 X123.203 Y121.419 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.569545
G1 F6835.984
G1 X123.329 Y121.451 E.00542
; LINE_WIDTH: 0.517729
G1 F7582.001
G3 X123.629 Y121.581 I-.087 J.611 E.0124
; WIPE_START
G1 X123.456 Y121.482 E-.45979
G1 X123.329 Y121.451 E-.30021
; WIPE_END
G1 E-.04 F1800
G1 X122.006 Y121.631 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.217804
G1 F15000
G1 X121.981 Y121.681 E.00077
; LINE_WIDTH: 0.26777
G1 X121.956 Y121.731 E.00099
; LINE_WIDTH: 0.317791
G1 F13097.068
G1 X121.931 Y121.781 E.00122
; LINE_WIDTH: 0.361682
G1 F11293.695
G1 X121.909 Y121.897 E.00296
G1 X121.781 Y121.925 E.0033
; LINE_WIDTH: 0.32997
G1 F12541.392
G1 X121.619 Y121.931 E.00369
; LINE_WIDTH: 0.294804
G1 F14292.333
G1 X121.573 Y121.954 E.00102
; LINE_WIDTH: 0.24901
G1 F15000
G1 X121.527 Y121.977 E.00083
; LINE_WIDTH: 0.18614
G1 X121.481 Y122 E.00058
G1 X121.331 Y122 E.0017
G1 X122.006 Y121.631 F36000
; LINE_WIDTH: 0.19282
G1 F15000
G1 X122.006 Y121.481 E.00178
; WIPE_START
G1 X122.006 Y121.631 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.243 Y119.207 Z1 F36000
G1 X130.532 Y118.775 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.209638
G1 F15000
G3 X130.732 Y118.782 I.075 J.751 E.00264
G1 X130.757 Y118.868 E.00119
G1 X130.757 Y119.168 E.00395
; WIPE_START
G1 X130.757 Y118.868 E-.38632
G1 X130.732 Y118.782 E-.11605
G1 X130.532 Y118.775 E-.25763
; WIPE_END
G1 E-.04 F1800
G1 X131.55 Y118.485 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S2000
G1 X132.1 Y119.035 E.02316
G1 X132.233 Y119.169
G1 X132.233 Y119.702
G1 X132.1 Y119.568
G1 X131.55 Y119.019 E.02316
G1 X131.417 Y118.885
G1 X131.267 Y119.268
G1 X131.4 Y119.402
G1 X132.085 Y120.087 E.02886
M204 S10000
G1 X131.791 Y120.094 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.187712
G1 F15000
G1 X131.609 Y119.987 E.00241
G1 X131.381 Y119.749 E.00377
; WIPE_START
G1 X131.609 Y119.987 E-.46357
G1 X131.791 Y120.094 E-.29643
; WIPE_END
G1 E-.04 F1800
G1 X131.618 Y117.857 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.19282
G1 F15000
G1 X131.132 Y117.857 E.00576
; WIPE_START
G1 X131.618 Y117.857 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.244 Y121.781 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X133.244 Y122.219 E.00518
; WIPE_START
G1 X133.244 Y121.781 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.975 Y123.869 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.417254
G1 F9617.093
G1 X132.046 Y123.712 E.00508
G1 X132.1 Y123.7 E.00164
G1 X132.159 Y123.57 E.00422
G1 X132.234 Y123.546 E.00233
G1 X132.234 Y123.419 E.00375
G1 X132.318 Y123.259 E.00533
G1 X132.389 Y123.239 E.00218
G1 X132.456 Y123.118 E.00408
G1 X132.53 Y123.093 E.00232
G1 X132.532 Y122.943 E.00443
G1 X132.636 Y122.799 E.00524
G1 X132.687 Y122.787 E.00157
G1 X132.711 Y122.715 E.00225
G1 X132.83 Y122.596 E.00497
G1 X132.83 Y122.566 E.00091
G1 X132.755 Y122.422 E.00478
G1 X132.755 Y121.607 E.0241
G1 X132.551 Y121.418 E.00824
G1 X132.538 Y121.362 E.00169
G1 X132.409 Y121.282 E.00448
G1 X132.389 Y121.211 E.00218
G1 X132.268 Y121.144 E.00408
G1 X132.243 Y121.07 E.00232
G1 X132.109 Y121.07 E.00395
; LINE_WIDTH: 0.435903
G1 F9160.714
G1 X132.005 Y120.994 E.00398
; LINE_WIDTH: 0.454964
G1 F8736.932
G1 X131.902 Y120.919 E.00417
G1 X131.87 Y121.438 E.01691
; LINE_WIDTH: 0.415516
G1 F9661.939
G3 X131.851 Y123.704 I-50.513 J.714 E.06671
G1 X131.914 Y123.721 E.00193
G1 X131.952 Y123.813 E.00294
; WIPE_START
G1 X131.914 Y123.721 E-.03799
G1 X131.851 Y123.704 E-.02487
G1 X131.87 Y123.012 E-.26307
G1 X131.87 Y121.87 E-.43407
; WIPE_END
G1 E-.04 F1800
G1 X132.313 Y121.814 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.551181
G1 F7082.98
G1 X132.313 Y122.422 E.02441
; WIPE_START
G1 X132.313 Y121.814 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.825 Y120.394 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.63032
G1 F6128.703
G1 X131.825 Y120.613 E.01012
; LINE_WIDTH: 0.605874
G1 F6394.847
G1 X131.846 Y120.695 E.0038
; LINE_WIDTH: 0.55698
G1 F7003.074
G1 X131.866 Y120.778 E.00347
; LINE_WIDTH: 0.508087
G1 F7739.161
G1 X131.887 Y120.861 E.00314
; WIPE_START
G1 X131.866 Y120.778 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.882 Y124.793 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.192803
G1 F15000
G1 X132.218 Y124.793 E.00398
; WIPE_START
G1 X131.882 Y124.793 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.257 Y130.382 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.19282
G1 F15000
G1 X132.257 Y130.718 E.00398
; WIPE_START
G1 X132.257 Y130.382 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.03 Y130.191 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.42475
G1 F9428.281
G1 X135.078 Y130.167 E.0016
; WIPE_START
G1 X135.03 Y130.191 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.376 Y130.325 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.611003
G1 F6337.108
G1 X133.429 Y130.344 E.00252
; LINE_WIDTH: 0.572368
G1 F6799.541
G1 X133.481 Y130.364 E.00234
; LINE_WIDTH: 0.529479
G1 F7398.908
G1 X133.531 Y130.412 E.00266
; LINE_WIDTH: 0.482335
G1 F8192.711
G1 X133.58 Y130.461 E.00241
; LINE_WIDTH: 0.419106
G1 F9569.749
G3 X133.654 Y130.584 I-.082 J.133 E.00445
G1 X134.143 Y130.591 E.01453
G3 X134.253 Y130.73 I-.043 J.147 E.00563
G1 X134.797 Y130.73 E.01616
G1 X134.872 Y130.607 E.00428
G1 X135.247 Y130.58 E.01119
; LINE_WIDTH: 0.440928
G1 F9045.055
G1 X135.316 Y130.485 E.00368
; LINE_WIDTH: 0.493853
G1 F7983.455
G1 X135.384 Y130.391 E.00416
G1 X135.515 Y130.388 E.00465
; LINE_WIDTH: 0.52137
G1 F7524.297
G1 X135.609 Y130.246 E.00643
; LINE_WIDTH: 0.558671
G1 F6980.112
G1 X135.733 Y130.096 E.00797
G1 X135.96 Y130.012 E.00984
; LINE_WIDTH: 0.541433
G1 F7221.484
G1 X136.153 Y129.852 E.00987
; LINE_WIDTH: 0.484228
G1 F8157.568
G1 X136.346 Y129.692 E.00874
G1 X136.417 Y129.667 E.00263
G1 X136.541 Y129.518 E.00676
G1 X136.554 Y129.48 E.00139
G1 X136.4 Y129.393 E.00619
G1 X136.331 Y129.196 E.00725
G1 X136.23 Y129.196 E.00354
G3 X135.939 Y129.368 I-.263 J-.114 E.01258
G1 X135.862 Y129.478 E.0047
; LINE_WIDTH: 0.558469
G1 F6982.846
G3 X135.655 Y129.542 I-.169 J-.181 E.00912
G1 X135.615 Y129.617 E.00346
G1 X135.431 Y129.692 E.00807
G1 X135.355 Y129.692 E.0031
G1 X135.296 Y129.777 E.00423
; LINE_WIDTH: 0.53005
G1 F7390.225
G1 X135.232 Y129.781 E.00244
; LINE_WIDTH: 0.48125
G1 F8212.99
G1 X135.169 Y129.785 E.0022
; LINE_WIDTH: 0.423637
G1 F9455.859
G1 X134.853 Y129.77 E.00952
G1 X134.778 Y129.893 E.00433
G1 X134.403 Y129.92 E.01132
G1 X134.309 Y130.053 E.00489
G1 X133.955 Y130.069 E.01068
G1 X133.912 Y130.165 E.00317
; LINE_WIDTH: 0.439034
G1 F9088.293
G1 X133.816 Y130.194 E.00312
; LINE_WIDTH: 0.481542
G1 F8207.523
G1 X133.721 Y130.222 E.00346
; LINE_WIDTH: 0.52405
G1 F7482.385
G1 X133.625 Y130.251 E.0038
; LINE_WIDTH: 0.566558
G1 F6874.978
G1 X133.529 Y130.279 E.00413
; LINE_WIDTH: 0.609066
G1 F6358.784
G1 X133.434 Y130.308 E.00447
G1 X133.025 Y130.325 F36000
; LINE_WIDTH: 0.40766
G1 F9870.044
G1 X133.083 Y130.325 E.00168
; LINE_WIDTH: 0.45714
G1 F8691.034
G1 X133.141 Y130.325 E.0019
; LINE_WIDTH: 0.50662
G1 F7763.64
G1 X133.2 Y130.325 E.00213
; LINE_WIDTH: 0.5561
G1 F7015.083
G1 X133.258 Y130.325 E.00236
; LINE_WIDTH: 0.60558
G1 F6398.18
G1 X133.316 Y130.325 E.00259
; WIPE_START
G1 X133.258 Y130.325 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.918 Y128.968 Z1 F36000
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.38359
G1 F10567.409
G3 X136.904 Y128.759 I.176 J-.117 E.00593
; LINE_WIDTH: 0.351074
G1 F11682.485
G1 X136.925 Y128.681 E.00195
; LINE_WIDTH: 0.326612
G1 F12689.819
G1 X136.931 Y128.669 E.00032
; LINE_WIDTH: 0.294804
G1 F14292.333
G1 X136.954 Y128.623 E.00102
; LINE_WIDTH: 0.24901
G1 F15000
G1 X136.977 Y128.577 E.00083
; LINE_WIDTH: 0.203217
G1 X137 Y128.531 E.00065
; LINE_WIDTH: 0.186981
G3 X137.012 Y128.462 I.174 J-.006 E.00081
G2 X137.138 Y128.438 I-.264 J-1.768 E.00146
G2 X137.15 Y128.231 I-.493 J-.132 E.00238
G1 X137.132 Y127.607 F36000
; LINE_WIDTH: 0.199612
G1 F15000
G1 X137.282 Y127.607 E.00186
G1 X137.332 Y127.582 E.00069
; LINE_WIDTH: 0.267757
G1 X137.382 Y127.557 E.00099
; LINE_WIDTH: 0.317715
G1 F13100.687
G1 X137.432 Y127.532 E.00121
; LINE_WIDTH: 0.33419
G1 F12359.666
G1 X137.466 Y127.53 E.0008
G1 X137.486 Y127.48 E.00122
; LINE_WIDTH: 0.28813
G1 F14681.313
G1 X137.505 Y127.431 E.00103
; LINE_WIDTH: 0.249017
G1 F15000
G1 X137.525 Y127.382 E.00086
; LINE_WIDTH: 0.22944
G1 X137.525 Y127.232 E.00221
; WIPE_START
G1 X137.525 Y127.382 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.918 Y128.968 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.34314
G1 F11991.206
G1 X137.069 Y129.119 E.00504
; WIPE_START
G1 X136.918 Y128.968 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X136.36 Y121.356 Z1 F36000
G1 X135.964 Y115.967 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F9547.055
M204 S2000
G1 X140.033 Y120.036 E.17137
; WIPE_START
M204 S10000
G1 X138.618 Y118.621 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.633 Y121.169 Z1 F36000
G1 Z.6
G1 E.8 F1800
M73 P85 R1
G1 F9547.055
M204 S2000
G1 X134.831 Y115.367 E.24438
; WIPE_START
M204 S10000
G1 X136.245 Y116.782 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.698 Y114.767 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X141.233 Y122.302 E.31739
G1 X141.366 Y122.436
G1 X141.666 Y123.269
G1 X141.533 Y123.135
G1 X132.865 Y114.467 E.36513
G1 X132.731 Y114.334
G1 X131.748 Y113.884
G1 X131.881 Y114.017
G1 X141.983 Y124.119 E.42551
G1 X142.116 Y124.252
G1 X142.266 Y124.935
G1 X142.133 Y124.802
G1 X131.198 Y113.867 E.46061
G1 X131.065 Y113.734
G1 X130.381 Y113.584
G1 X130.515 Y113.717
G1 X142.283 Y125.485 E.49571
G1 X142.416 Y125.619
G1 X142.566 Y126.302
G1 X142.433 Y126.168
G1 X129.832 Y113.567 E.53081
G1 X129.698 Y113.434
G1 X129.165 Y113.434
G1 X129.298 Y113.567
G1 X142.433 Y126.702 E.55327
G1 X142.566 Y126.835
G1 X142.716 Y127.518
G1 X142.583 Y127.385
G1 X128.615 Y113.417 E.58837
G1 X128.482 Y113.284
G1 X127.948 Y113.284
G1 X128.082 Y113.417
G1 X142.583 Y127.918 E.61084
G1 X142.716 Y128.052
G1 X142.716 Y128.585
G1 X142.583 Y128.451
G1 X132.545 Y118.413 E.42284
G1 X132.411 Y118.28
G1 X132.411 Y118.813
G1 X132.545 Y118.947
G1 X142.583 Y128.985 E.42284
G1 X142.716 Y129.118
G1 X142.566 Y129.502
G1 X142.433 Y129.368
G1 X132.545 Y119.48 E.41652
G1 X132.411 Y119.346
G1 X132.411 Y119.88
G1 X132.545 Y120.013
G1 X142.433 Y129.901 E.41652
G1 X142.566 Y130.035
G1 X142.416 Y130.418
G1 X142.283 Y130.284
G1 X133.895 Y121.896 E.35334
G1 X133.761 Y121.763
G1 X133.676 Y122.211
G1 X133.81 Y122.345
G1 X142.283 Y130.818 E.35692
G1 X142.416 Y130.951
G1 X142.266 Y131.335
G1 X142.133 Y131.201
G1 X133.595 Y122.663 E.35966
G1 X133.461 Y122.529
G1 X133.311 Y122.913
G1 X133.445 Y123.046
G1 X137.555 Y127.157 E.17316
G1 X137.689 Y127.29
G1 X137.389 Y127.524
G1 X137.255 Y127.39
G1 X133.26 Y123.395 E.1683
G1 X133.126 Y123.261
G1 X132.893 Y123.561
G1 X133.027 Y123.695
G1 X136.987 Y127.655 E.16684
G1 X137.121 Y127.789
G1 X136.789 Y127.99
G1 X136.655 Y127.857
G1 X132.845 Y124.046 E.16052
G1 X132.711 Y123.912
G1 X132.427 Y124.161
G1 X132.56 Y124.295
G1 X136.371 Y128.105 E.16052
G1 X136.504 Y128.239
G1 X136.189 Y128.457
G1 X136.055 Y128.323
G1 X132.395 Y124.663 E.1542
G1 X132.261 Y124.529
G1 X131.961 Y124.762
G1 X132.095 Y124.896
G1 X135.754 Y128.555 E.15415
; WIPE_START
M204 S10000
G1 X134.34 Y127.141 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.645 Y127.246 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X141.983 Y131.584 E.18273
G1 X142.116 Y131.718
G1 X142.081 Y132.216
G1 X141.948 Y132.083
G1 X137.645 Y127.78 E.18127
G1 X137.511 Y127.646
G1 X137.511 Y128.179
G1 X137.645 Y128.313
G1 X141.833 Y132.501 E.17641
G1 X141.966 Y132.634
G1 X141.765 Y132.966
G1 X141.631 Y132.833
G1 X137.645 Y128.846 E.16793
G1 X137.511 Y128.712
G1 X137.361 Y129.096
G1 X137.495 Y129.229
G1 X141.533 Y133.267 E.17009
G1 X141.666 Y133.401
G1 X141.448 Y133.716
G1 X141.315 Y133.583
G1 X137.345 Y129.613 E.16724
G1 X137.211 Y129.479
G1 X137.061 Y129.862
G1 X137.195 Y129.996
G1 X141.232 Y134.033 E.17005
G1 X141.365 Y134.166
G1 X141.132 Y134.466
G1 X140.998 Y134.333
G1 X136.96 Y130.295 E.17009
G1 X136.827 Y130.161
G1 X136.593 Y130.461
G1 X136.727 Y130.595
G1 X140.783 Y134.65 E.17084
G1 X140.916 Y134.784
G1 X140.766 Y135.167
G1 X140.633 Y135.033
G1 X136.344 Y130.745 E.18066
G1 X136.21 Y130.611
G1 X135.977 Y130.911
G1 X136.111 Y131.045
G1 X140.448 Y135.383 E.18273
G1 X140.582 Y135.516
G1 X140.316 Y135.784
G1 X140.183 Y135.65
G1 X135.727 Y131.195 E.18768
G1 X135.594 Y131.061
G1 X135.21 Y131.211
G1 X135.344 Y131.345
G1 X140.033 Y136.033 E.1975
G1 X140.166 Y136.167
G1 X139.882 Y136.416
G1 X139.749 Y136.283
G1 X134.811 Y131.345 E.20801
G1 X134.677 Y131.211
G1 X134.294 Y131.361
G1 X134.428 Y131.495
G1 X139.583 Y136.65 E.21715
G1 X139.716 Y136.783
G1 X139.416 Y137.017
G1 X139.283 Y136.883
G1 X133.744 Y131.345 E.2333
G1 X133.611 Y131.211
G1 X132.927 Y131.061
G1 X133.061 Y131.195
G1 X139.049 Y137.183 E.25224
G1 X139.183 Y137.316
G1 X138.966 Y137.633
G1 X138.833 Y137.5
G1 X132.078 Y130.745 E.28454
; WIPE_START
M204 S10000
G1 X133.492 Y132.159 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.717 Y124.566 Z1 F36000
G1 X132.037 Y117.905 Z1
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X127.549 Y113.417 E.18905
M73 P86 R1
G1 X127.415 Y113.284
G1 X126.882 Y113.284
G1 X127.015 Y113.417
G1 X131.353 Y117.755 E.18273
G1 X131.487 Y117.889
G1 X131.239 Y118.174
G1 X131.105 Y118.041
G1 X126.632 Y113.567 E.18843
G1 X126.498 Y113.434
G1 X125.965 Y113.434
G1 X126.099 Y113.567
G1 X131.105 Y118.574 E.21089
G1 X131.239 Y118.707
G1 X130.787 Y118.789
G1 X130.653 Y118.655
G1 X125.716 Y113.717 E.20801
G1 X125.582 Y113.584
G1 X125.049 Y113.584
G1 X125.182 Y113.717
G1 X130.655 Y119.19 E.23054
G1 X130.789 Y119.324
G1 X131.089 Y120.157
G1 X130.955 Y120.024
G1 X124.799 Y113.867 E.25933
G1 X124.665 Y113.734
G1 X124.282 Y113.884
G1 X124.416 Y114.017
G1 X131.105 Y120.707 E.28179
G1 X131.239 Y120.84
G1 X131.239 Y121.374
G1 X131.105 Y121.24
G1 X123.917 Y114.052 E.30279
G1 X123.784 Y113.919
G1 X123.366 Y114.034
G1 X123.499 Y114.167
G1 X131.255 Y121.923 E.32672
G1 X131.389 Y122.057
G1 X131.389 Y122.59
G1 X131.255 Y122.457
G1 X123.167 Y114.369 E.3407
G1 X123.034 Y114.235
G1 X122.599 Y114.334
G1 X122.733 Y114.467
G1 X131.255 Y122.99 E.35901
G1 X131.389 Y123.123
G1 X131.389 Y123.657
G1 X131.255 Y123.523
G1 X122.417 Y114.685 E.37229
G1 X122.284 Y114.552
G1 X121.834 Y114.635
G1 X121.967 Y114.768
G1 X131.255 Y124.056 E.39125
; WIPE_START
M204 S10000
G1 X129.841 Y122.642 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.984 Y128.281 Z1 F36000
G1 X135.371 Y128.705 Z1
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X121.667 Y115.002 E.57726
G1 X121.534 Y114.868
G1 X121.216 Y115.084
G1 X121.35 Y115.217
G1 X135.005 Y128.873 E.57523
G1 X135.139 Y129.007
G1 X134.839 Y129.24
G1 X134.705 Y129.106
G1 X120.967 Y115.367 E.57874
G1 X120.833 Y115.234
G1 X120.484 Y115.418
G1 X120.617 Y115.551
G1 X134.255 Y129.189 E.57449
G1 X134.389 Y129.323
G1 X133.972 Y129.439
G1 X133.838 Y129.305
G1 X120.35 Y115.817 E.56817
G1 X120.216 Y115.684
G1 X119.833 Y115.834
G1 X119.967 Y115.967
G1 X124.905 Y120.905 E.20801
; WIPE_START
M204 S10000
G1 X123.49 Y119.491 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.621 Y120.155 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X119.717 Y116.251 E.16445
G1 X119.584 Y116.118
G1 X119.217 Y116.284
G1 X119.35 Y116.417
G1 X123.088 Y120.155 E.15746
G1 X123.222 Y120.289
G1 X122.839 Y120.439
G1 X122.705 Y120.305
G1 X119.117 Y116.717 E.15114
G1 X118.983 Y116.584
G1 X118.684 Y116.817
G1 X118.817 Y116.951
G1 X122.322 Y120.455 E.14761
G1 X122.455 Y120.589
G1 X122.089 Y120.756
G1 X121.955 Y120.622
G1 X118.5 Y117.167 E.14553
G1 X118.367 Y117.034
G1 X118.084 Y117.284
G1 X118.217 Y117.418
G1 X121.705 Y120.905 E.14692
G1 X121.839 Y121.039
G1 X121.605 Y121.339
G1 X121.472 Y121.205
G1 X117.917 Y117.651 E.14973
G1 X117.784 Y117.517
G1 X117.517 Y117.784
G1 X117.651 Y117.917
G1 X121.089 Y121.355 E.14482
G1 X121.222 Y121.489
G1 X121.039 Y121.839
G1 X120.905 Y121.705
G1 X117.417 Y118.217 E.14692
G1 X117.284 Y118.084
G1 X117.034 Y118.367
G1 X117.167 Y118.501
G1 X120.622 Y121.955 E.14553
G1 X120.756 Y122.089
G1 X120.522 Y122.389
G1 X120.389 Y122.255
G1 X116.951 Y118.817 E.14482
; WIPE_START
M204 S10000
G1 X118.365 Y120.232 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.795 Y121.795 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X133.455 Y129.455 E.32267
G1 X133.588 Y129.589
G1 X133.205 Y129.739
G1 X133.071 Y129.605
G1 X126.695 Y123.229 E.26861
G1 X126.561 Y123.095
G1 X126.194 Y123.261
G1 X126.328 Y123.395
G1 X132.605 Y129.672 E.26445
G1 X132.739 Y129.806
G1 X132.589 Y130.189
G1 X132.455 Y130.055
G1 X125.795 Y123.395 E.28056
G1 X125.661 Y123.261
G1 X124.977 Y123.111
G1 X125.111 Y123.245
G1 X132.222 Y130.355 E.29953
G1 X132.355 Y130.489
G1 X132.139 Y130.806
G1 X132.005 Y130.672
G1 X124.278 Y122.945 E.32552
G1 X124.144 Y122.811
G1 X123.311 Y122.511
G1 X123.445 Y122.645
G1 X138.582 Y137.783 E.63768
G1 X138.716 Y137.916
G1 X138.483 Y138.216
G1 X138.349 Y138.083
G1 X122.911 Y122.645 E.65032
G1 X122.778 Y122.511
G1 X122.094 Y122.361
G1 X122.228 Y122.495
G1 X138.083 Y138.349 E.66787
G1 X138.216 Y138.483
G1 X137.916 Y138.716
G1 X137.783 Y138.583
G1 X121.695 Y122.495 E.67769
G1 X121.561 Y122.361
M73 P87 R1
G1 X121.028 Y122.361
G1 X121.162 Y122.495
G1 X137.499 Y138.833 E.68823
G1 X137.633 Y138.966
G1 X137.316 Y139.183
G1 X137.183 Y139.049
G1 X120.628 Y122.495 E.69735
; WIPE_START
M204 S10000
G1 X122.042 Y123.909 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X116.717 Y119.117 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X136.883 Y139.283 E.84946
G1 X137.017 Y139.416
G1 X136.783 Y139.716
G1 X136.65 Y139.583
G1 X116.417 Y119.35 E.85227
G1 X116.284 Y119.217
G1 X116.118 Y119.584
G1 X116.251 Y119.717
G1 X136.283 Y139.749 E.84382
G1 X136.416 Y139.882
G1 X136.167 Y140.166
G1 X136.033 Y140.033
G1 X123.395 Y127.394 E.53239
G1 X123.261 Y127.261
G1 X123.261 Y127.794
G1 X123.395 Y127.927
G1 X127.923 Y132.455 E.19073
G1 X128.056 Y132.589
G1 X127.523 Y132.589
G1 X127.389 Y132.455
G1 X123.395 Y128.461 E.16827
G1 X123.261 Y128.327
G1 X122.961 Y128.56
G1 X123.095 Y128.694
G1 X126.856 Y132.455 E.15844
G1 X126.99 Y132.589
G1 X126.456 Y132.589
G1 X126.323 Y132.455
G1 X122.812 Y128.945 E.14788
G1 X122.679 Y128.811
G1 X122.445 Y129.111
G1 X122.579 Y129.245
G1 X125.939 Y132.605 E.14156
G1 X126.073 Y132.739
G1 X126.139 Y133.338
G1 X126.005 Y133.204
G1 X122.345 Y129.544 E.1542
G1 X122.211 Y129.41
G1 X121.911 Y129.643
G1 X122.045 Y129.777
G1 X126.005 Y133.738 E.16684
G1 X126.139 Y133.871
G1 X126.439 Y134.704
G1 X126.305 Y134.571
G1 X121.879 Y130.145 E.18645
G1 X121.746 Y130.011
G1 X121.512 Y130.311
G1 X121.646 Y130.445
G1 X126.905 Y135.704 E.22155
; WIPE_START
M204 S10000
G1 X125.491 Y134.29 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128.195 Y132.727 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X131.823 Y136.355 E.15282
G1 X131.956 Y136.489
G1 X131.778 Y136.311
G1 X131.912 Y136.445
G1 X135.65 Y140.183 E.15746
G1 X135.784 Y140.316
G1 X135.516 Y140.582
G1 X135.383 Y140.449
G1 X131.529 Y136.595 E.16234
G1 X131.395 Y136.461
G1 X131.012 Y136.611
G1 X131.145 Y136.745
G1 X135.033 Y140.633 E.16378
G1 X135.167 Y140.766
G1 X134.784 Y140.916
G1 X134.65 Y140.783
G1 X130.762 Y136.895 E.16378
G1 X130.629 Y136.761
G1 X130.245 Y136.911
G1 X130.379 Y137.045
G1 X134.333 Y140.998 E.16655
G1 X134.466 Y141.132
G1 X134.166 Y141.365
G1 X134.033 Y141.232
G1 X129.995 Y137.194 E.17009
G1 X129.861 Y137.06
G1 X129.329 Y137.061
G1 X129.462 Y137.195
G1 X133.583 Y141.315 E.17356
G1 X133.716 Y141.449
G1 X133.401 Y141.666
G1 X133.267 Y141.533
G1 X129.079 Y137.345 E.17641
G1 X128.946 Y137.211
G1 X127.962 Y136.761
G1 X128.096 Y136.895
G1 X132.833 Y141.631 E.19953
G1 X132.966 Y141.765
G1 X132.634 Y141.966
G1 X132.501 Y141.833
G1 X121.445 Y130.777 E.46572
G1 X121.311 Y130.643
G1 X121.161 Y131.026
G1 X121.295 Y131.16
G1 X132.083 Y141.948 E.45444
G1 X132.216 Y142.082
G1 X131.718 Y142.116
G1 X131.584 Y141.983
G1 X121.145 Y131.543 E.43975
G1 X121.011 Y131.41
G1 X120.861 Y131.793
G1 X120.995 Y131.927
G1 X131.201 Y142.133 E.42993
G1 X131.334 Y142.266
G1 X130.951 Y142.416
G1 X130.818 Y142.283
G1 X120.845 Y132.31 E.4201
G1 X120.711 Y132.176
G1 X120.563 Y132.561
G1 X120.696 Y132.695
G1 X130.284 Y142.283 E.40389
; WIPE_START
M204 S10000
G1 X128.87 Y140.868 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.947 Y133.818 Z1 F36000
G1 X123.206 Y127.205 Z1
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X115.967 Y119.967 E.30491
G1 X115.834 Y119.833
G1 X115.684 Y120.216
G1 X115.817 Y120.35
G1 X122.823 Y127.355 E.29509
G1 X122.956 Y127.489
G1 X122.539 Y127.605
G1 X122.405 Y127.471
G1 X115.551 Y120.617 E.28872
G1 X115.418 Y120.484
G1 X115.234 Y120.833
G1 X115.367 Y120.967
G1 X121.955 Y127.555 E.27751
G1 X122.089 Y127.688
G1 X121.789 Y127.921
G1 X121.655 Y127.788
G1 X115.217 Y121.35 E.27119
G1 X115.084 Y121.216
G1 X114.868 Y121.534
G1 X115.002 Y121.667
G1 X121.289 Y127.955 E.26487
G1 X121.423 Y128.089
G1 X121.04 Y128.239
G1 X120.906 Y128.105
G1 X114.768 Y121.967 E.25856
G1 X114.635 Y121.834
G1 X114.551 Y122.284
G1 X114.685 Y122.417
G1 X120.523 Y128.255 E.24592
G1 X120.657 Y128.389
G1 X120.423 Y128.689
G1 X120.29 Y128.555
M73 P88 R1
G1 X114.467 Y122.733 E.24526
G1 X114.334 Y122.599
G1 X114.235 Y123.034
G1 X114.369 Y123.167
G1 X119.906 Y128.705 E.23328
G1 X120.04 Y128.839
G1 X119.807 Y129.139
G1 X119.673 Y129.005
G1 X114.167 Y123.499 E.23193
G1 X114.034 Y123.366
G1 X113.918 Y123.784
G1 X114.052 Y123.917
G1 X119.44 Y129.305 E.22696
G1 X119.574 Y129.439
G1 X119.34 Y129.739
G1 X119.207 Y129.605
G1 X114.017 Y124.416 E.2186
G1 X113.884 Y124.282
G1 X113.734 Y124.666
G1 X113.867 Y124.799
G1 X118.973 Y129.905 E.21509
G1 X119.107 Y130.039
G1 X119.089 Y130.554
G1 X118.955 Y130.42
G1 X113.717 Y125.182 E.22064
G1 X113.584 Y125.049
G1 X113.584 Y125.582
G1 X113.717 Y125.716
G1 X119.705 Y131.704 E.25224
; WIPE_START
M204 S10000
G1 X118.291 Y130.289 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X113.567 Y126.099 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X129.901 Y142.433 E.68805
G1 X130.035 Y142.566
G1 X129.501 Y142.566
G1 X129.368 Y142.433
G1 X113.567 Y126.632 E.66558
G1 X113.434 Y126.499
G1 X113.284 Y126.882
G1 X113.417 Y127.016
G1 X128.984 Y142.583 E.65576
G1 X129.118 Y142.716
G1 X128.585 Y142.716
G1 X128.451 Y142.583
G1 X113.417 Y127.549 E.63329
G1 X113.284 Y127.415
G1 X113.284 Y127.948
G1 X113.417 Y128.082
G1 X127.918 Y142.583 E.61083
G1 X128.052 Y142.716
G1 X127.518 Y142.716
G1 X127.385 Y142.583
G1 X113.417 Y128.615 E.58837
G1 X113.284 Y128.482
G1 X113.434 Y129.165
G1 X113.567 Y129.299
G1 X126.701 Y142.433 E.55327
G1 X126.835 Y142.566
G1 X126.302 Y142.566
G1 X126.168 Y142.433
G1 X113.567 Y129.832 E.5308
G1 X113.434 Y129.698
G1 X113.584 Y130.381
G1 X113.717 Y130.515
G1 X125.485 Y142.283 E.4957
G1 X125.619 Y142.416
G1 X124.935 Y142.266
G1 X124.802 Y142.133
G1 X113.867 Y131.198 E.4606
G1 X113.734 Y131.065
G1 X113.884 Y131.748
G1 X114.017 Y131.882
G1 X124.118 Y141.983 E.4255
G1 X124.252 Y142.116
G1 X123.269 Y141.666
G1 X123.135 Y141.533
G1 X114.467 Y132.865 E.36513
G1 X114.334 Y132.731
G1 X114.634 Y133.564
G1 X114.767 Y133.698
G1 X122.302 Y141.233 E.31739
; WIPE_START
M204 S10000
G1 X120.888 Y139.818 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.169 Y140.633 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X115.367 Y134.831 E.24438
; WIPE_START
M204 S10000
G1 X116.782 Y136.246 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.967 Y135.965 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F9547.055
M204 S2000
G1 X120.035 Y140.033 E.17136
; WIPE_START
M204 S10000
G1 X118.621 Y138.618 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.849 Y131.318 Z1 F36000
G1 X124.159 Y120.474 Z1
G1 Z.6
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.109899
G1 F15000
G1 X123.731 Y120.046 E.00321
; WIPE_START
G1 X124.159 Y120.474 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.244 Y121.074 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.178865
G1 F15000
G1 X124.99 Y120.82 E.00386
; WIPE_START
G1 X125.244 Y121.074 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.88 Y121.71 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X124.99 Y120.82 E.01352
; WIPE_START
G1 X125.88 Y121.71 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.88 Y121.71 Z.6 F36000
G1 E.8 F1800
G1 F15000
G1 X124.99 Y120.82 E.01352
; WIPE_START
G1 X125.88 Y121.71 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.88 Y121.71 Z.6 F36000
G1 E.8 F1800
G1 F15000
G1 X125.626 Y121.456 E.00386
; WIPE_START
G1 X125.88 Y121.71 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.77 Y124.799 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.0974408
G1 F15000
G1 X131.141 Y124.17 E.00383
G1 X131.77 Y124.799 F36000
; LINE_WIDTH: 0.0974424
G1 F15000
G1 X131.141 Y124.17 E.00383
G1 X131.77 Y124.799 F36000
; LINE_WIDTH: 0.0974441
G1 F15000
G1 X131.141 Y124.17 E.00383
; WIPE_START
G1 X131.77 Y124.799 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.206 Y117.303 Z1 F36000
G1 X133.69 Y114.775 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.158193
G1 F15000
G1 X133.565 Y114.805 E.00118
; LINE_WIDTH: 0.188648
G1 X133.413 Y114.599 E.00295
; WIPE_START
G1 X133.565 Y114.805 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.729 Y115.47 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.130385
G1 F15000
G1 X134.158 Y114.899 E.00558
G1 X134.826 Y115.372 F36000
; LINE_WIDTH: 0.104059
G1 F15000
G1 X134.794 Y115.368 E.00016
; LINE_WIDTH: 0.145812
G1 X134.762 Y115.363 E.00026
; LINE_WIDTH: 0.187565
G1 X134.73 Y115.359 E.00037
; LINE_WIDTH: 0.23293
G1 X134.696 Y115.349 E.00054
; LINE_WIDTH: 0.262479
G2 X134.546 Y115.199 I-.497 J.347 E.0037
G1 X134.483 Y115.049 E.00282
; WIPE_START
G1 X134.546 Y115.199 E-.32686
G1 X134.683 Y115.317 E-.36514
G1 X134.696 Y115.349 E-.06801
; WIPE_END
G1 E-.04 F1800
G1 X135.965 Y115.967 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.174798
G1 F15000
G1 X135.831 Y116.01 E.00146
G1 X135.529 Y115.649 E.00491
; WIPE_START
G1 X135.831 Y116.01 E-.58541
G1 X135.965 Y115.967 E-.17459
; WIPE_END
G1 E-.04 F1800
G1 X137.501 Y117.185 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.1167
G1 F15000
G1 X137.315 Y116.999 E.00154
G1 X137.651 Y117.335 F36000
G1 F15000
G1 X137.315 Y116.999 E.00278
G1 X137.801 Y117.485 F36000
G1 F15000
G1 X137.315 Y116.999 E.00401
; WIPE_START
G1 X137.801 Y117.485 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X139.001 Y118.685 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F15000
M73 P89 R1
G1 X138.515 Y118.199 E.00401
G1 X139.001 Y118.685 F36000
G1 F15000
G1 X138.665 Y118.349 E.00278
G1 X139.001 Y118.685 F36000
G1 F15000
G1 X138.815 Y118.499 E.00154
; WIPE_START
G1 X139.001 Y118.685 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X140.201 Y120.346 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.172986
G1 F15000
G1 X139.99 Y120.169 E.00283
G1 X140.033 Y120.035 E.00144
; WIPE_START
G1 X139.99 Y120.169 E-.25674
G1 X140.201 Y120.346 E-.50326
; WIPE_END
G1 E-.04 F1800
G1 X140.951 Y121.517 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.262321
G1 F15000
G3 X140.683 Y121.317 I.107 J-.426 E.00595
G1 X140.646 Y121.302 E.00069
; LINE_WIDTH: 0.229324
G1 X140.641 Y121.27 E.00048
; LINE_WIDTH: 0.187569
G1 X140.637 Y121.238 E.00037
; LINE_WIDTH: 0.145813
G1 X140.632 Y121.206 E.00026
; LINE_WIDTH: 0.104058
G1 X140.628 Y121.174 E.00016
G1 X141.101 Y121.842 F36000
; LINE_WIDTH: 0.130385
G1 F15000
G1 X140.53 Y121.271 E.00558
; WIPE_START
G1 X141.101 Y121.842 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X135.463 Y126.986 Z1 F36000
G1 X126.624 Y135.048 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.101058
G1 F15000
G1 X126.458 Y134.95 E.00089
G1 X126.466 Y134.911 E.00018
; WIPE_START
G1 X126.458 Y134.95 E-.12984
G1 X126.624 Y135.048 E-.63016
; WIPE_END
G1 E-.04 F1800
G1 X127.374 Y136.3 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.172411
G1 F15000
G1 X126.862 Y135.837 E.00706
G1 X126.912 Y135.697 E.00153
G1 X127.374 Y136.344 F36000
; LINE_WIDTH: 0.178406
G1 F15000
G1 X126.82 Y135.789 E.00839
G1 X127.374 Y136.344 F36000
; LINE_WIDTH: 0.178405
G1 F15000
G1 X126.82 Y135.789 E.00839
; WIPE_START
G1 X127.374 Y136.344 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.281 Y135.624 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.357273
G1 F11452.101
G1 X130.436 Y135.463 E.00555
G1 X130.286 Y135.314 E.00526
G1 X130.126 Y135.474 E.00564
; WIPE_START
G1 X130.286 Y135.314 E-.26049
G1 X130.436 Y135.463 E-.24303
G1 X130.281 Y135.624 E-.25648
; WIPE_END
G1 E-.04 F1800
G1 X124.178 Y140.207 Z1 F36000
G1 X122.587 Y141.401 Z1
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.188562
G1 F15000
G1 X122.435 Y141.195 E.00295
; LINE_WIDTH: 0.158221
G1 X122.309 Y141.225 E.00118
G1 X121.516 Y140.951 F36000
; LINE_WIDTH: 0.262214
G1 F15000
G2 X121.317 Y140.683 I-.425 J.107 E.00595
G1 X121.302 Y140.646 E.00069
; LINE_WIDTH: 0.229119
G1 X121.27 Y140.641 E.00048
; LINE_WIDTH: 0.187452
G1 X121.238 Y140.637 E.00037
; LINE_WIDTH: 0.145784
G1 X121.206 Y140.632 E.00026
; LINE_WIDTH: 0.104116
G1 X121.173 Y140.628 E.00016
G1 X121.842 Y141.101 F36000
; LINE_WIDTH: 0.130276
G1 F15000
G1 X121.271 Y140.53 E.00557
G1 X120.471 Y140.351 F36000
; LINE_WIDTH: 0.174755
G1 F15000
G1 X120.169 Y139.99 E.00491
G1 X120.035 Y140.033 E.00146
; WIPE_START
G1 X120.169 Y139.99 E-.17459
G1 X120.471 Y140.351 E-.58541
; WIPE_END
G1 E-.04 F1800
G1 X117.185 Y137.501 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.116601
G1 F15000
G1 X116.999 Y137.315 E.00154
G1 X117.335 Y137.651 F36000
G1 F15000
G1 X116.999 Y137.315 E.00277
G1 X117.485 Y137.801 F36000
G1 F15000
G1 X116.999 Y137.315 E.00401
; WIPE_START
G1 X117.485 Y137.801 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X118.685 Y139.001 Z1 F36000
G1 Z.6
G1 E.8 F1800
G1 F15000
G1 X118.199 Y138.515 E.00401
G1 X118.685 Y139.001 F36000
G1 F15000
G1 X118.349 Y138.665 E.00277
G1 X118.685 Y139.001 F36000
G1 F15000
G1 X118.499 Y138.815 E.00154
; WIPE_START
G1 X118.685 Y139.001 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X115.967 Y135.965 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.172953
G1 F15000
G1 X116.01 Y135.831 E.00144
G1 X115.799 Y135.654 E.00283
G1 X115.47 Y134.729 F36000
; LINE_WIDTH: 0.130276
G1 F15000
G1 X114.899 Y134.158 E.00557
G1 X115.372 Y134.826 F36000
; LINE_WIDTH: 0.104114
G1 F15000
G1 X115.368 Y134.794 E.00016
; LINE_WIDTH: 0.14578
G1 X115.363 Y134.762 E.00026
; LINE_WIDTH: 0.187447
G1 X115.359 Y134.73 E.00037
; LINE_WIDTH: 0.232826
G1 X115.349 Y134.696 E.00054
; LINE_WIDTH: 0.262381
G3 X115.199 Y134.546 I.346 J-.496 E.0037
G1 X115.049 Y134.484 E.00281
; WIPE_START
G1 X115.199 Y134.546 E-.32684
G1 X115.317 Y134.683 E-.36507
G1 X115.349 Y134.696 E-.06809
; WIPE_END
G1 E-.04 F1800
G1 X120.024 Y132.046 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.20697
G1 F15000
G1 X119.679 Y131.837 E.00523
; LINE_WIDTH: 0.175446
G1 X119.686 Y131.776 E.00064
; LINE_WIDTH: 0.137402
G1 X119.694 Y131.715 E.00046
G1 X120.024 Y132.164 F36000
; LINE_WIDTH: 0.219463
G1 F15000
G1 X119.634 Y131.774 E.00769
; WIPE_START
G1 X120.024 Y132.164 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.324 Y132.552 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.095198
G1 F15000
G1 X119.591 Y131.818 E.00428
; WIPE_START
M73 C0
G1 X120.324 Y132.552 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X119.057 Y130.418 Z1 F36000
G1 Z.6
G1 E.8 F1800
; LINE_WIDTH: 0.19282
G1 F15000
G1 X119.057 Y129.932 E.00576
; CHANGE_LAYER
; Z_HEIGHT: 0.8
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F15000
G1 X119.057 Y130.418 E-.76
; WIPE_END
G1 E-.04 F1800
;======== P2S layer_change gcode ==========
;===== 2026/05/15 ====





    ;updata chamber autocooling in Xth layer
    
            ;not reset filter fan in Xth layer
    

    M622.1 S0
    M1002 judge_flag ventobox_replace_aux1_fan_flag
    M622 J0
    M106 P10 S0; set left aux fan
    M623
;not reset fan


; update layer progress
M73 L4
M991 S0 P3 ;notify layer change


M106 S226.95
; PAUSE_PRINTING
M400 U1

G17
G3 Z1 I1.217 J0 P1  F36000
;======== P2S timelapes gcode ==========
;===== 2025/06/16 ====
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
  M971 S11 C10 O0
  M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 175
G1 X131.602 Y130.76
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3156
G1 X131.602 Y130.998 E.00765
G1 X132.052 Y130.998 E.01447
G1 X132.052 Y131.148 E.00482
G1 X132.352 Y131.148 E.00965
G1 X132.352 Y131.298 E.00482
G1 X132.802 Y131.298 E.01447
G1 X132.802 Y131.448 E.00482
G1 X133.402 Y131.448 E.01929
G1 X133.402 Y131.598 E.00482
G1 X134.152 Y131.598 E.02412
G1 X134.152 Y131.748 E.00482
G1 X134.898 Y131.748 E.02398
G1 X134.898 Y131.598 E.00482
G1 X135.648 Y131.598 E.02412
G1 X135.648 Y131.448 E.00482
G1 X136.098 Y131.448 E.01447
G1 X136.098 Y131.298 E.00482
G1 X136.398 Y131.298 E.00965
G1 X136.398 Y131.148 E.00482
G1 X136.548 Y131.148 E.00482
G1 X136.548 Y130.998 E.00482
G1 X136.848 Y130.998 E.00965
G1 X136.848 Y130.848 E.00482
G1 X136.998 Y130.848 E.00482
G1 X136.998 Y130.698 E.00482
G1 X137.148 Y130.698 E.00482
G1 X137.148 Y130.548 E.00482
G1 X137.298 Y130.548 E.00482
G1 X137.298 Y130.398 E.00482
G1 X137.448 Y130.398 E.00482
G1 X137.448 Y130.098 E.00965
G1 X137.598 Y130.098 E.00482
G1 X137.598 Y129.798 E.00965
G1 X137.748 Y129.798 E.00482
G1 X137.748 Y129.198 E.01929
G1 X137.898 Y129.198 E.00482
G1 X137.898 Y126.802 E.07704
G1 X137.748 Y126.802 E.00482
G1 X137.748 Y126.502 E.00965
G1 X137.452 Y126.502 E.00951
G1 X137.452 Y126.802 E.00965
G1 X137.302 Y126.802 E.00482
G1 X137.302 Y126.952 E.00482
G1 X137.152 Y126.952 E.00482
G1 X137.152 Y127.102 E.00482
G1 X137.002 Y127.102 E.00482
G1 X137.002 Y127.252 E.00482
G1 X136.852 Y127.252 E.00482
G1 X136.852 Y127.402 E.00482
G1 X136.702 Y127.402 E.00482
G1 X136.702 Y127.552 E.00482
G1 X136.402 Y127.552 E.00965
G1 X136.402 Y127.702 E.00482
G1 X136.252 Y127.702 E.00482
G1 X136.252 Y127.852 E.00482
G1 X136.102 Y127.852 E.00482
G1 X136.102 Y128.002 E.00482
G1 X135.802 Y128.002 E.00965
G1 X135.802 Y128.152 E.00482
G1 X135.652 Y128.152 E.00482
G1 X135.652 Y128.302 E.00482
G1 X135.352 Y128.302 E.00965
G1 X135.352 Y128.452 E.00482
G1 X135.052 Y128.452 E.00965
G1 X135.052 Y128.602 E.00482
G1 X134.752 Y128.602 E.00965
G1 X134.752 Y128.752 E.00482
G1 X134.452 Y128.752 E.00965
G1 X134.452 Y128.902 E.00482
G1 X134.002 Y128.902 E.01447
G1 X134.002 Y129.052 E.00482
G1 X133.552 Y129.052 E.01447
G1 X133.552 Y129.202 E.00482
G1 X133.102 Y129.202 E.01447
G1 X133.102 Y129.352 E.00482
G1 X132.352 Y129.352 E.02412
G1 X132.352 Y129.502 E.00482
G1 X132.202 Y129.502 E.00482
G1 X132.202 Y129.802 E.00965
G1 X132.052 Y129.802 E.00482
G1 X132.052 Y130.102 E.00965
G1 X131.902 Y130.102 E.00482
G1 X131.902 Y130.402 E.00965
G1 X131.752 Y130.402 E.00482
G1 X131.752 Y130.552 E.00482
G1 X131.602 Y130.552 E.00482
G1 X131.602 Y130.7 E.00476
M204 S250
G1 X130.61 Y130.76 F36000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X130.61 Y131.09 E.00983
G1 X130.91 Y131.09 E.00894
G1 X130.91 Y131.24 E.00447
G1 X131.21 Y131.24 E.00894
G1 X131.21 Y131.39 E.00447
G1 X131.66 Y131.39 E.0134
G1 X131.66 Y131.54 E.00447
G1 X131.96 Y131.54 E.00894
G1 X131.96 Y131.69 E.00447
G1 X132.41 Y131.69 E.0134
G1 X132.41 Y131.84 E.00447
G1 X133.01 Y131.84 E.01787
G1 X133.01 Y131.99 E.00447
G1 X133.76 Y131.99 E.02234
G1 X133.76 Y132.14 E.00447
G1 X135.29 Y132.14 E.04557
G1 X135.29 Y131.99 E.00447
G1 X136.04 Y131.99 E.02234
G1 X136.04 Y131.84 E.00447
G1 X136.49 Y131.84 E.0134
G1 X136.49 Y131.69 E.00447
G1 X136.79 Y131.69 E.00894
G1 X136.79 Y131.54 E.00447
G1 X136.94 Y131.54 E.00447
G1 X136.94 Y131.39 E.00447
G1 X137.24 Y131.39 E.00894
G1 X137.24 Y131.24 E.00447
G1 X137.39 Y131.24 E.00447
G1 X137.39 Y131.09 E.00447
G1 X137.54 Y131.09 E.00447
G1 X137.54 Y130.94 E.00447
G1 X137.69 Y130.94 E.00447
G1 X137.69 Y130.79 E.00447
G1 X137.84 Y130.79 E.00447
G1 X137.84 Y130.49 E.00894
G1 X137.99 Y130.49 E.00447
G1 X137.99 Y130.19 E.00894
G1 X138.14 Y130.19 E.00447
G1 X138.14 Y129.59 E.01787
G1 X138.29 Y129.59 E.00447
G1 X138.29 Y128.54 E.03128
G1 X138.44 Y128.54 E.00447
G1 X138.44 Y127.61 E.0277
G1 X138.29 Y127.61 E.00447
G1 X138.29 Y126.41 E.03574
G1 X138.14 Y126.41 E.00447
G1 X138.14 Y125.66 E.02234
G1 X137.99 Y125.66 E.00447
G1 X137.99 Y125.06 E.01787
G1 X137.81 Y125.06 E.00536
G1 X137.81 Y125.36 E.00894
G1 X137.66 Y125.36 E.00447
G1 X137.66 Y125.66 E.00894
G1 X137.51 Y125.66 E.00447
G1 X137.51 Y125.81 E.00447
G1 X137.36 Y125.81 E.00447
G1 X137.36 Y125.96 E.00447
G1 X137.21 Y125.96 E.00447
G1 X137.21 Y126.11 E.00447
G1 X137.06 Y126.11 E.00447
G1 X137.06 Y126.41 E.00894
G1 X136.91 Y126.41 E.00447
G1 X136.91 Y126.56 E.00447
G1 X136.76 Y126.56 E.00447
G1 X136.76 Y126.71 E.00447
G1 X136.61 Y126.71 E.00447
G1 X136.61 Y126.86 E.00447
G1 X136.46 Y126.86 E.00447
G1 X136.46 Y127.01 E.00447
G1 X136.31 Y127.01 E.00447
G1 X136.31 Y127.16 E.00447
G1 X136.01 Y127.16 E.00894
G1 X136.01 Y127.31 E.00447
G1 X135.86 Y127.31 E.00447
G1 X135.86 Y127.46 E.00447
G1 X135.71 Y127.46 E.00447
G1 X135.71 Y127.61 E.00447
G1 X135.41 Y127.61 E.00894
G1 X135.41 Y127.76 E.00447
G1 X135.26 Y127.76 E.00447
G1 X135.26 Y127.91 E.00447
G1 X134.96 Y127.91 E.00894
G1 X134.96 Y128.06 E.00447
G1 X134.66 Y128.06 E.00894
G1 X134.66 Y128.21 E.00447
G1 X134.36 Y128.21 E.00894
G1 X134.36 Y128.36 E.00447
G1 X134.06 Y128.36 E.00894
G1 X134.06 Y128.51 E.00447
G1 X133.61 Y128.51 E.0134
G1 X133.61 Y128.66 E.00447
G1 X133.16 Y128.66 E.0134
G1 X133.16 Y128.81 E.00447
G1 X132.71 Y128.81 E.0134
G1 X132.71 Y128.96 E.00447
G1 X131.96 Y128.96 E.02234
G1 X131.96 Y129.11 E.00447
G1 X131.81 Y129.11 E.00447
G1 X131.81 Y129.41 E.00894
G1 X131.66 Y129.41 E.00447
G1 X131.66 Y129.71 E.00894
G1 X131.51 Y129.71 E.00447
G1 X131.51 Y130.01 E.00894
G1 X131.36 Y130.01 E.00447
G1 X131.36 Y130.16 E.00447
G1 X131.21 Y130.16 E.00447
G1 X131.21 Y130.31 E.00447
G1 X131.06 Y130.31 E.00447
G1 X131.06 Y130.61 E.00894
G1 X130.91 Y130.61 E.00447
G1 X130.91 Y130.76 E.00447
G1 X130.67 Y130.76 E.00715
M204 S10000
G1 X131.106 Y130.925 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.276054
G1 F3156
G2 X131.285 Y130.923 I.075 J-1.468 E.0033
G1 X131.308 Y130.865 E.00116
; LINE_WIDTH: 0.215726
G1 X131.331 Y130.806 E.00086
; LINE_WIDTH: 0.19282
G1 X131.331 Y130.506 E.00355
G1 X131.956 Y130.7 F36000
; LINE_WIDTH: 0.232982
G1 F3156
G2 X132.155 Y130.694 I.075 J-.768 E.003
G1 X132.168 Y130.65 E.00069
; LINE_WIDTH: 0.205738
G1 X132.181 Y130.606 E.00059
; LINE_WIDTH: 0.19282
G1 X132.181 Y130.306 E.00355
; WIPE_START
G1 F15000
G1 X132.181 Y130.606 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.356 Y131.469 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
G1 F3156
G1 X134.694 Y131.469 E.00401
; WIPE_START
G1 F15000
G1 X134.356 Y131.469 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X138.169 Y128.344 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
G1 F3156
G1 X138.169 Y127.806 E.00637
G1 X137.524 Y127.335 F36000
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.3836
G1 F3156
G1 X137.581 Y127.157 E.00504
; WIPE_START
G1 F10567.101
G1 X137.524 Y127.335 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.835 Y130.13 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.595004
G1 F3156
G1 X134.961 Y130.169 E.00575
; LINE_WIDTH: 0.556812
G1 X135.087 Y130.208 E.00535
; LINE_WIDTH: 0.518619
G1 X135.213 Y130.248 E.00495
; LINE_WIDTH: 0.465761
G1 X135.338 Y130.287 E.0044
G1 X135.64 Y130.139 E.01123
; LINE_WIDTH: 0.443645
G1 X136.021 Y129.904 E.01416
; LINE_WIDTH: 0.410319
G1 X136.359 Y129.629 E.01265
G1 X136.577 Y129.117 E.01615
G1 X136.408 Y129.258 E.00639
G1 X135.888 Y129.542 E.01721
; LINE_WIDTH: 0.443645
G1 X135.393 Y129.812 E.01782
; LINE_WIDTH: 0.48058
G1 X135.227 Y129.91 E.00668
; LINE_WIDTH: 0.52436
G1 X135.06 Y130.008 E.00734
; LINE_WIDTH: 0.56814
M73 P89 R0
G1 X134.894 Y130.105 E.00801
; LINE_WIDTH: 0.602065
G1 X134.891 Y130.107 E.00015
; WIPE_START
G1 F6438.402
G1 X134.894 Y130.105 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.761 Y130.346 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.381525
G1 F3156
G1 X134.017 Y130.279 E.0071
; LINE_WIDTH: 0.427775
G1 X134.274 Y130.211 E.00807
; LINE_WIDTH: 0.4713
G1 X134.4 Y130.193 E.00429
; LINE_WIDTH: 0.5121
G1 X134.525 Y130.175 E.0047
; LINE_WIDTH: 0.5529
G1 X134.65 Y130.157 E.00511
; LINE_WIDTH: 0.5937
G1 X134.776 Y130.138 E.00551
; WIPE_START
G1 F6536.185
G1 X134.65 Y130.157 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.046 Y130.121 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.415994
G1 F3156
G1 X133.092 Y130.54 E.01241
G1 X133.326 Y130.628 E.00737
G1 X133.352 Y130.679 E.00169
M73 P90 R0
G1 X133.702 Y130.687 E.0103
G1 X133.812 Y130.718 E.00337
G1 X133.98 Y130.63 E.0056
G1 X134.749 Y130.604 E.02266
G1 X135.109 Y130.645 E.01069
G1 X135.235 Y130.739 E.00464
G3 X135.537 Y130.679 I.234 J.383 E.00924
G3 X135.877 Y130.477 I.774 J.917 E.01171
G1 X136.031 Y130.324 E.00639
G1 X136.348 Y130.147 E.0107
G1 X136.688 Y129.79 E.01454
G2 X136.92 Y129.287 I-6.157 J-3.133 E.01633
G1 X136.979 Y129.255 E.00198
G1 X136.997 Y128.869 E.01138
G1 X137.11 Y128.659 E.00701
G1 X137.146 Y128.642 E.00117
G1 X137.146 Y128.2 E.01301
G2 X136.545 Y128.718 I4.001 J5.253 E.02339
G1 X136.323 Y128.823 E.00723
G1 X136.19 Y128.962 E.00565
G3 X134.787 Y129.656 I-26.082 J-50.967 E.04615
G2 X134.246 Y129.82 I.293 J1.938 E.0167
G1 X134.113 Y129.821 E.00391
G1 X133.998 Y129.917 E.00442
G2 X133.427 Y130.108 I.53 J2.529 E.01777
G1 X133.106 Y130.119 E.00946
G1 X132.594 Y129.928 F36000
; LINE_WIDTH: 0.419068
G1 F3156
G1 X132.669 Y130.102 E.00563
G1 X132.669 Y130.391 E.0086
G1 X132.72 Y130.492 E.00337
G1 X132.647 Y130.802 E.00946
G3 X132.731 Y130.906 I-.01 J.094 E.00442
G1 X133.08 Y130.921 E.01036
G1 X133.174 Y131.056 E.00488
G1 X133.675 Y131.069 E.01489
G1 X133.784 Y131.206 E.0052
G1 X133.964 Y131.206 E.00534
G1 X133.969 Y131.124 E.00245
G1 X134.095 Y130.99 E.00545
G1 X134.749 Y130.981 E.01943
G1 X134.999 Y131.01 E.00748
G1 X135.086 Y131.169 E.0054
G1 X135.086 Y131.206 E.00108
G1 X135.266 Y131.206 E.00534
G1 X135.281 Y131.151 E.00169
G1 X135.444 Y131.056 E.00563
G1 X135.725 Y131.056 E.00834
G1 X135.829 Y130.918 E.00514
G1 X136.019 Y130.906 E.00565
G1 X136.093 Y130.785 E.00421
G1 X136.165 Y130.765 E.00221
G1 X136.24 Y130.638 E.00439
G1 X136.469 Y130.606 E.00687
G1 X136.543 Y130.485 E.00421
G1 X136.615 Y130.465 E.00221
G1 X136.686 Y130.34 E.00426
G1 X136.765 Y130.315 E.00247
G1 X136.843 Y130.185 E.0045
G1 X136.915 Y130.165 E.00221
G1 X136.981 Y130.044 E.00411
G1 X137.056 Y130.019 E.00234
G1 X137.092 Y129.783 E.00709
G1 X137.206 Y129.719 E.00387
G1 X137.236 Y129.492 E.0068
G1 X137.356 Y129.427 E.00405
G1 X137.377 Y128.907 E.01545
G1 X137.506 Y128.825 E.00454
G3 X137.524 Y127.335 I17.617 J-.534 E.04428
G1 X137.29 Y127.624 E.01104
G1 X137.237 Y127.637 E.00163
G1 X137.151 Y127.768 E.00465
G2 X137.068 Y127.851 I-.017 J.066 E.00422
G1 X136.906 Y127.944 E.00556
G1 X136.781 Y127.944 E.00369
G1 X136.699 Y128.069 E.00444
G1 X136.636 Y128.086 E.00195
G1 X136.552 Y128.218 E.00464
G1 X136.486 Y128.236 E.00204
G1 X136.422 Y128.354 E.004
G3 X136.181 Y128.394 I-.178 J-.329 E.00737
G1 X136.107 Y128.515 E.00421
G1 X136.035 Y128.535 E.00221
G1 X135.967 Y128.658 E.00416
G1 X135.731 Y128.694 E.00709
G1 X135.645 Y128.821 E.00457
G1 X135.431 Y128.844 E.00639
G1 X135.364 Y128.96 E.00398
G1 X135.131 Y128.994 E.00698
G1 X135.056 Y129.115 E.00425
G1 X134.831 Y129.144 E.00672
G1 X134.762 Y129.261 E.00405
G1 X134.656 Y129.294 E.0033
G1 X134.375 Y129.294 E.00834
G1 X134.305 Y129.416 E.00418
G1 X133.925 Y129.444 E.01132
G1 X133.836 Y129.576 E.00472
G1 X133.475 Y129.594 E.01075
G1 X133.371 Y129.733 E.00515
G1 X132.73 Y129.744 E.01903
G3 X132.637 Y129.886 I-.19 J-.022 E.00523
; WIPE_START
G1 F9570.714
G1 X132.701 Y129.826 E-.03316
G1 X132.73 Y129.744 E-.03313
G1 X133.371 Y129.733 E-.24336
G1 X133.475 Y129.594 E-.06588
G1 X133.836 Y129.576 E-.13751
G1 X133.925 Y129.444 E-.06037
G1 X134.305 Y129.416 E-.14471
G1 X134.36 Y129.321 E-.04186
; WIPE_END
G1 E-.04 F1800
G1 X137.406 Y126.231 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.199599
G1 F3156
G1 X137.556 Y126.231 E.00186
G1 X137.606 Y126.206 E.00069
; LINE_WIDTH: 0.26777
G1 X137.656 Y126.181 E.00099
; LINE_WIDTH: 0.317737
G1 X137.706 Y126.156 E.00121
; LINE_WIDTH: 0.347907
G1 X137.784 Y126.146 E.00189
G1 X137.804 Y126.076 E.00176
; LINE_WIDTH: 0.301407
G1 X137.825 Y126.006 E.00149
; LINE_WIDTH: 0.28086
G1 X137.825 Y125.856 E.00282
; WIPE_START
G1 F15000
G1 X137.825 Y126.006 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.54 Y119.69 Z1.2 F36000
G1 X131.81 Y117.14 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X132.26 Y117.14 E.0134
G1 X132.26 Y117.29 E.00447
G1 X132.56 Y117.29 E.00894
G1 X132.56 Y117.44 E.00447
G1 X133.01 Y117.44 E.0134
G1 X133.01 Y117.59 E.00447
G1 X133.31 Y117.59 E.00894
G1 X133.31 Y117.74 E.00447
G1 X133.61 Y117.74 E.00894
G1 X133.61 Y117.89 E.00447
G1 X133.91 Y117.89 E.00894
G1 X133.91 Y118.04 E.00447
G1 X134.21 Y118.04 E.00894
G1 X134.21 Y118.19 E.00447
G1 X134.36 Y118.19 E.00447
G1 X134.36 Y118.34 E.00447
G1 X134.66 Y118.34 E.00894
G1 X134.66 Y118.49 E.00447
G1 X134.96 Y118.49 E.00894
G1 X134.96 Y118.64 E.00447
G1 X135.11 Y118.64 E.00447
G1 X135.11 Y118.79 E.00447
G1 X135.26 Y118.79 E.00447
G1 X135.26 Y118.94 E.00447
G1 X135.56 Y118.94 E.00894
G1 X135.56 Y119.09 E.00447
G1 X135.71 Y119.09 E.00447
G1 X135.71 Y119.24 E.00447
G1 X135.86 Y119.24 E.00447
G1 X135.86 Y119.39 E.00447
G1 X136.16 Y119.39 E.00894
G1 X136.16 Y119.54 E.00447
G1 X136.31 Y119.54 E.00447
G1 X136.31 Y119.69 E.00447
G1 X136.46 Y119.69 E.00447
G1 X136.46 Y119.84 E.00447
G1 X136.61 Y119.84 E.00447
G1 X136.61 Y119.99 E.00447
G1 X136.76 Y119.99 E.00447
G1 X136.76 Y120.14 E.00447
G1 X137.06 Y120.14 E.00894
G1 X137.06 Y120.29 E.00447
G1 X137.21 Y120.29 E.00447
G1 X137.21 Y120.44 E.00447
G1 X137.36 Y120.44 E.00447
G1 X137.36 Y120.74 E.00894
G1 X137.51 Y120.74 E.00447
G1 X137.51 Y120.89 E.00447
G1 X137.66 Y120.89 E.00447
G1 X137.66 Y121.04 E.00447
G1 X137.81 Y121.04 E.00447
G1 X137.81 Y121.19 E.00447
G1 X137.96 Y121.19 E.00447
G1 X137.96 Y121.34 E.00447
G1 X138.11 Y121.34 E.00447
G1 X138.11 Y121.49 E.00447
G1 X138.26 Y121.49 E.00447
G1 X138.26 Y121.79 E.00894
G1 X138.41 Y121.79 E.00447
G1 X138.41 Y121.94 E.00447
G1 X138.56 Y121.94 E.00447
G1 X138.56 Y122.09 E.00447
G1 X138.71 Y122.09 E.00447
G1 X138.71 Y122.39 E.00894
G1 X138.86 Y122.39 E.00447
G1 X138.86 Y122.69 E.00894
G1 X139.01 Y122.69 E.00447
G1 X139.01 Y122.84 E.00447
G1 X139.16 Y122.84 E.00447
G1 X139.16 Y123.14 E.00894
G1 X139.31 Y123.14 E.00447
G1 X139.31 Y123.44 E.00894
G1 X139.46 Y123.44 E.00447
G1 X139.46 Y123.74 E.00894
G1 X139.61 Y123.74 E.00447
G1 X139.61 Y124.04 E.00894
G1 X139.76 Y124.04 E.00447
G1 X139.76 Y124.34 E.00894
G1 X139.91 Y124.34 E.00447
G1 X139.91 Y124.64 E.00894
G1 X140.06 Y124.64 E.00447
G1 X140.06 Y125.09 E.0134
G1 X140.21 Y125.09 E.00447
G1 X140.21 Y125.54 E.0134
G1 X140.36 Y125.54 E.00447
G1 X140.36 Y125.99 E.0134
G1 X140.39 Y125.99 E.00089
G1 X140.39 Y125.51 E.0143
G1 X140.24 Y125.51 E.00447
G1 X140.24 Y124.91 E.01787
G1 X140.09 Y124.91 E.00447
G1 X140.09 Y124.46 E.0134
G1 X139.94 Y124.46 E.00447
G1 X139.94 Y124.01 E.0134
G1 X139.79 Y124.01 E.00447
G1 X139.79 Y123.56 E.0134
G1 X139.64 Y123.56 E.00447
G1 X139.64 Y123.26 E.00894
G1 X139.49 Y123.26 E.00447
G1 X139.49 Y122.96 E.00894
G1 X139.34 Y122.96 E.00447
G1 X139.34 Y122.66 E.00894
G1 X139.19 Y122.66 E.00447
G1 X139.19 Y122.36 E.00894
G1 X139.04 Y122.36 E.00447
G1 X139.04 Y122.21 E.00447
G1 X138.89 Y122.21 E.00447
G1 X138.89 Y121.91 E.00894
G1 X138.74 Y121.91 E.00447
G1 X138.74 Y121.76 E.00447
G1 X138.59 Y121.76 E.00447
G1 X138.59 Y121.46 E.00894
G1 X138.44 Y121.46 E.00447
G1 X138.44 Y121.31 E.00447
G1 X138.29 Y121.31 E.00447
G1 X138.29 Y121.01 E.00894
G1 X138.14 Y121.01 E.00447
G1 X138.14 Y120.86 E.00447
G1 X137.99 Y120.86 E.00447
G1 X137.99 Y120.71 E.00447
G1 X137.84 Y120.71 E.00447
G1 X137.84 Y120.56 E.00447
G1 X137.69 Y120.56 E.00447
G1 X137.69 Y120.41 E.00447
G1 X137.54 Y120.41 E.00447
G1 X137.54 Y120.26 E.00447
G1 X137.39 Y120.26 E.00447
G1 X137.39 Y120.11 E.00447
G1 X137.24 Y120.11 E.00447
G1 X137.24 Y119.96 E.00447
G1 X137.09 Y119.96 E.00447
G1 X137.09 Y119.81 E.00447
G1 X136.94 Y119.81 E.00447
G1 X136.94 Y119.66 E.00447
G1 X136.79 Y119.66 E.00447
G1 X136.79 Y119.51 E.00447
G1 X136.64 Y119.51 E.00447
G1 X136.64 Y119.36 E.00447
G1 X136.49 Y119.36 E.00447
G1 X136.49 Y119.21 E.00447
G1 X136.19 Y119.21 E.00894
G1 X136.19 Y119.06 E.00447
G1 X136.04 Y119.06 E.00447
G1 X136.04 Y118.91 E.00447
G1 X135.74 Y118.91 E.00894
G1 X135.74 Y118.76 E.00447
G1 X135.59 Y118.76 E.00447
G1 X135.59 Y118.61 E.00447
G1 X135.29 Y118.61 E.00894
G1 X135.29 Y118.46 E.00447
G1 X135.14 Y118.46 E.00447
G1 X135.14 Y118.31 E.00447
G1 X134.84 Y118.31 E.00894
G1 X134.84 Y118.16 E.00447
G1 X134.54 Y118.16 E.00894
G1 X134.54 Y118.01 E.00447
G1 X134.24 Y118.01 E.00894
G1 X134.24 Y117.86 E.00447
G1 X133.94 Y117.86 E.00894
G1 X133.94 Y117.71 E.00447
G1 X133.64 Y117.71 E.00894
G1 X133.64 Y117.56 E.00447
G1 X133.19 Y117.56 E.0134
G1 X133.19 Y117.41 E.00447
G1 X132.74 Y117.41 E.0134
G1 X132.74 Y117.26 E.00447
G1 X132.29 Y117.26 E.0134
G1 X132.29 Y117.11 E.00447
G1 X131.84 Y117.11 E.0134
M204 S250
G1 X131.36 Y116.99 F36000
G1 F3156
M204 S6000
G1 X131.69 Y116.99 E.00983
G1 X131.69 Y116.96 E.00089
G1 X131.39 Y116.96 E.00894
M204 S250
G1 X130.91 Y116.84 F36000
G1 F3156
M204 S6000
G1 X131.09 Y116.84 E.00536
G1 X131.09 Y116.81 E.00089
G1 X130.94 Y116.81 E.00447
; WIPE_START
G1 F9547.055
M204 S10000
G1 X131.09 Y116.84 E-.34915
G1 X131.09 Y116.81 E-.06849
G1 X130.94 Y116.81 E-.34237
; WIPE_END
G1 E-.04 F1800
G1 X136.371 Y122.173 Z1.2 F36000
G1 X140.51 Y126.26 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F3156
M204 S6000
G1 X140.51 Y126.44 E.00536
G1 X140.54 Y126.44 E.00089
G1 X140.54 Y126.29 E.00447
; WIPE_START
G1 F9547.055
M204 S10000
G1 X140.51 Y126.44 E-.34915
G1 X140.54 Y126.44 E-.06849
G1 X140.54 Y126.29 E-.34237
; WIPE_END
G1 E-.04 F1800
G1 X134.355 Y121.818 Z1.2 F36000
G1 X130.252 Y118.852 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3156
G1 X130.252 Y119.148 E.00951
G1 X130.402 Y119.148 E.00482
G1 X130.402 Y119.448 E.00965
G1 X130.552 Y119.448 E.00482
G1 X130.552 Y120.048 E.01929
G1 X130.702 Y120.048 E.00482
G1 X130.702 Y120.648 E.01929
G1 X130.852 Y120.648 E.00482
G1 X130.852 Y121.548 E.02894
G1 X131.002 Y121.548 E.00482
G1 X131.002 Y124.102 E.08213
G1 X130.852 Y124.102 E.00482
G1 X130.852 Y124.398 E.00951
G1 X131.002 Y124.398 E.00482
G1 X131.002 Y124.548 E.00482
G1 X131.152 Y124.548 E.00482
G1 X131.152 Y124.698 E.00482
G1 X131.302 Y124.698 E.00482
G1 X131.302 Y124.848 E.00482
G1 X131.452 Y124.848 E.00482
G1 X131.452 Y124.998 E.00482
G1 X131.602 Y124.998 E.00482
G1 X131.602 Y125.148 E.00482
G1 X131.752 Y125.148 E.00482
G1 X131.752 Y125.448 E.00965
G1 X132.198 Y125.448 E.01434
G1 X132.198 Y125.298 E.00482
G1 X132.348 Y125.298 E.00482
G1 X132.348 Y125.148 E.00482
G1 X132.498 Y125.148 E.00482
G1 X132.498 Y124.998 E.00482
G1 X132.648 Y124.998 E.00482
G1 X132.648 Y124.698 E.00965
G1 X132.798 Y124.698 E.00482
G1 X132.798 Y124.548 E.00482
G1 X132.948 Y124.548 E.00482
G1 X132.948 Y124.398 E.00482
G1 X133.098 Y124.398 E.00482
G1 X133.098 Y124.098 E.00965
G1 X133.248 Y124.098 E.00482
G1 X133.248 Y123.948 E.00482
G1 X133.398 Y123.948 E.00482
G1 X133.398 Y123.648 E.00965
G1 X133.548 Y123.648 E.00482
G1 X133.548 Y123.498 E.00482
G1 X133.698 Y123.498 E.00482
G1 X133.698 Y123.198 E.00965
G1 X133.848 Y123.198 E.00482
G1 X133.848 Y122.898 E.00965
G1 X133.998 Y122.898 E.00482
G1 X133.998 Y122.598 E.00965
G1 X134.148 Y122.598 E.00482
G1 X134.148 Y121.998 E.01929
G1 X134.298 Y121.998 E.00482
G1 X134.298 Y121.702 E.00951
G1 X134.148 Y121.702 E.00482
G1 X134.148 Y121.402 E.00965
G1 X133.998 Y121.402 E.00482
G1 X133.998 Y121.102 E.00965
G1 X133.848 Y121.102 E.00482
G1 X133.848 Y120.952 E.00482
G1 X133.698 Y120.952 E.00482
G1 X133.698 Y120.802 E.00482
G1 X133.548 Y120.802 E.00482
G1 X133.548 Y120.652 E.00482
G1 X133.398 Y120.652 E.00482
G1 X133.398 Y120.502 E.00482
G1 X133.248 Y120.502 E.00482
G1 X133.248 Y120.352 E.00482
G1 X133.098 Y120.352 E.00482
G1 X133.098 Y120.202 E.00482
G1 X132.798 Y120.202 E.00965
G1 X132.798 Y120.052 E.00482
G1 X132.648 Y120.052 E.00482
G1 X132.648 Y119.902 E.00482
G1 X132.498 Y119.902 E.00482
G1 X132.498 Y119.752 E.00482
G1 X132.198 Y119.752 E.00965
G1 X132.198 Y119.602 E.00482
G1 X131.898 Y119.602 E.00965
G1 X131.898 Y119.452 E.00482
G1 X131.598 Y119.452 E.00965
G1 X131.598 Y119.302 E.00482
G1 X131.298 Y119.302 E.00965
G1 X131.298 Y119.152 E.00482
G1 X130.998 Y119.152 E.00965
G1 X130.998 Y119.002 E.00482
G1 X130.548 Y119.002 E.01447
G1 X130.548 Y118.852 E.00482
G1 X130.312 Y118.852 E.00758
; WIPE_START
G1 F8843.478
G1 X130.252 Y119.148 E-.11472
G1 X130.402 Y119.148 E-.057
G1 X130.402 Y119.448 E-.114
G1 X130.552 Y119.448 E-.057
G1 X130.552 Y120.048 E-.228
G1 X130.702 Y120.048 E-.057
G1 X130.702 Y120.396 E-.13228
; WIPE_END
G1 E-.04 F1800
G1 X129.11 Y118.04 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X129.11 Y118.19 E.00447
G1 X129.26 Y118.19 E.00447
G1 X129.26 Y118.49 E.00894
G1 X129.41 Y118.49 E.00447
G1 X129.41 Y118.64 E.00447
G1 X129.56 Y118.64 E.00447
G1 X129.56 Y118.94 E.00894
G1 X129.71 Y118.94 E.00447
G1 X129.71 Y119.24 E.00894
G1 X129.86 Y119.24 E.00447
G1 X129.86 Y119.54 E.00894
G1 X130.01 Y119.54 E.00447
G1 X130.01 Y119.84 E.00894
G1 X130.16 Y119.84 E.00447
G1 X130.16 Y120.44 E.01787
G1 X130.31 Y120.44 E.00447
G1 X130.31 Y121.04 E.01787
G1 X130.46 Y121.04 E.00447
G1 X130.46 Y121.94 E.02681
G1 X130.61 Y121.94 E.00447
G1 X130.61 Y123.71 E.05272
G1 X130.46 Y123.71 E.00447
G1 X130.46 Y124.79 E.03217
G1 X130.61 Y124.79 E.00447
G1 X130.61 Y124.94 E.00447
G1 X130.76 Y124.94 E.00447
G1 X130.76 Y125.09 E.00447
G1 X130.91 Y125.09 E.00447
G1 X130.91 Y125.24 E.00447
G1 X131.06 Y125.24 E.00447
G1 X131.06 Y125.39 E.00447
G1 X131.21 Y125.39 E.00447
G1 X131.21 Y125.54 E.00447
G1 X131.36 Y125.54 E.00447
G1 X131.36 Y125.84 E.00894
G1 X131.51 Y125.84 E.00447
G1 X131.51 Y126.14 E.00894
G1 X131.66 Y126.14 E.00447
G1 X131.66 Y126.44 E.00894
G1 X131.84 Y126.44 E.00536
G1 X131.84 Y126.29 E.00447
G1 X132.14 Y126.29 E.00894
G1 X132.14 Y126.14 E.00447
G1 X132.29 Y126.14 E.00447
G1 X132.29 Y125.99 E.00447
G1 X132.44 Y125.99 E.00447
G1 X132.44 Y125.84 E.00447
G1 X132.59 Y125.84 E.00447
G1 X132.59 Y125.69 E.00447
G1 X132.74 Y125.69 E.00447
G1 X132.74 Y125.54 E.00447
G1 X132.89 Y125.54 E.00447
G1 X132.89 Y125.39 E.00447
G1 X133.04 Y125.39 E.00447
G1 X133.04 Y125.09 E.00894
G1 X133.19 Y125.09 E.00447
G1 X133.19 Y124.94 E.00447
G1 X133.34 Y124.94 E.00447
G1 X133.34 Y124.79 E.00447
G1 X133.49 Y124.79 E.00447
G1 X133.49 Y124.49 E.00894
G1 X133.64 Y124.49 E.00447
G1 X133.64 Y124.34 E.00447
G1 X133.79 Y124.34 E.00447
G1 X133.79 Y124.04 E.00894
G1 X133.94 Y124.04 E.00447
G1 X133.94 Y123.89 E.00447
G1 X134.09 Y123.89 E.00447
G1 X134.09 Y123.59 E.00894
G1 X134.24 Y123.59 E.00447
G1 X134.24 Y123.29 E.00894
G1 X134.39 Y123.29 E.00447
G1 X134.39 Y122.99 E.00894
G1 X134.54 Y122.99 E.00447
G1 X134.54 Y122.39 E.01787
G1 X134.69 Y122.39 E.00447
G1 X134.69 Y121.31 E.03217
G1 X134.54 Y121.31 E.00447
G1 X134.54 Y121.01 E.00894
G1 X134.39 Y121.01 E.00447
G1 X134.39 Y120.71 E.00894
G1 X134.24 Y120.71 E.00447
G1 X134.24 Y120.56 E.00447
G1 X134.09 Y120.56 E.00447
G1 X134.09 Y120.41 E.00447
G1 X133.94 Y120.41 E.00447
G1 X133.94 Y120.26 E.00447
G1 X133.79 Y120.26 E.00447
G1 X133.79 Y120.11 E.00447
G1 X133.64 Y120.11 E.00447
G1 X133.64 Y119.96 E.00447
G1 X133.49 Y119.96 E.00447
G1 X133.49 Y119.81 E.00447
G1 X133.19 Y119.81 E.00894
G1 X133.19 Y119.66 E.00447
G1 X133.04 Y119.66 E.00447
G1 X133.04 Y119.51 E.00447
G1 X132.89 Y119.51 E.00447
G1 X132.89 Y119.36 E.00447
G1 X132.59 Y119.36 E.00894
G1 X132.59 Y119.21 E.00447
G1 X132.29 Y119.21 E.00894
G1 X132.29 Y119.06 E.00447
G1 X131.99 Y119.06 E.00894
G1 X131.99 Y118.91 E.00447
G1 X131.69 Y118.91 E.00894
G1 X131.69 Y118.76 E.00447
G1 X131.39 Y118.76 E.00894
G1 X131.39 Y118.61 E.00447
G1 X130.94 Y118.61 E.0134
G1 X130.94 Y118.46 E.00447
G1 X130.64 Y118.46 E.00894
G1 X130.64 Y118.31 E.00447
G1 X130.19 Y118.31 E.0134
G1 X130.19 Y118.16 E.00447
G1 X129.74 Y118.16 E.0134
G1 X129.74 Y118.01 E.00447
G1 X128.99 Y118.01 E.02234
G1 X128.99 Y117.86 E.00447
G1 X128.96 Y117.86 E.00089
G1 X128.96 Y118.04 E.00536
G1 X129.05 Y118.04 E.00268
; WIPE_START
G1 F9547.055
M204 S10000
G1 X129.11 Y118.19 E-.06139
G1 X129.26 Y118.19 E-.057
G1 X129.26 Y118.49 E-.114
G1 X129.41 Y118.49 E-.057
G1 X129.41 Y118.64 E-.057
G1 X129.56 Y118.64 E-.057
G1 X129.56 Y118.94 E-.114
G1 X129.71 Y118.94 E-.057
G1 X129.71 Y119.24 E-.114
G1 X129.86 Y119.24 E-.057
G1 X129.86 Y119.278 E-.01461
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y118.606 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.274875
G1 F3156
G1 X129.933 Y118.619 E.0006
G1 X129.955 Y118.656 E.00079
; LINE_WIDTH: 0.231595
G1 X129.968 Y118.7 E.00068
; LINE_WIDTH: 0.194535
G1 X129.981 Y119.044 E.00412
G1 X129.964 Y118.606 F36000
; LINE_WIDTH: 0.238584
G1 F3156
G1 X129.994 Y118.594 E.00051
; LINE_WIDTH: 0.194616
G1 X130.444 Y118.581 E.00539
; WIPE_START
G1 F15000
G1 X129.994 Y118.594 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X130.831 Y119.844 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.198522
G1 F3156
G1 X130.831 Y119.655 E.00232
G1 X130.856 Y119.606 E.00069
; LINE_WIDTH: 0.26777
G1 X130.881 Y119.556 E.00099
; LINE_WIDTH: 0.317737
G1 X130.906 Y119.506 E.00121
; LINE_WIDTH: 0.34282
G1 X130.944 Y119.506 E.00092
; LINE_WIDTH: 0.317769
G1 X130.994 Y119.531 E.00121
; LINE_WIDTH: 0.26777
G1 X131.044 Y119.556 E.00099
; LINE_WIDTH: 0.217804
G1 X131.094 Y119.581 E.00077
; LINE_WIDTH: 0.19282
G1 X131.394 Y119.581 E.00355
; WIPE_START
G1 F15000
G1 X131.094 Y119.581 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.539 Y121.989 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.40158
G1 F3156
G1 X132.471 Y122.028 E.0022
G1 X132.525 Y122.059 E.00177
; WIPE_START
G1 F10037.362
G1 X132.471 Y122.028 E-.33886
G1 X132.539 Y121.989 E-.42114
; WIPE_END
G1 E-.04 F1800
G1 X132.148 Y123.386 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F3156
G2 X132.94 Y122 I-9.541 J-6.369 E.04759
G1 X132.837 Y121.831 E.00591
M73 P91 R0
G2 X132.243 Y121.28 I-2.413 J2.006 E.02418
G1 X132.133 Y121.22 E.00373
G3 X132.148 Y123.326 I-39.598 J1.335 E.06274
G1 X131.771 Y123.977 F36000
; LINE_WIDTH: 0.421005
G1 F3156
G1 X131.86 Y124.036 E.00318
G1 X132.236 Y123.907 E.01188
G1 X132.338 Y123.79 E.00463
G2 X132.808 Y123.031 I-10.531 J-7.041 E.02666
G1 X132.938 Y122.89 E.00574
G3 X133.379 Y121.985 I12.202 J5.373 E.03008
G3 X133.177 Y121.623 I12.595 J-7.269 E.01237
G2 X132.49 Y120.962 I-26.47 J26.793 E.02848
G1 X132.255 Y120.88 E.00745
; LINE_WIDTH: 0.468093
G1 X132.052 Y120.713 E.00881
; LINE_WIDTH: 0.502694
G1 X131.849 Y120.547 E.00953
G1 X131.664 Y120.485 E.00709
G1 X131.664 Y120.975 E.01779
G1 X131.738 Y121.048 E.0038
; LINE_WIDTH: 0.48542
G1 X131.755 Y121.31 E.00915
; LINE_WIDTH: 0.422181
G1 X131.771 Y121.571 E.00785
G1 X131.771 Y123.917 E.07027
G1 X131.536 Y124.314 F36000
; LINE_WIDTH: 0.41999
G1 F3156
G3 X131.739 Y124.479 I-.152 J.392 E.00792
G1 X132.226 Y124.328 E.0152
G1 X132.33 Y124.362 E.00328
G1 X132.706 Y124.019 E.01516
G1 X132.713 Y123.844 E.00519
G1 X132.793 Y123.735 E.00404
G1 X132.865 Y123.715 E.00221
G1 X132.931 Y123.594 E.00412
G1 X133.006 Y123.569 E.00234
G1 X133.015 Y123.385 E.00548
G1 X133.093 Y123.285 E.00377
G1 X133.165 Y123.265 E.00221
G1 X133.231 Y123.144 E.00412
G1 X133.306 Y123.119 E.00234
G1 X133.339 Y122.888 E.00693
G1 X133.456 Y122.819 E.00406
G1 X133.489 Y122.587 E.00696
G1 X133.606 Y122.519 E.00403
G1 X133.627 Y122.308 E.00632
G1 X133.756 Y122.223 E.00459
G1 X133.756 Y121.777 E.01329
G1 X133.627 Y121.692 E.00459
G1 X133.606 Y121.481 E.00632
G1 X133.485 Y121.407 E.00422
G1 X133.465 Y121.335 E.00221
G1 X133.343 Y121.267 E.00416
G1 X133.315 Y121.185 E.0026
G1 X133.192 Y121.116 E.00422
G1 X133.165 Y121.035 E.00254
G1 X133.04 Y120.964 E.00427
G1 X133.015 Y120.885 E.00248
G1 X132.885 Y120.807 E.00451
G1 X132.865 Y120.735 E.00221
G1 X132.744 Y120.669 E.00412
G1 X132.719 Y120.594 E.00234
G1 X132.485 Y120.559 E.00705
G1 X132.119 Y120.144 E.01647
G1 X131.902 Y120.12 E.0065
G1 X131.772 Y119.994 E.00538
G1 X131.598 Y120.069 E.00565
G1 X131.316 Y120.091 E.00843
G1 X131.28 Y120.165 E.00243
G1 X131.104 Y120.262 E.006
G1 X131.236 Y120.391 E.00551
G1 X131.244 Y121.176 E.02337
G1 X131.37 Y121.253 E.0044
G1 X131.394 Y121.784 E.01582
G1 X131.394 Y124.174 E.07121
G1 X131.522 Y124.255 E.00451
G1 X132.294 Y124.869 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.19282
G1 F3156
G1 X132.144 Y124.869 E.00178
; LINE_WIDTH: 0.20768
G1 X132.097 Y124.884 E.00064
; LINE_WIDTH: 0.234768
G1 X132.05 Y124.899 E.00075
G1 X132.05 Y125.094 E.00296
; WIPE_START
G1 F15000
G1 X132.05 Y124.899 E-.60632
G1 X132.097 Y124.884 E-.15368
; WIPE_END
G1 E-.04 F1800
G1 X127.098 Y123.498 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3156
G1 X127.098 Y123.052 E.01434
G1 X126.948 Y123.052 E.00482
G1 X126.948 Y122.752 E.00965
G1 X126.798 Y122.752 E.00482
G1 X126.798 Y122.452 E.00965
G1 X126.648 Y122.452 E.00482
G1 X126.648 Y122.302 E.00482
G1 X126.498 Y122.302 E.00482
G1 X126.498 Y122.002 E.00965
G1 X126.348 Y122.002 E.00482
G1 X126.348 Y121.852 E.00482
G1 X126.198 Y121.852 E.00482
G1 X126.198 Y121.702 E.00482
G1 X126.048 Y121.702 E.00482
G1 X126.048 Y121.402 E.00965
G1 X125.898 Y121.402 E.00482
G1 X125.898 Y121.252 E.00482
G1 X125.748 Y121.252 E.00482
G1 X125.748 Y121.102 E.00482
G1 X125.598 Y121.102 E.00482
G1 X125.598 Y120.952 E.00482
G1 X125.448 Y120.952 E.00482
G1 X125.448 Y120.802 E.00482
G1 X125.298 Y120.802 E.00482
G1 X125.298 Y120.652 E.00482
G1 X124.998 Y120.652 E.00965
G1 X124.998 Y120.502 E.00482
G1 X124.848 Y120.502 E.00482
G1 X124.848 Y120.352 E.00482
G1 X124.548 Y120.352 E.00965
G1 X124.548 Y120.202 E.00482
G1 X124.248 Y120.202 E.00965
G1 X124.248 Y120.052 E.00482
G1 X123.948 Y120.052 E.00965
G1 X123.948 Y119.902 E.00482
G1 X123.648 Y119.902 E.00965
G1 X123.648 Y119.752 E.00482
G1 X122.902 Y119.752 E.02398
G1 X122.902 Y119.902 E.00482
G1 X122.602 Y119.902 E.00965
G1 X122.602 Y120.052 E.00482
G1 X122.152 Y120.052 E.01447
G1 X122.152 Y120.202 E.00482
G1 X122.002 Y120.202 E.00482
G1 X122.002 Y120.352 E.00482
G1 X121.702 Y120.352 E.00965
G1 X121.702 Y120.502 E.00482
G1 X121.552 Y120.502 E.00482
G1 X121.552 Y120.652 E.00482
G1 X121.402 Y120.652 E.00482
G1 X121.402 Y120.802 E.00482
G1 X121.252 Y120.802 E.00482
G1 X121.252 Y120.952 E.00482
G1 X121.102 Y120.952 E.00482
G1 X121.102 Y121.102 E.00482
G1 X120.802 Y121.102 E.00965
G1 X120.802 Y121.252 E.00482
G1 X120.652 Y121.252 E.00482
G1 X120.652 Y121.552 E.00965
G1 X120.502 Y121.552 E.00482
G1 X120.502 Y121.702 E.00482
G1 X120.352 Y121.702 E.00482
G1 X120.352 Y121.852 E.00482
G1 X120.202 Y121.852 E.00482
G1 X120.202 Y122.002 E.00482
G1 X120.052 Y122.002 E.00482
G1 X120.052 Y122.302 E.00965
G1 X119.902 Y122.302 E.00482
G1 X119.902 Y122.452 E.00482
G1 X119.752 Y122.452 E.00482
G1 X119.752 Y122.748 E.00951
G1 X122.602 Y122.748 E.09165
G1 X122.602 Y122.898 E.00482
G1 X123.502 Y122.898 E.02894
G1 X123.502 Y123.048 E.00482
G1 X123.952 Y123.048 E.01447
G1 X123.952 Y123.198 E.00482
G1 X124.552 Y123.198 E.01929
G1 X124.552 Y123.348 E.00482
G1 X124.852 Y123.348 E.00965
G1 X124.852 Y123.498 E.00482
G1 X125.152 Y123.498 E.00965
G1 X125.152 Y123.648 E.00482
G1 X125.452 Y123.648 E.00965
G1 X125.452 Y123.798 E.00482
G1 X126.048 Y123.798 E.01916
G1 X126.048 Y123.648 E.00482
G1 X126.648 Y123.648 E.01929
G1 X126.648 Y123.498 E.00482
G1 X127.038 Y123.498 E.01254
M204 S250
G1 X127.94 Y123.89 F36000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X127.94 Y123.71 E.00536
G1 X127.79 Y123.71 E.00447
G1 X127.79 Y123.26 E.0134
G1 X127.64 Y123.26 E.00447
G1 X127.64 Y122.96 E.00894
G1 X127.49 Y122.96 E.00447
G1 X127.49 Y122.66 E.00894
G1 X127.34 Y122.66 E.00447
G1 X127.34 Y122.36 E.00894
G1 X127.19 Y122.36 E.00447
G1 X127.19 Y122.06 E.00894
G1 X127.04 Y122.06 E.00447
G1 X127.04 Y121.91 E.00447
G1 X126.89 Y121.91 E.00447
G1 X126.89 Y121.61 E.00894
G1 X126.74 Y121.61 E.00447
G1 X126.74 Y121.46 E.00447
G1 X126.59 Y121.46 E.00447
G1 X126.59 Y121.31 E.00447
G1 X126.44 Y121.31 E.00447
G1 X126.44 Y121.01 E.00894
G1 X126.29 Y121.01 E.00447
G1 X126.29 Y120.86 E.00447
G1 X126.14 Y120.86 E.00447
G1 X126.14 Y120.71 E.00447
G1 X125.99 Y120.71 E.00447
G1 X125.99 Y120.56 E.00447
G1 X125.84 Y120.56 E.00447
G1 X125.84 Y120.41 E.00447
G1 X125.69 Y120.41 E.00447
G1 X125.69 Y120.26 E.00447
G1 X125.39 Y120.26 E.00894
G1 X125.39 Y120.11 E.00447
G1 X125.24 Y120.11 E.00447
G1 X125.24 Y119.96 E.00447
G1 X124.94 Y119.96 E.00894
G1 X124.94 Y119.81 E.00447
G1 X124.64 Y119.81 E.00894
G1 X124.64 Y119.66 E.00447
G1 X124.34 Y119.66 E.00894
G1 X124.34 Y119.51 E.00447
G1 X124.04 Y119.51 E.00894
G1 X124.04 Y119.36 E.00447
G1 X122.51 Y119.36 E.04557
G1 X122.51 Y119.51 E.00447
G1 X122.21 Y119.51 E.00894
G1 X122.21 Y119.66 E.00447
G1 X121.76 Y119.66 E.0134
G1 X121.76 Y119.81 E.00447
G1 X121.61 Y119.81 E.00447
G1 X121.61 Y119.96 E.00447
G1 X121.31 Y119.96 E.00894
G1 X121.31 Y120.11 E.00447
G1 X121.16 Y120.11 E.00447
G1 X121.16 Y120.26 E.00447
G1 X121.01 Y120.26 E.00447
G1 X121.01 Y120.41 E.00447
G1 X120.86 Y120.41 E.00447
G1 X120.86 Y120.56 E.00447
G1 X120.71 Y120.56 E.00447
G1 X120.71 Y120.71 E.00447
G1 X120.41 Y120.71 E.00894
G1 X120.41 Y120.86 E.00447
G1 X120.26 Y120.86 E.00447
G1 X120.26 Y121.16 E.00894
G1 X120.11 Y121.16 E.00447
G1 X120.11 Y121.31 E.00447
G1 X119.96 Y121.31 E.00447
G1 X119.96 Y121.46 E.00447
G1 X119.81 Y121.46 E.00447
G1 X119.81 Y121.61 E.00447
G1 X119.66 Y121.61 E.00447
G1 X119.66 Y121.91 E.00894
G1 X119.51 Y121.91 E.00447
G1 X119.51 Y122.06 E.00447
G1 X119.36 Y122.06 E.00447
G1 X119.36 Y122.36 E.00894
G1 X119.21 Y122.36 E.00447
G1 X119.21 Y122.51 E.00447
G1 X119.06 Y122.51 E.00447
G1 X119.06 Y122.81 E.00894
G1 X118.91 Y122.81 E.00447
G1 X118.91 Y122.96 E.00447
G1 X118.76 Y122.96 E.00447
G1 X118.76 Y123.26 E.00894
G1 X118.61 Y123.26 E.00447
G1 X118.61 Y123.59 E.00983
G1 X118.79 Y123.59 E.00536
G1 X118.79 Y123.44 E.00447
G1 X119.39 Y123.44 E.01787
G1 X119.39 Y123.29 E.00447
G1 X120.29 Y123.29 E.02681
G1 X120.29 Y123.14 E.00447
G1 X122.21 Y123.14 E.05719
G1 X122.21 Y123.29 E.00447
G1 X123.11 Y123.29 E.02681
G1 X123.11 Y123.44 E.00447
G1 X123.56 Y123.44 E.0134
G1 X123.56 Y123.59 E.00447
G1 X124.16 Y123.59 E.01787
G1 X124.16 Y123.74 E.00447
G1 X124.46 Y123.74 E.00894
G1 X124.46 Y123.89 E.00447
G1 X124.76 Y123.89 E.00894
G1 X124.76 Y124.04 E.00447
G1 X125.06 Y124.04 E.00894
G1 X125.06 Y124.19 E.00447
G1 X125.36 Y124.19 E.00894
G1 X125.36 Y124.34 E.00447
G1 X125.66 Y124.34 E.00894
G1 X125.66 Y124.49 E.00447
G1 X125.84 Y124.49 E.00536
G1 X125.84 Y124.34 E.00447
G1 X126.14 Y124.34 E.00894
G1 X126.14 Y124.19 E.00447
G1 X126.44 Y124.19 E.00894
G1 X126.44 Y124.04 E.00447
G1 X127.04 Y124.04 E.01787
G1 X127.04 Y123.89 E.00447
G1 X127.88 Y123.89 E.02502
M204 S10000
G1 X127.594 Y123.575 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.281152
G1 F3156
G3 X127.415 Y123.573 I-.075 J-1.468 E.00337
; LINE_WIDTH: 0.26152
G1 X127.392 Y123.515 E.00109
; LINE_WIDTH: 0.19679
G1 X127.369 Y123.456 E.00076
G1 X127.369 Y123.156 E.00365
G1 X126.594 Y123.105 F36000
; LINE_WIDTH: 0.34282
G1 F3156
G1 X126.594 Y123.294 E.00448
G1 X126.594 Y123.105 F36000
; LINE_WIDTH: 0.317737
G1 F3156
G1 X126.569 Y123.056 E.00121
; LINE_WIDTH: 0.26777
G1 X126.544 Y123.006 E.00099
; LINE_WIDTH: 0.196743
G1 X126.519 Y122.956 E.00068
G1 X126.519 Y122.656 E.00365
; WIPE_START
G1 F15000
G1 X126.519 Y122.956 E-.64068
G1 X126.544 Y123.006 E-.11932
; WIPE_END
G1 E-.04 F1800
G1 X125.944 Y124.069 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.19282
G1 F3156
G1 X125.556 Y124.069 E.00459
; WIPE_START
G1 F15000
G1 X125.944 Y124.069 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.749 Y122.026 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.47069
G1 F3156
G1 X124.484 Y121.773 E.01238
G1 X124.31 Y121.694 E.00645
G1 X124.018 Y121.467 E.0125
G1 X123.63 Y121.299 E.0143
; LINE_WIDTH: 0.454035
G1 X123.314 Y121.282 E.01027
; LINE_WIDTH: 0.401813
G2 X122.817 Y121.256 I-3.294 J59.448 E.01412
G1 X122.306 Y121.613 E.01765
G1 X122.864 Y121.615 E.01582
; LINE_WIDTH: 0.415385
G1 X123.071 Y121.657 E.00621
; LINE_WIDTH: 0.468363
G2 X123.933 Y121.753 I.761 J-2.912 E.02924
G3 X124.692 Y122.007 I-6.467 J20.65 E.0269
; WIPE_START
G1 F8461.774
G1 X123.933 Y121.753 E-.36413
G1 X123.382 Y121.726 E-.25094
G1 X123.071 Y121.657 E-.14493
; WIPE_END
G1 E-.04 F1800
G1 X125.625 Y122.814 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.41999
G1 F3156
G1 X125.652 Y122.502 E.00933
G1 X125.405 Y122.262 E.01025
G1 X125.193 Y121.899 E.01255
G2 X124.69 Y121.412 I-5.843 J5.526 E.02085
G1 X124.512 Y121.345 E.00567
G1 X124.196 Y121.101 E.01189
G1 X123.726 Y120.891 E.01533
G3 X122.669 Y120.879 I-.431 J-8.995 E.03149
G1 X122.518 Y121.027 E.00629
G1 X122.223 Y121.173 E.00982
G1 X121.797 Y121.607 E.01811
G1 X121.523 Y121.819 E.01031
G1 X121.561 Y121.979 E.0049
G1 X122.806 Y121.979 E.03706
G1 X123.081 Y122.051 E.00849
G1 X123.127 Y122.129 E.0027
G1 X123.706 Y122.129 E.01723
G1 X123.999 Y122.211 E.00908
G1 X124.063 Y122.279 E.00279
G1 X124.32 Y122.303 E.00769
G1 X124.454 Y122.364 E.00438
G1 X124.49 Y122.429 E.00221
G1 X124.91 Y122.45 E.01252
G3 X125.572 Y122.786 I-9.961 J20.435 E.02211
G1 X125.75 Y123.444 F36000
; LINE_WIDTH: 0.419551
G1 F3156
G1 X125.801 Y123.262 E.00564
G1 X126.032 Y123.257 E.00686
G1 X125.982 Y122.891 E.01097
G1 X126.029 Y122.844 E.00197
G1 X126.029 Y122.452 E.01167
G1 X126.079 Y122.359 E.00315
G1 X125.985 Y122.306 E.00323
G1 X125.964 Y122.236 E.00218
G1 X125.832 Y122.152 E.00465
G1 X125.814 Y122.086 E.00204
G1 X125.698 Y122.024 E.00391
G3 X125.656 Y121.781 I.322 J-.181 E.00749
G1 X125.535 Y121.707 E.00422
G1 X125.515 Y121.635 E.00221
G1 X125.387 Y121.56 E.0044
G1 X125.365 Y121.485 E.00232
G1 X125.238 Y121.412 E.00435
G1 X125.215 Y121.335 E.00238
G1 X125.085 Y121.257 E.0045
G1 X125.065 Y121.185 E.00221
G1 X124.944 Y121.119 E.00411
G1 X124.919 Y121.044 E.00234
G1 X124.7 Y121.019 E.00655
G1 X124.469 Y120.744 E.01069
G1 X124.237 Y120.71 E.00697
G1 X124.169 Y120.594 E.00401
G1 X123.952 Y120.57 E.00649
G1 X123.822 Y120.444 E.00538
G1 X123.63 Y120.519 E.00613
G1 X122.898 Y120.519 E.02179
G1 X122.792 Y120.484 E.0033
G1 X122.772 Y120.444 E.00133
G1 X122.531 Y120.444 E.00718
G1 X122.445 Y120.572 E.00458
G1 X122.386 Y120.586 E.00179
G1 X122.31 Y120.713 E.00439
G1 X122.081 Y120.744 E.00686
G1 X122.007 Y120.865 E.00422
G1 X121.935 Y120.885 E.00221
G1 X121.86 Y121.013 E.0044
G1 X121.785 Y121.035 E.00232
G1 X121.707 Y121.165 E.0045
G1 X121.635 Y121.185 E.00222
G1 X121.554 Y121.317 E.0046
G1 X121.486 Y121.336 E.0021
G1 X121.404 Y121.466 E.00458
G1 X121.181 Y121.494 E.00669
G3 X121.073 Y121.611 I-.113 J.004 E.00526
G3 X121.119 Y121.875 I-.419 J.21 E.00811
G1 X121.186 Y121.974 E.00355
G1 X121.125 Y122.356 E.01149
G1 X122.806 Y122.356 E.04999
G1 X122.898 Y122.38 E.00283
G1 X122.972 Y122.506 E.00435
G1 X123.706 Y122.506 E.02184
G1 X123.819 Y122.544 E.00355
G1 X123.875 Y122.656 E.00374
G1 X124.255 Y122.684 E.01134
G1 X124.323 Y122.806 E.00414
G1 X124.807 Y122.813 E.01441
G1 X124.906 Y122.881 E.00359
G1 X124.931 Y122.956 E.00234
G1 X125.145 Y122.978 E.00639
G1 X125.231 Y123.106 E.00458
G1 X125.42 Y123.117 E.00563
G3 X125.531 Y123.256 I-.043 J.149 E.00563
G1 X125.699 Y123.262 E.00499
G1 X125.734 Y123.387 E.00386
; WIPE_START
G1 F9558.438
G1 X125.699 Y123.262 E-.04929
G1 X125.531 Y123.256 E-.06379
G1 X125.506 Y123.181 E-.02988
G1 X125.42 Y123.117 E-.04084
G1 X125.231 Y123.106 E-.07189
G1 X125.145 Y122.978 E-.05855
G1 X124.931 Y122.956 E-.0816
G1 X124.906 Y122.881 E-.02988
G1 X124.807 Y122.813 E-.04582
G1 X124.323 Y122.806 E-.18406
G1 X124.255 Y122.684 E-.05286
G1 X124.12 Y122.674 E-.05155
; WIPE_END
G1 E-.04 F1800
G1 X123.444 Y120.031 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.19282
G1 F3156
G1 X123.106 Y120.031 E.00401
; WIPE_START
G1 F15000
G1 X123.444 Y120.031 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.631 Y121.906 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
G1 F3156
G1 X120.631 Y122.056 E.00178
; LINE_WIDTH: 0.217804
G1 X120.606 Y122.106 E.00077
; LINE_WIDTH: 0.26777
G1 X120.581 Y122.156 E.00099
; LINE_WIDTH: 0.317791
G1 X120.556 Y122.206 E.00122
; LINE_WIDTH: 0.3618
G1 X120.537 Y122.281 E.00196
; LINE_WIDTH: 0.400338
G1 X120.518 Y122.356 E.0022
G1 X120.426 Y122.374 E.00265
; LINE_WIDTH: 0.36291
G1 X120.256 Y122.214 E.0059
G1 X120.094 Y123.019 F36000
; LINE_WIDTH: 0.19282
G1 F3156
G1 X119.556 Y123.019 E.00637
; LINE_WIDTH: 0.217804
G1 X119.506 Y122.994 E.00077
; LINE_WIDTH: 0.26777
G1 X119.456 Y122.969 E.00099
; LINE_WIDTH: 0.317769
G1 X119.406 Y122.944 E.00121
; LINE_WIDTH: 0.34282
G1 X119.406 Y122.856 E.00209
; LINE_WIDTH: 0.317737
G1 X119.431 Y122.806 E.00121
; LINE_WIDTH: 0.26777
G1 X119.456 Y122.756 E.00099
; LINE_WIDTH: 0.1996
G1 X119.481 Y122.706 E.00069
G1 X119.481 Y122.556 E.00186
G1 X119.556 Y122.9 F36000
; LINE_WIDTH: 0.196815
G1 F3156
G1 X119.406 Y122.975 E.00204
; LINE_WIDTH: 0.139002
G1 X119.256 Y123.05 E.00127
G2 X119.15 Y123.094 I-.037 J.06 E.00102
G3 X119.106 Y123.2 I-.06 J.037 E.00102
G1 X118.956 Y123.2 E.00114
; WIPE_START
G1 F15000
G1 X119.106 Y123.2 E-.19335
G1 X119.142 Y123.192 E-.04795
G1 X119.15 Y123.094 E-.12732
G1 X119.158 Y123.058 E-.04795
G1 X119.256 Y123.05 E-.12732
G1 X119.406 Y122.975 E-.2161
; WIPE_END
G1 E-.04 F1800
G1 X125.507 Y127.561 Z1.2 F36000
G1 X126.41 Y128.24 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X127.61 Y128.24 E.03574
G1 X127.61 Y129.44 E.03574
G1 X128.39 Y129.44 E.02323
G1 X128.39 Y128.24 E.03574
G1 X129.59 Y128.24 E.03574
G1 X129.59 Y127.31 E.0277
G1 X128.39 Y127.31 E.03574
G1 X128.39 Y126.26 E.03128
G1 X127.61 Y126.26 E.02323
G1 X127.61 Y127.31 E.03128
G1 X126.41 Y127.31 E.03574
G1 X126.41 Y128.18 E.02591
M204 S10000
G1 X126.606 Y127.775 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.581948
G1 F3156
G1 X127.871 Y127.775 E.05385
; LINE_WIDTH: 0.64353
G1 X127.935 Y127.775 E.00307
; LINE_WIDTH: 0.685297
G1 X128 Y127.775 E.00328
G1 X128.065 Y127.775 E.00328
; LINE_WIDTH: 0.64353
G1 X128.129 Y127.775 E.00307
; LINE_WIDTH: 0.601764
G1 X128.194 Y127.775 E.00285
; LINE_WIDTH: 0.58088
G1 X129.394 Y127.775 E.05099
; WIPE_START
G1 F6691.948
G1 X128.194 Y127.775 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128 Y127.775 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.683239
G1 F3156
G1 X128 Y127.82 E.00227
; LINE_WIDTH: 0.637355
G1 X128 Y127.865 E.00211
; LINE_WIDTH: 0.591472
G1 X128 Y127.909 E.00194
; LINE_WIDTH: 0.545589
G1 X128 Y127.954 E.00178
; LINE_WIDTH: 0.499705
G1 X128 Y127.999 E.00162
; LINE_WIDTH: 0.431707
G1 X128 Y129.244 E.03823
; WIPE_START
G1 F9259.588
G1 X128 Y127.999 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X123.648 Y126.952 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3156
G1 X122.752 Y126.952 E.02881
G1 X122.752 Y127.102 E.00482
G1 X122.152 Y127.102 E.01929
G1 X122.152 Y127.252 E.00482
G1 X121.702 Y127.252 E.01447
G1 X121.702 Y127.402 E.00482
G1 X121.402 Y127.402 E.00965
G1 X121.402 Y127.552 E.00482
G1 X121.102 Y127.552 E.00965
G1 X121.102 Y127.702 E.00482
G1 X120.802 Y127.702 E.00965
G1 X120.802 Y127.852 E.00482
G1 X120.502 Y127.852 E.00965
G1 X120.502 Y128.002 E.00482
G1 X120.202 Y128.002 E.00965
G1 X120.202 Y128.152 E.00482
G1 X120.052 Y128.152 E.00482
G1 X120.052 Y128.302 E.00482
G1 X119.902 Y128.302 E.00482
G1 X119.902 Y128.452 E.00482
G1 X119.602 Y128.452 E.00965
G1 X119.602 Y128.602 E.00482
G1 X119.452 Y128.602 E.00482
G1 X119.452 Y128.752 E.00482
G1 X119.302 Y128.752 E.00482
G1 X119.302 Y129.052 E.00965
G1 X119.152 Y129.052 E.00482
G1 X119.152 Y129.202 E.00482
G1 X119.002 Y129.202 E.00482
G1 X119.002 Y129.352 E.00482
G1 X118.852 Y129.352 E.00482
G1 X118.852 Y129.652 E.00965
G1 X118.702 Y129.652 E.00482
G1 X118.702 Y129.952 E.00965
G1 X118.552 Y129.952 E.00482
M73 P92 R0
G1 X118.552 Y130.248 E.00951
G1 X118.702 Y130.248 E.00482
G1 X118.702 Y130.698 E.01447
G1 X118.852 Y130.698 E.00482
G1 X118.852 Y130.998 E.00965
G1 X119.002 Y130.998 E.00482
G1 X119.002 Y131.298 E.00965
G1 X119.152 Y131.298 E.00482
G1 X119.152 Y131.598 E.00965
G1 X119.302 Y131.598 E.00482
G1 X119.302 Y131.748 E.00482
G1 X119.452 Y131.748 E.00482
G1 X119.452 Y132.048 E.00965
G1 X119.602 Y132.048 E.00482
G1 X119.602 Y132.198 E.00482
G1 X119.752 Y132.198 E.00482
G1 X119.752 Y132.498 E.00965
G1 X119.902 Y132.498 E.00482
G1 X119.902 Y132.648 E.00482
G1 X120.052 Y132.648 E.00482
G1 X120.052 Y132.948 E.00965
G1 X120.202 Y132.948 E.00482
G1 X120.202 Y133.098 E.00482
G1 X120.352 Y133.098 E.00482
G1 X120.352 Y133.248 E.00482
G1 X120.502 Y133.248 E.00482
G1 X120.502 Y133.548 E.00965
G1 X120.652 Y133.548 E.00482
G1 X120.652 Y133.698 E.00482
G1 X120.948 Y133.698 E.00951
G1 X120.948 Y132.948 E.02412
G1 X121.098 Y132.948 E.00482
G1 X121.098 Y132.348 E.01929
G1 X121.248 Y132.348 E.00482
G1 X121.248 Y131.898 E.01447
G1 X121.398 Y131.898 E.00482
G1 X121.398 Y131.448 E.01447
G1 X121.548 Y131.448 E.00482
G1 X121.548 Y131.148 E.00965
G1 X121.698 Y131.148 E.00482
G1 X121.698 Y130.848 E.00965
G1 X121.848 Y130.848 E.00482
G1 X121.848 Y130.698 E.00482
G1 X121.998 Y130.698 E.00482
G1 X121.998 Y130.398 E.00965
G1 X122.148 Y130.398 E.00482
G1 X122.148 Y130.248 E.00482
G1 X122.298 Y130.248 E.00482
G1 X122.298 Y129.948 E.00965
G1 X122.448 Y129.948 E.00482
G1 X122.448 Y129.798 E.00482
G1 X122.598 Y129.798 E.00482
G1 X122.598 Y129.648 E.00482
G1 X122.748 Y129.648 E.00482
G1 X122.748 Y129.498 E.00482
G1 X122.898 Y129.498 E.00482
G1 X122.898 Y129.348 E.00482
G1 X123.048 Y129.348 E.00482
G1 X123.048 Y129.198 E.00482
G1 X123.198 Y129.198 E.00482
G1 X123.198 Y129.048 E.00482
G1 X123.348 Y129.048 E.00482
G1 X123.348 Y128.898 E.00482
G1 X123.498 Y128.898 E.00482
G1 X123.498 Y128.748 E.00482
G1 X123.648 Y128.748 E.00482
G1 X123.648 Y127.012 E.05582
M204 S250
G1 X124.19 Y126.74 F36000
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X124.19 Y126.41 E.00983
G1 X123.41 Y126.41 E.02323
G1 X123.41 Y126.56 E.00447
G1 X122.36 Y126.56 E.03128
G1 X122.36 Y126.71 E.00447
G1 X121.76 Y126.71 E.01787
G1 X121.76 Y126.86 E.00447
G1 X121.31 Y126.86 E.0134
G1 X121.31 Y127.01 E.00447
G1 X121.01 Y127.01 E.00894
G1 X121.01 Y127.16 E.00447
G1 X120.71 Y127.16 E.00894
G1 X120.71 Y127.31 E.00447
G1 X120.41 Y127.31 E.00894
G1 X120.41 Y127.46 E.00447
G1 X120.11 Y127.46 E.00894
G1 X120.11 Y127.61 E.00447
G1 X119.81 Y127.61 E.00894
G1 X119.81 Y127.76 E.00447
G1 X119.66 Y127.76 E.00447
G1 X119.66 Y127.91 E.00447
G1 X119.51 Y127.91 E.00447
G1 X119.51 Y128.06 E.00447
G1 X119.21 Y128.06 E.00894
G1 X119.21 Y128.21 E.00447
G1 X119.06 Y128.21 E.00447
G1 X119.06 Y128.36 E.00447
G1 X118.91 Y128.36 E.00447
G1 X118.91 Y128.66 E.00894
G1 X118.76 Y128.66 E.00447
G1 X118.76 Y128.81 E.00447
G1 X118.61 Y128.81 E.00447
G1 X118.61 Y128.96 E.00447
G1 X118.46 Y128.96 E.00447
G1 X118.46 Y129.26 E.00894
G1 X118.31 Y129.26 E.00447
G1 X118.31 Y129.56 E.00894
G1 X118.16 Y129.56 E.00447
G1 X118.16 Y130.64 E.03217
G1 X118.31 Y130.64 E.00447
G1 X118.31 Y131.09 E.0134
G1 X118.46 Y131.09 E.00447
G1 X118.46 Y131.39 E.00894
G1 X118.61 Y131.39 E.00447
G1 X118.61 Y131.69 E.00894
G1 X118.76 Y131.69 E.00447
G1 X118.76 Y131.99 E.00894
G1 X118.91 Y131.99 E.00447
G1 X118.91 Y132.14 E.00447
G1 X119.06 Y132.14 E.00447
G1 X119.06 Y132.44 E.00894
G1 X119.21 Y132.44 E.00447
G1 X119.21 Y132.59 E.00447
G1 X119.36 Y132.59 E.00447
G1 X119.36 Y132.89 E.00894
G1 X119.51 Y132.89 E.00447
G1 X119.51 Y133.04 E.00447
G1 X119.66 Y133.04 E.00447
G1 X119.66 Y133.34 E.00894
G1 X119.81 Y133.34 E.00447
G1 X119.81 Y133.49 E.00447
G1 X119.96 Y133.49 E.00447
G1 X119.96 Y133.64 E.00447
G1 X120.11 Y133.64 E.00447
G1 X120.11 Y133.94 E.00894
G1 X120.26 Y133.94 E.00447
G1 X120.26 Y134.09 E.00447
G1 X120.41 Y134.09 E.00447
G1 X120.41 Y134.24 E.00447
G1 X120.56 Y134.24 E.00447
G1 X120.56 Y134.39 E.00447
G1 X120.71 Y134.39 E.00447
G1 X120.71 Y134.54 E.00447
G1 X120.86 Y134.54 E.00447
G1 X120.86 Y134.69 E.00447
G1 X121.01 Y134.69 E.00447
G1 X121.01 Y134.99 E.00894
G1 X121.16 Y134.99 E.00447
G1 X121.16 Y135.14 E.00447
G1 X121.31 Y135.14 E.00447
G1 X121.31 Y135.29 E.00447
G1 X121.34 Y135.29 E.00089
G1 X121.34 Y133.34 E.05808
G1 X121.49 Y133.34 E.00447
G1 X121.49 Y132.74 E.01787
G1 X121.64 Y132.74 E.00447
G1 X121.64 Y132.29 E.0134
G1 X121.79 Y132.29 E.00447
G1 X121.79 Y131.84 E.0134
G1 X121.94 Y131.84 E.00447
G1 X121.94 Y131.54 E.00894
G1 X122.09 Y131.54 E.00447
G1 X122.09 Y131.24 E.00894
G1 X122.24 Y131.24 E.00447
G1 X122.24 Y131.09 E.00447
G1 X122.39 Y131.09 E.00447
G1 X122.39 Y130.79 E.00894
G1 X122.54 Y130.79 E.00447
G1 X122.54 Y130.64 E.00447
G1 X122.69 Y130.64 E.00447
G1 X122.69 Y130.34 E.00894
G1 X122.84 Y130.34 E.00447
G1 X122.84 Y130.19 E.00447
G1 X122.99 Y130.19 E.00447
G1 X122.99 Y130.04 E.00447
G1 X123.14 Y130.04 E.00447
G1 X123.14 Y129.89 E.00447
G1 X123.29 Y129.89 E.00447
G1 X123.29 Y129.74 E.00447
G1 X123.44 Y129.74 E.00447
G1 X123.44 Y129.59 E.00447
G1 X123.59 Y129.59 E.00447
G1 X123.59 Y129.44 E.00447
G1 X123.74 Y129.44 E.00447
G1 X123.74 Y129.29 E.00447
G1 X123.89 Y129.29 E.00447
G1 X123.89 Y129.14 E.00447
G1 X124.04 Y129.14 E.00447
G1 X124.04 Y128.99 E.00447
G1 X124.19 Y128.99 E.00447
G1 X124.19 Y128.66 E.00983
G1 X124.04 Y128.66 E.00447
G1 X124.04 Y126.74 E.05719
G1 X124.13 Y126.74 E.00268
M204 S10000
G1 X123.444 Y127.231 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.19282
G1 F3156
G1 X122.956 Y127.231 E.00579
; WIPE_START
G1 F15000
G1 X123.444 Y127.231 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X121.558 Y128.879 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.496035
G1 F3156
G1 X121.292 Y128.989 E.0103
; LINE_WIDTH: 0.467102
G1 X121.026 Y129.098 E.00964
G1 X120.544 Y129.544 E.02198
; LINE_WIDTH: 0.506048
G1 X120.433 Y129.61 E.00473
G1 X120.264 Y129.959 E.01419
G1 X120.264 Y130.708 E.02737
G1 X120.312 Y130.815 E.0043
G3 X120.792 Y129.942 I14.89 J7.627 E.03644
; LINE_WIDTH: 0.498568
G1 X120.958 Y129.733 E.00961
; LINE_WIDTH: 0.459285
G2 X121.479 Y128.984 I-4.099 J-3.411 E.03004
; LINE_WIDTH: 0.503925
G1 X121.522 Y128.927 E.00259
G1 X121.558 Y128.879 F36000
; LINE_WIDTH: 0.49948
G1 F3156
G1 X121.616 Y128.839 E.00256
; LINE_WIDTH: 0.46312
G1 X121.674 Y128.798 E.00235
; WIPE_START
G1 F8567.35
G1 X121.616 Y128.839 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X122.832 Y128.143 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.51607
G1 F3156
G2 X122.285 Y128.064 I-.7 J2.921 E.02069
G3 X121.775 Y128.338 I-.874 J-1.016 E.0218
; LINE_WIDTH: 0.481225
G1 X121.517 Y128.449 E.00973
; LINE_WIDTH: 0.421886
G2 X120.797 Y128.763 I61.572 J142.601 E.02352
G1 X120.356 Y129.163 E.01782
G1 X120.123 Y129.273 E.00772
G1 X119.966 Y129.584 E.01042
G1 X119.846 Y129.697 E.00495
G3 X119.845 Y130.81 I-36.686 J.502 E.03331
G1 X119.973 Y131.077 E.00887
G1 X120.103 Y131.198 E.0053
G2 X120.475 Y131.759 I1.662 J-.697 E.02028
G1 X120.535 Y131.448 E.00949
G1 X120.629 Y131.337 E.00435
G1 X120.65 Y131.091 E.00738
G3 X121.105 Y130.235 I6.419 J2.858 E.02905
G1 X121.238 Y130.09 E.0059
G1 X121.345 Y129.851 E.00782
G2 X121.672 Y129.368 I-.658 J-.798 E.01771
G1 X122.017 Y129 E.01512
; LINE_WIDTH: 0.477628
G1 X122.183 Y128.803 E.00883
; LINE_WIDTH: 0.524704
G1 X122.349 Y128.607 E.00979
G1 X122.794 Y128.189 E.0232
G1 X123.256 Y128.143 F36000
; LINE_WIDTH: 0.419862
G1 F3156
G1 X123.256 Y127.719 E.01262
G1 X122.752 Y127.719 E.015
G1 X122.64 Y127.682 E.00352
G1 X122.538 Y127.504 E.00611
G1 X122.405 Y127.638 E.00562
G1 X122.075 Y127.644 E.00983
G1 X121.997 Y127.77 E.00441
G1 X121.781 Y127.794 E.00647
G1 X121.699 Y127.919 E.00446
G1 X121.481 Y127.944 E.00652
G1 X121.401 Y128.068 E.00441
G1 X121.181 Y128.094 E.00658
G1 X121.111 Y128.212 E.0041
G1 X120.881 Y128.244 E.00689
G1 X120.816 Y128.358 E.00392
G1 X120.581 Y128.394 E.00707
G1 X120.507 Y128.515 E.00422
G1 X120.435 Y128.535 E.00221
G1 X120.365 Y128.659 E.00425
G1 X120.285 Y128.685 E.00249
G1 X120.221 Y128.804 E.00403
G3 X119.981 Y128.844 I-.178 J-.33 E.00738
G1 X119.907 Y128.965 E.00422
G1 X119.835 Y128.985 E.00221
G1 X119.769 Y129.106 E.00411
G1 X119.694 Y129.131 E.00234
G1 X119.659 Y129.365 E.00704
G1 X119.42 Y129.56 E.00919
G1 X119.469 Y129.664 E.00344
G1 X119.469 Y130.7 E.03083
G1 X119.394 Y130.913 E.00674
G1 X119.53 Y131.024 E.00522
G1 X119.544 Y131.219 E.00582
G1 X119.665 Y131.293 E.00422
G1 X119.685 Y131.365 E.00221
G1 X119.805 Y131.429 E.00403
G3 X119.844 Y131.669 I-.331 J.178 E.00737
G1 X119.968 Y131.749 E.0044
G1 X119.986 Y131.814 E.00201
G1 X120.118 Y131.898 E.00465
G1 X120.144 Y132.119 E.00662
G1 X120.267 Y132.199 E.00437
G1 X120.285 Y132.265 E.00204
G1 X120.372 Y132.304 E.00284
; LINE_WIDTH: 0.374632
G1 X120.415 Y132.587 E.0075
G1 X120.49 Y132.609 E.00204
G2 X120.65 Y132.894 I.613 J-.156 E.00867
G3 X120.66 Y132.609 I.271 J-.134 E.00779
G1 X120.735 Y132.587 E.00204
; LINE_WIDTH: 0.376745
G1 X120.729 Y132.326 E.00689
; LINE_WIDTH: 0.419285
G1 X120.723 Y132.065 E.00777
G1 X120.856 Y131.973 E.0048
G1 X120.875 Y131.612 E.01073
G1 X121.006 Y131.525 E.00468
G1 X121.034 Y131.145 E.01134
G1 X121.156 Y131.069 E.00426
G1 X121.19 Y130.836 E.00699
G1 X121.306 Y130.769 E.00398
G1 X121.339 Y130.538 E.00693
G1 X121.606 Y130.319 E.01027
G1 X121.635 Y130.093 E.00677
G1 X121.906 Y129.869 E.01044
G1 X121.924 Y129.663 E.00614
G3 X122.065 Y129.565 I.148 J.063 E.00537
G1 X122.139 Y129.438 E.00438
G1 X122.215 Y129.415 E.00235
G1 X122.29 Y129.287 E.00441
G1 X122.365 Y129.265 E.00231
G1 X122.441 Y129.136 E.00444
G1 X122.515 Y129.115 E.00227
G1 X122.592 Y128.986 E.00447
G1 X122.665 Y128.965 E.00224
G1 X122.744 Y128.835 E.00451
G1 X122.815 Y128.815 E.00219
G1 X122.898 Y128.683 E.00463
G1 X122.964 Y128.664 E.00205
G1 X123.035 Y128.541 E.00423
G2 X123.152 Y128.421 I.006 J-.112 E.00564
G1 X123.256 Y128.373 E.00339
G1 X123.256 Y128.203 E.00507
; WIPE_START
G1 F9565.189
G1 X123.256 Y128.373 E-.06481
G1 X123.152 Y128.421 E-.04336
G1 X123.114 Y128.514 E-.03822
G1 X123.035 Y128.541 E-.03167
G1 X122.964 Y128.664 E-.05403
G1 X122.898 Y128.683 E-.02626
G1 X122.815 Y128.815 E-.05924
G1 X122.744 Y128.835 E-.028
G1 X122.665 Y128.965 E-.05771
G1 X122.592 Y128.986 E-.02865
G1 X122.515 Y129.115 E-.05714
G1 X122.441 Y129.136 E-.02906
G1 X122.365 Y129.265 E-.05679
G1 X122.29 Y129.287 E-.02956
G1 X122.215 Y129.415 E-.05634
G1 X122.139 Y129.438 E-.03003
G1 X122.065 Y129.565 E-.05593
G1 X122.032 Y129.575 E-.01321
; WIPE_END
G1 E-.04 F1800
G1 X118.981 Y129.856 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.19282
G1 F3156
G1 X118.981 Y130.494 E.00756
; WIPE_START
G1 F15000
G1 X118.981 Y129.856 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.606 Y133.969 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.1996
G1 F3156
G1 X120.756 Y133.969 E.00186
G1 X120.806 Y133.994 E.00069
; LINE_WIDTH: 0.26777
G1 X120.856 Y134.019 E.00099
; LINE_WIDTH: 0.317737
G1 X120.906 Y134.044 E.00121
; LINE_WIDTH: 0.347906
G1 X120.984 Y134.054 E.00189
G1 X121.004 Y134.124 E.00176
; LINE_WIDTH: 0.301405
G1 X121.025 Y134.194 E.00149
; LINE_WIDTH: 0.274434
G2 X121.041 Y134.241 I.031 J.016 E.001
; LINE_WIDTH: 0.234315
G1 X121.056 Y134.256 E.00033
; LINE_WIDTH: 0.196815
G1 X121.078 Y134.3 E.0006
; LINE_WIDTH: 0.152845
G1 X121.1 Y134.344 E.00043
; LINE_WIDTH: 0.13086
G1 X121.1 Y134.494 E.00104
; WIPE_START
G1 F15000
G1 X121.1 Y134.344 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.752 Y132.052 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Inner wall
; LINE_WIDTH: 0.45
G1 F3156
G1 X125.752 Y132.352 E.00965
G1 X125.602 Y132.352 E.00482
G1 X125.602 Y133.248 E.02881
G1 X125.752 Y133.248 E.00482
G1 X125.752 Y133.998 E.02412
G1 X125.902 Y133.998 E.00482
G1 X125.902 Y134.448 E.01447
G1 X126.052 Y134.448 E.00482
G1 X126.052 Y134.898 E.01447
G1 X126.202 Y134.898 E.00482
G1 X126.202 Y135.198 E.00965
G1 X126.352 Y135.198 E.00482
G1 X126.352 Y135.498 E.00965
G1 X126.502 Y135.498 E.00482
G1 X126.502 Y135.798 E.00965
G1 X126.652 Y135.798 E.00482
G1 X126.652 Y136.098 E.00965
G1 X126.802 Y136.098 E.00482
G1 X126.802 Y136.248 E.00482
G1 X126.952 Y136.248 E.00482
G1 X126.952 Y136.398 E.00482
G1 X127.102 Y136.398 E.00482
G1 X127.102 Y136.698 E.00965
G1 X127.252 Y136.698 E.00482
G1 X127.252 Y136.848 E.00482
G1 X127.552 Y136.848 E.00965
G1 X127.552 Y136.998 E.00482
G1 X127.702 Y136.998 E.00482
G1 X127.702 Y137.148 E.00482
G1 X128.002 Y137.148 E.00965
G1 X128.002 Y137.298 E.00482
G1 X128.152 Y137.298 E.00482
G1 X128.152 Y137.448 E.00482
G1 X128.452 Y137.448 E.00965
G1 X128.452 Y137.598 E.00482
G1 X129.648 Y137.598 E.03845
G1 X129.648 Y137.448 E.00482
G1 X130.248 Y137.448 E.01929
G1 X130.248 Y137.298 E.00482
G1 X130.698 Y137.298 E.01447
G1 X130.698 Y137.148 E.00482
G1 X131.148 Y137.148 E.01447
G1 X131.148 Y136.998 E.00482
G1 X131.598 Y136.998 E.01447
G1 X131.598 Y136.848 E.00482
G1 X131.898 Y136.848 E.00965
G1 X131.898 Y136.698 E.00482
G1 X132.198 Y136.698 E.00965
G1 X132.198 Y136.548 E.00482
G1 X132.498 Y136.548 E.00965
G1 X132.498 Y136.252 E.00951
G1 X132.198 Y136.252 E.00965
G1 X132.198 Y136.102 E.00482
G1 X131.898 Y136.102 E.00965
G1 X131.898 Y135.952 E.00482
G1 X131.448 Y135.952 E.01447
G1 X131.448 Y135.802 E.00482
G1 X131.298 Y135.802 E.00482
G1 X131.298 Y135.652 E.00482
G1 X130.998 Y135.652 E.00965
G1 X130.998 Y135.502 E.00482
G1 X130.848 Y135.502 E.00482
G1 X130.848 Y135.352 E.00482
G1 X130.548 Y135.352 E.00965
G1 X130.548 Y135.202 E.00482
G1 X130.398 Y135.202 E.00482
G1 X130.398 Y135.052 E.00482
G1 X130.248 Y135.052 E.00482
G1 X130.248 Y134.902 E.00482
G1 X130.098 Y134.902 E.00482
G1 X130.098 Y134.752 E.00482
G1 X129.948 Y134.752 E.00482
G1 X129.948 Y134.602 E.00482
G1 X129.798 Y134.602 E.00482
G1 X129.798 Y134.452 E.00482
G1 X129.648 Y134.452 E.00482
G1 X129.648 Y134.302 E.00482
G1 X129.498 Y134.302 E.00482
G1 X129.498 Y134.152 E.00482
G1 X129.348 Y134.152 E.00482
G1 X129.348 Y133.852 E.00965
G1 X129.198 Y133.852 E.00482
G1 X129.198 Y133.702 E.00482
G1 X129.048 Y133.702 E.00482
G1 X129.048 Y133.402 E.00965
G1 X128.898 Y133.402 E.00482
G1 X128.898 Y133.102 E.00965
G1 X128.748 Y133.102 E.00482
G1 X128.748 Y132.952 E.00482
G1 X128.598 Y132.952 E.00482
G1 X128.598 Y132.652 E.00965
G1 X128.448 Y132.652 E.00482
G1 X128.448 Y132.202 E.01447
G1 X126.348 Y132.202 E.06753
G1 X126.348 Y132.052 E.00482
G1 X125.812 Y132.052 E.01723
; WIPE_START
G1 F8843.478
G1 X125.752 Y132.352 E-.11626
G1 X125.602 Y132.352 E-.057
G1 X125.602 Y133.248 E-.34043
G1 X125.752 Y133.248 E-.057
G1 X125.752 Y133.746 E-.18931
; WIPE_END
G1 E-.04 F1800
G1 X125.51 Y131.06 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X125.51 Y131.36 E.00894
G1 X125.36 Y131.36 E.00447
G1 X125.36 Y131.96 E.01787
G1 X125.21 Y131.96 E.00447
G1 X125.21 Y133.64 E.05004
G1 X125.36 Y133.64 E.00447
G1 X125.36 Y134.39 E.02234
G1 X125.51 Y134.39 E.00447
G1 X125.51 Y134.84 E.0134
G1 X125.66 Y134.84 E.00447
G1 X125.66 Y135.29 E.0134
G1 X125.81 Y135.29 E.00447
G1 X125.81 Y135.59 E.00894
G1 X125.96 Y135.59 E.00447
G1 X125.96 Y135.89 E.00894
G1 X126.11 Y135.89 E.00447
G1 X126.11 Y136.19 E.00894
G1 X126.26 Y136.19 E.00447
G1 X126.26 Y136.49 E.00894
G1 X126.41 Y136.49 E.00447
G1 X126.41 Y136.64 E.00447
G1 X126.56 Y136.64 E.00447
G1 X126.56 Y136.79 E.00447
G1 X126.71 Y136.79 E.00447
G1 X126.71 Y137.09 E.00894
G1 X126.86 Y137.09 E.00447
G1 X126.86 Y137.24 E.00447
G1 X127.16 Y137.24 E.00894
G1 X127.16 Y137.39 E.00447
G1 X127.31 Y137.39 E.00447
G1 X127.31 Y137.54 E.00447
G1 X127.61 Y137.54 E.00894
G1 X127.61 Y137.69 E.00447
G1 X127.76 Y137.69 E.00447
G1 X127.76 Y137.84 E.00447
G1 X128.06 Y137.84 E.00894
G1 X128.06 Y137.99 E.00447
G1 X128.81 Y137.99 E.02234
G1 X128.81 Y138.14 E.00447
G1 X128.84 Y138.14 E.00089
G1 X128.84 Y137.99 E.00447
G1 X130.04 Y137.99 E.03574
G1 X130.04 Y137.84 E.00447
G1 X130.64 Y137.84 E.01787
G1 X130.64 Y137.69 E.00447
G1 X131.09 Y137.69 E.0134
G1 X131.09 Y137.54 E.00447
G1 X131.54 Y137.54 E.0134
G1 X131.54 Y137.39 E.00447
G1 X131.99 Y137.39 E.0134
G1 X131.99 Y137.24 E.00447
G1 X132.29 Y137.24 E.00894
G1 X132.29 Y137.09 E.00447
G1 X132.59 Y137.09 E.00894
G1 X132.59 Y136.94 E.00447
G1 X132.89 Y136.94 E.00894
G1 X132.89 Y136.79 E.00447
G1 X133.19 Y136.79 E.00894
G1 X133.19 Y136.64 E.00447
G1 X133.49 Y136.64 E.00894
G1 X133.49 Y136.49 E.00447
G1 X133.64 Y136.49 E.00447
G1 X133.64 Y136.34 E.00447
G1 X133.94 Y136.34 E.00894
G1 X133.94 Y136.19 E.00447
G1 X134.09 Y136.19 E.00447
G1 X134.09 Y136.04 E.00447
G1 X134.24 Y136.04 E.00447
G1 X134.24 Y136.01 E.00089
G1 X133.19 Y136.01 E.03128
G1 X133.19 Y135.86 E.00447
G1 X132.59 Y135.86 E.01787
G1 X132.59 Y135.71 E.00447
G1 X132.29 Y135.71 E.00894
G1 X132.29 Y135.56 E.00447
G1 X131.84 Y135.56 E.0134
G1 X131.84 Y135.41 E.00447
G1 X131.69 Y135.41 E.00447
G1 X131.69 Y135.26 E.00447
G1 X131.39 Y135.26 E.00894
G1 X131.39 Y135.11 E.00447
G1 X131.24 Y135.11 E.00447
G1 X131.24 Y134.96 E.00447
G1 X130.94 Y134.96 E.00894
G1 X130.94 Y134.81 E.00447
G1 X130.79 Y134.81 E.00447
G1 X130.79 Y134.66 E.00447
G1 X130.64 Y134.66 E.00447
G1 X130.64 Y134.51 E.00447
G1 X130.49 Y134.51 E.00447
G1 X130.49 Y134.36 E.00447
G1 X130.34 Y134.36 E.00447
G1 X130.34 Y134.21 E.00447
G1 X130.19 Y134.21 E.00447
G1 X130.19 Y134.06 E.00447
G1 X130.04 Y134.06 E.00447
G1 X130.04 Y133.91 E.00447
G1 X129.89 Y133.91 E.00447
G1 X129.89 Y133.76 E.00447
G1 X129.74 Y133.76 E.00447
G1 X129.74 Y133.46 E.00894
G1 X129.59 Y133.46 E.00447
G1 X129.59 Y133.31 E.00447
G1 X129.44 Y133.31 E.00447
G1 X129.44 Y133.01 E.00894
G1 X129.29 Y133.01 E.00447
G1 X129.29 Y132.71 E.00894
G1 X129.14 Y132.71 E.00447
G1 X129.14 Y132.56 E.00447
G1 X128.99 Y132.56 E.00447
G1 X128.99 Y132.26 E.00894
G1 X128.84 Y132.26 E.00447
G1 X128.84 Y131.81 E.0134
G1 X128.69 Y131.81 E.00447
G1 X128.69 Y131.66 E.00447
G1 X128.66 Y131.66 E.00089
G1 X128.66 Y131.81 E.00447
G1 X126.74 Y131.81 E.05719
G1 X126.74 Y131.66 E.00447
G1 X126.29 Y131.66 E.0134
G1 X126.29 Y131.51 E.00447
G1 X125.99 Y131.51 E.00894
G1 X125.99 Y131.36 E.00447
G1 X125.84 Y131.36 E.00447
G1 X125.84 Y131.21 E.00447
G1 X125.54 Y131.21 E.00894
G1 X125.54 Y131.09 E.00357
M204 S10000
G1 X125.675 Y131.556 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.276054
G1 F3156
G2 X125.677 Y131.735 I1.468 J.075 E.0033
G1 X125.735 Y131.758 E.00116
; LINE_WIDTH: 0.215726
G1 X125.794 Y131.781 E.00086
; LINE_WIDTH: 0.19282
G1 X126.094 Y131.781 E.00355
G1 X125.881 Y132.556 F36000
G1 F3156
G1 X125.881 Y133.044 E.00579
; WIPE_START
G1 F15000
G1 X125.881 Y132.556 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.352 Y136.402 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Internal solid infill
; LINE_WIDTH: 0.516375
G1 F3156
G1 X131.474 Y136.401 E.00456
; LINE_WIDTH: 0.478245
G1 X131.596 Y136.401 E.0042
; LINE_WIDTH: 0.440115
M73 P93 R0
G1 X131.718 Y136.401 E.00383
; LINE_WIDTH: 0.401985
G1 X131.84 Y136.4 E.00346
; WIPE_START
G1 F10026.041
G1 X131.718 Y136.401 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.436 Y133.383 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; LINE_WIDTH: 0.48946
G1 F3156
G1 X127.139 Y133.383 E.01049
G1 X127.079 Y133.72 E.01207
; LINE_WIDTH: 0.506798
G1 X127.169 Y133.915 E.00786
; LINE_WIDTH: 0.554936
G2 X127.505 Y134.641 I219.443 J-101.183 E.03236
; LINE_WIDTH: 0.587305
G1 X127.801 Y135.185 E.02664
G1 X127.972 Y135.41 E.01215
G1 X128.422 Y135.86 E.02737
; LINE_WIDTH: 0.579425
G1 X128.663 Y136.044 E.01287
; LINE_WIDTH: 0.542041
G2 X129.05 Y136.326 I2.788 J-3.412 E.01888
G3 X129.587 Y136.207 I.9 J2.777 E.02171
G1 X129.125 Y135.755 E.02546
; LINE_WIDTH: 0.56306
G1 X128.89 Y135.541 E.01306
; LINE_WIDTH: 0.592827
G3 X128.3 Y134.949 I3.191 J-3.766 E.03638
G1 X127.983 Y134.441 E.02598
; LINE_WIDTH: 0.56146
G1 X127.754 Y133.98 E.02111
; LINE_WIDTH: 0.541473
G1 X127.618 Y133.743 E.01075
; LINE_WIDTH: 0.50321
G3 X127.457 Y133.439 I.836 J-.638 E.01255
G1 X127.716 Y132.971 F36000
; LINE_WIDTH: 0.41999
G1 F3156
G1 X126.746 Y132.971 E.02888
G1 X126.711 Y133.444 E.01412
G1 X126.611 Y133.585 E.00517
G3 X126.671 Y133.887 I-.383 J.234 E.00934
G1 X126.78 Y134.033 E.00543
G1 X126.858 Y134.355 E.00988
G2 X127.503 Y135.598 I30.324 J-14.942 E.04171
G1 X127.79 Y135.902 E.01247
G1 X127.859 Y136.091 E.00598
G1 X128.122 Y136.213 E.00863
G2 X128.532 Y136.483 I.575 J-.429 E.01493
G2 X129.031 Y136.822 I.841 J-.701 E.01821
G1 X129.385 Y136.682 E.01133
G1 X129.714 Y136.679 E.00979
G1 X129.771 Y136.599 E.00292
G1 X130.044 Y136.529 E.00841
G1 X130.137 Y136.529 E.00275
G1 X130.276 Y136.423 E.00523
G1 X130.559 Y136.375 E.00855
G1 X130.212 Y136.106 E.01307
G1 X129.99 Y135.996 E.00739
G2 X128.897 Y134.908 I-79.019 J78.261 E.04594
G1 X128.623 Y134.576 E.01281
G2 X128.357 Y134.192 I-.731 J.223 E.01414
G1 X128.138 Y133.71 E.01577
G1 X127.866 Y133.358 E.01324
G1 X127.738 Y133.027 E.01059
G1 X128.056 Y132.594 F36000
; LINE_WIDTH: 0.420716
G1 F3156
G1 X126.369 Y132.594 E.05034
G1 X126.369 Y133.248 E.01951
G1 X126.34 Y133.349 E.00314
G1 X126.181 Y133.436 E.00542
G1 X126.144 Y133.436 E.00109
G1 X126.144 Y133.616 E.00536
G1 X126.199 Y133.631 E.00169
G1 X126.294 Y133.794 E.00565
G1 X126.294 Y134.075 E.00838
G1 X126.43 Y134.174 E.00502
G1 X126.444 Y134.525 E.01049
G1 X126.582 Y134.629 E.00515
G1 X126.594 Y134.819 E.00569
G1 X126.716 Y134.895 E.00428
G1 X126.744 Y135.119 E.00673
G1 X126.872 Y135.206 E.00462
G1 X126.894 Y135.419 E.00639
G1 X127.012 Y135.489 E.0041
G1 X127.044 Y135.719 E.00692
G1 X127.165 Y135.793 E.00423
G1 X127.185 Y135.865 E.00222
G1 X127.307 Y135.932 E.00416
G1 X127.335 Y136.015 E.00261
G1 X127.467 Y136.097 E.00465
G1 X127.494 Y136.319 E.00666
G1 X127.606 Y136.381 E.00384
G1 X127.631 Y136.456 E.00235
G1 X127.853 Y136.483 E.00666
G1 X128.081 Y136.756 E.01062
G1 X128.315 Y136.791 E.00704
G1 X128.531 Y137.056 E.01022
G1 X128.742 Y137.077 E.00633
G1 X128.827 Y137.206 E.0046
G1 X129.273 Y137.206 E.01332
G1 X129.358 Y137.077 E.0046
G1 X129.878 Y137.056 E.01553
G1 X129.99 Y136.914 E.0054
G1 X130.325 Y136.906 E.01
G1 X130.422 Y136.77 E.00496
G1 X130.773 Y136.756 E.01049
G1 X130.865 Y136.623 E.00482
G1 X131.202 Y136.583 E.01011
; LINE_WIDTH: 0.484535
G1 X131.265 Y136.454 E.00504
; LINE_WIDTH: 0.506914
G1 X131.352 Y136.402 E.0037
G1 X131.163 Y136.351 E.00717
; LINE_WIDTH: 0.421655
G1 X130.919 Y136.044 E.01173
G1 X130.698 Y136.018 E.00666
G1 X130.469 Y135.744 E.01067
G1 X130.27 Y135.729 E.00597
G3 X130.165 Y135.585 I.057 J-.152 E.00564
G1 X130.04 Y135.514 E.00429
G1 X130.015 Y135.435 E.00249
G1 X129.892 Y135.366 E.00422
G1 X129.865 Y135.285 E.00257
G1 X129.742 Y135.217 E.00421
G1 X129.715 Y135.135 E.00258
G1 X129.592 Y135.067 E.00419
G1 X129.565 Y134.985 E.0026
G1 X129.443 Y134.918 E.00418
G1 X129.415 Y134.835 E.00261
G1 X129.293 Y134.768 E.00417
G1 X129.265 Y134.685 E.00262
G1 X129.143 Y134.618 E.00418
G1 X129.115 Y134.535 E.00261
G1 X128.987 Y134.459 E.00445
G1 X128.956 Y134.231 E.00689
G1 X128.835 Y134.157 E.00424
G1 X128.815 Y134.085 E.00222
G1 X128.682 Y134.001 E.0047
G1 X128.656 Y133.781 E.00662
G1 X128.532 Y133.701 E.00442
G1 X128.506 Y133.481 E.00662
G1 X128.385 Y133.407 E.00424
G1 X128.365 Y133.335 E.00222
G1 X128.234 Y133.255 E.00457
G1 X128.206 Y133.031 E.00676
G1 X128.091 Y132.965 E.00397
G1 X128.062 Y132.654 E.00936
; WIPE_START
G1 F9505.332
G1 X128.091 Y132.965 E-.11884
G1 X128.206 Y133.031 E-.05036
G1 X128.234 Y133.255 E-.08587
G1 X128.365 Y133.335 E-.05803
G1 X128.385 Y133.407 E-.02825
G1 X128.506 Y133.481 E-.05384
G1 X128.532 Y133.701 E-.08412
G1 X128.656 Y133.781 E-.05612
G1 X128.682 Y134.001 E-.08412
G1 X128.815 Y134.085 E-.05975
G1 X128.835 Y134.157 E-.02825
G1 X128.953 Y134.229 E-.05246
; WIPE_END
G1 E-.04 F1800
G1 X132.91 Y136.325 Z1.2 F36000
G1 Z.8
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.335436
G1 F3156
G1 X132.952 Y136.325 E.00097
; LINE_WIDTH: 0.299052
G1 X132.994 Y136.325 E.00085
; LINE_WIDTH: 0.279183
G1 X133.175 Y136.325 E.00338
G1 X133.191 Y136.309 E.00041
; LINE_WIDTH: 0.234315
G1 X133.206 Y136.294 E.00033
; LINE_WIDTH: 0.196815
G1 X133.25 Y136.272 E.0006
; LINE_WIDTH: 0.152845
G1 X133.294 Y136.25 E.00043
; LINE_WIDTH: 0.13086
G1 X133.444 Y136.25 E.00104
G1 X132.91 Y136.325 F36000
; LINE_WIDTH: 0.355849
G1 F3156
G1 X132.868 Y136.325 E.00104
G2 X132.844 Y136.594 I.666 J.194 E.00672
; WIPE_START
G1 F11504.229
G1 X132.844 Y136.444 E-.36375
G1 X132.868 Y136.325 E-.29413
G1 X132.91 Y136.325 E-.10212
; WIPE_END
G1 E-.04 F1800
G1 X125.535 Y138.293 Z1.2 F36000
G1 X123.86 Y138.74 Z1.2
G1 Z.8
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3156
M204 S6000
G1 X124.19 Y138.74 E.00983
G1 X124.19 Y138.71 E.00089
G1 X123.89 Y138.71 E.00894
M204 S250
G1 X124.49 Y138.86 F36000
G1 F3156
M204 S6000
G1 X124.31 Y138.86 E.00536
G1 X124.31 Y138.89 E.00089
G1 X124.46 Y138.89 E.00447
M204 S250
G1 X124.94 Y139.01 F36000
G1 F3156
M204 S6000
G1 X124.76 Y139.01 E.00536
G1 X124.76 Y139.04 E.00089
G1 X124.91 Y139.04 E.00447
M204 S250
G1 X125.54 Y139.16 F36000
G1 F3156
M204 S6000
G1 X125.51 Y139.16 E.00089
G1 X125.51 Y139.19 E.00089
; WIPE_START
G1 F9547.055
M204 S10000
G1 X125.51 Y139.16 E-.37987
G1 X125.51 Y139.19 E-.37987
G1 X125.51 Y139.19 E-.00025
; WIPE_END
G1 E-.04 F1800
G1 X120.169 Y133.737 Z1.2 F36000
G1 X115.49 Y128.96 Z1.2
G1 Z.8
G1 E.8 F1800
G1 F3156
M204 S6000
G1 X115.46 Y128.96 E.00089
G1 X115.46 Y129.59 E.01877
G1 X115.61 Y129.59 E.00447
G1 X115.61 Y130.34 E.02234
G1 X115.76 Y130.34 E.00447
G1 X115.76 Y130.79 E.0134
G1 X115.91 Y130.79 E.00447
G1 X115.91 Y131.24 E.0134
G1 X116.06 Y131.24 E.00447
G1 X116.06 Y131.69 E.0134
G1 X116.21 Y131.69 E.00447
G1 X116.21 Y131.99 E.00894
G1 X116.36 Y131.99 E.00447
G1 X116.36 Y132.29 E.00894
G1 X116.51 Y132.29 E.00447
G1 X116.51 Y132.59 E.00894
G1 X116.66 Y132.59 E.00447
G1 X116.66 Y132.89 E.00894
G1 X116.81 Y132.89 E.00447
G1 X116.81 Y133.19 E.00894
G1 X116.96 Y133.19 E.00447
G1 X116.96 Y133.49 E.00894
G1 X117.11 Y133.49 E.00447
G1 X117.11 Y133.64 E.00447
G1 X117.26 Y133.64 E.00447
G1 X117.26 Y133.94 E.00894
G1 X117.41 Y133.94 E.00447
G1 X117.41 Y134.09 E.00447
G1 X117.56 Y134.09 E.00447
G1 X117.56 Y134.39 E.00894
G1 X117.71 Y134.39 E.00447
G1 X117.71 Y134.54 E.00447
G1 X117.86 Y134.54 E.00447
G1 X117.86 Y134.69 E.00447
G1 X118.01 Y134.69 E.00447
G1 X118.01 Y134.99 E.00894
G1 X118.16 Y134.99 E.00447
G1 X118.16 Y135.14 E.00447
G1 X118.31 Y135.14 E.00447
G1 X118.31 Y135.29 E.00447
G1 X118.46 Y135.29 E.00447
G1 X118.46 Y135.44 E.00447
G1 X118.61 Y135.44 E.00447
G1 X118.61 Y135.59 E.00447
G1 X118.76 Y135.59 E.00447
G1 X118.76 Y135.74 E.00447
G1 X118.91 Y135.74 E.00447
G1 X118.91 Y135.89 E.00447
G1 X119.06 Y135.89 E.00447
G1 X119.06 Y136.04 E.00447
G1 X119.21 Y136.04 E.00447
G1 X119.21 Y136.19 E.00447
G1 X119.36 Y136.19 E.00447
G1 X119.36 Y136.34 E.00447
G1 X119.66 Y136.34 E.00894
G1 X119.66 Y136.49 E.00447
G1 X119.81 Y136.49 E.00447
G1 X119.81 Y136.64 E.00447
G1 X119.96 Y136.64 E.00447
G1 X119.96 Y136.79 E.00447
G1 X120.26 Y136.79 E.00894
G1 X120.26 Y136.94 E.00447
G1 X120.41 Y136.94 E.00447
G1 X120.41 Y137.09 E.00447
G1 X120.71 Y137.09 E.00894
G1 X120.71 Y137.24 E.00447
G1 X120.86 Y137.24 E.00447
G1 X120.86 Y137.39 E.00447
G1 X121.16 Y137.39 E.00894
G1 X121.16 Y137.54 E.00447
G1 X121.31 Y137.54 E.00447
G1 X121.31 Y137.69 E.00447
G1 X121.61 Y137.69 E.00894
G1 X121.61 Y137.84 E.00447
G1 X121.91 Y137.84 E.00894
G1 X121.91 Y137.99 E.00447
G1 X122.21 Y137.99 E.00894
G1 X122.21 Y138.14 E.00447
G1 X122.66 Y138.14 E.0134
G1 X122.66 Y138.29 E.00447
G1 X122.96 Y138.29 E.00894
G1 X122.96 Y138.44 E.00447
G1 X123.41 Y138.44 E.0134
G1 X123.41 Y138.59 E.00447
G1 X123.74 Y138.59 E.00983
G1 X123.74 Y138.56 E.00089
G1 X123.44 Y138.56 E.00894
G1 X123.44 Y138.41 E.00447
G1 X123.14 Y138.41 E.00894
G1 X123.14 Y138.26 E.00447
G1 X122.84 Y138.26 E.00894
G1 X122.84 Y138.11 E.00447
G1 X122.54 Y138.11 E.00894
G1 X122.54 Y137.96 E.00447
G1 X122.24 Y137.96 E.00894
G1 X122.24 Y137.81 E.00447
G1 X121.94 Y137.81 E.00894
G1 X121.94 Y137.66 E.00447
G1 X121.64 Y137.66 E.00894
G1 X121.64 Y137.51 E.00447
G1 X121.49 Y137.51 E.00447
G1 X121.49 Y137.36 E.00447
G1 X121.19 Y137.36 E.00894
G1 X121.19 Y137.21 E.00447
G1 X121.04 Y137.21 E.00447
G1 X121.04 Y137.06 E.00447
G1 X120.74 Y137.06 E.00894
G1 X120.74 Y136.91 E.00447
G1 X120.59 Y136.91 E.00447
G1 X120.59 Y136.76 E.00447
G1 X120.44 Y136.76 E.00447
G1 X120.44 Y136.61 E.00447
G1 X120.14 Y136.61 E.00894
G1 X120.14 Y136.46 E.00447
G1 X119.99 Y136.46 E.00447
G1 X119.99 Y136.31 E.00447
G1 X119.84 Y136.31 E.00447
G1 X119.84 Y136.16 E.00447
G1 X119.69 Y136.16 E.00447
G1 X119.69 Y136.01 E.00447
G1 X119.54 Y136.01 E.00447
G1 X119.54 Y135.86 E.00447
G1 X119.39 Y135.86 E.00447
G1 X119.39 Y135.71 E.00447
G1 X119.24 Y135.71 E.00447
G1 X119.24 Y135.56 E.00447
G1 X119.09 Y135.56 E.00447
G1 X119.09 Y135.41 E.00447
G1 X118.94 Y135.41 E.00447
G1 X118.94 Y135.26 E.00447
G1 X118.79 Y135.26 E.00447
G1 X118.79 Y135.11 E.00447
G1 X118.64 Y135.11 E.00447
G1 X118.64 Y134.96 E.00447
G1 X118.49 Y134.96 E.00447
G1 X118.49 Y134.81 E.00447
G1 X118.34 Y134.81 E.00447
G1 X118.34 Y134.66 E.00447
G1 X118.19 Y134.66 E.00447
G1 X118.19 Y134.51 E.00447
G1 X118.04 Y134.51 E.00447
G1 X118.04 Y134.21 E.00894
G1 X117.89 Y134.21 E.00447
G1 X117.89 Y134.06 E.00447
G1 X117.74 Y134.06 E.00447
G1 X117.74 Y133.91 E.00447
G1 X117.59 Y133.91 E.00447
G1 X117.59 Y133.61 E.00894
G1 X117.44 Y133.61 E.00447
G1 X117.44 Y133.46 E.00447
G1 X117.29 Y133.46 E.00447
G1 X117.29 Y133.16 E.00894
G1 X117.14 Y133.16 E.00447
G1 X117.14 Y133.01 E.00447
G1 X116.99 Y133.01 E.00447
G1 X116.99 Y132.71 E.00894
G1 X116.84 Y132.71 E.00447
G1 X116.84 Y132.56 E.00447
G1 X116.69 Y132.56 E.00447
G1 X116.69 Y132.26 E.00894
G1 X116.54 Y132.26 E.00447
G1 X116.54 Y131.81 E.0134
G1 X116.39 Y131.81 E.00447
G1 X116.39 Y131.51 E.00894
G1 X116.24 Y131.51 E.00447
G1 X116.24 Y131.21 E.00894
G1 X116.09 Y131.21 E.00447
G1 X116.09 Y130.91 E.00894
G1 X115.94 Y130.91 E.00447
G1 X115.94 Y130.46 E.0134
G1 X115.79 Y130.46 E.00447
G1 X115.79 Y130.01 E.0134
G1 X115.64 Y130.01 E.00447
G1 X115.64 Y129.56 E.0134
G1 X115.49 Y129.56 E.00447
G1 X115.49 Y129.02 E.01608
M204 S250
G1 X115.34 Y128.36 F36000
G1 F3156
M204 S6000
G1 X115.31 Y128.36 E.00089
G1 X115.31 Y128.54 E.00536
G1 X115.34 Y128.54 E.00089
G1 X115.34 Y128.42 E.00357
; CHANGE_LAYER
; Z_HEIGHT: 1
; LAYER_HEIGHT: 0.2
; WIPE_START
G1 F9547.055
M204 S10000
G1 X115.31 Y128.36 E-.12839
G1 X115.31 Y128.54 E-.3445
G1 X115.34 Y128.54 E-.05743
G1 X115.34 Y128.42 E-.22967
; WIPE_END
G1 E-.04 F1800
;======== P2S layer_change gcode ==========
;===== 2026/05/15 ====





; update layer progress
M73 L5
M991 S0 P4 ;notify layer change


G17
G3 Z1.2 I1.217 J0 P1  F36000
;======== P2S timelapes gcode ==========
;===== 2025/06/16 ====
; SKIPPABLE_START
; SKIPTYPE: timelapse
M622.1 S1 ; for prev firware, default turned on

M1002 judge_flag timelapse_record_flag
M622 J1
 ; timelapse without wipe tower
  M971 S11 C10 O0
  M1004 S5 P1  ; external shutter

M623
; SKIPPABLE_END

; OBJECT_ID: 175
G1 X130.61 Y131.09
G1 Z1
G1 E.8 F1800
G1 F3788
M204 S6000
G1 X130.91 Y131.09 E.00894
G1 X130.91 Y131.24 E.00447
G1 X131.21 Y131.24 E.00894
G1 X131.21 Y131.39 E.00447
G1 X131.66 Y131.39 E.0134
G1 X131.66 Y131.54 E.00447
G1 X131.96 Y131.54 E.00894
G1 X131.96 Y131.69 E.00447
G1 X132.41 Y131.69 E.0134
G1 X132.41 Y131.84 E.00447
G1 X133.01 Y131.84 E.01787
G1 X133.01 Y131.99 E.00447
G1 X133.76 Y131.99 E.02234
G1 X133.76 Y132.14 E.00447
G1 X135.29 Y132.14 E.04557
G1 X135.29 Y131.99 E.00447
G1 X136.04 Y131.99 E.02234
G1 X136.04 Y131.84 E.00447
G1 X136.49 Y131.84 E.0134
G1 X136.49 Y131.69 E.00447
G1 X136.79 Y131.69 E.00894
G1 X136.79 Y131.54 E.00447
G1 X136.94 Y131.54 E.00447
G1 X136.94 Y131.39 E.00447
G1 X137.24 Y131.39 E.00894
G1 X137.24 Y131.24 E.00447
G1 X137.39 Y131.24 E.00447
G1 X137.39 Y131.09 E.00447
G1 X137.54 Y131.09 E.00447
G1 X137.54 Y130.94 E.00447
G1 X137.69 Y130.94 E.00447
G1 X137.69 Y130.79 E.00447
G1 X137.84 Y130.79 E.00447
G1 X137.84 Y130.49 E.00894
G1 X137.99 Y130.49 E.00447
G1 X137.99 Y130.19 E.00894
G1 X138.14 Y130.19 E.00447
G1 X138.14 Y129.59 E.01787
G1 X138.29 Y129.59 E.00447
G1 X138.29 Y128.54 E.03128
G1 X138.44 Y128.54 E.00447
G1 X138.44 Y127.61 E.0277
G1 X138.29 Y127.61 E.00447
G1 X138.29 Y126.41 E.03574
G1 X138.14 Y126.41 E.00447
G1 X138.14 Y125.66 E.02234
G1 X137.99 Y125.66 E.00447
G1 X137.99 Y125.06 E.01787
G1 X137.81 Y125.06 E.00536
G1 X137.81 Y125.36 E.00894
G1 X137.66 Y125.36 E.00447
G1 X137.66 Y125.66 E.00894
G1 X137.51 Y125.66 E.00447
G1 X137.51 Y125.81 E.00447
G1 X137.36 Y125.81 E.00447
G1 X137.36 Y125.96 E.00447
G1 X137.21 Y125.96 E.00447
G1 X137.21 Y126.11 E.00447
G1 X137.06 Y126.11 E.00447
G1 X137.06 Y126.41 E.00894
G1 X136.91 Y126.41 E.00447
G1 X136.91 Y126.56 E.00447
G1 X136.76 Y126.56 E.00447
G1 X136.76 Y126.71 E.00447
G1 X136.61 Y126.71 E.00447
G1 X136.61 Y126.86 E.00447
G1 X136.46 Y126.86 E.00447
G1 X136.46 Y127.01 E.00447
G1 X136.31 Y127.01 E.00447
G1 X136.31 Y127.16 E.00447
G1 X136.01 Y127.16 E.00894
G1 X136.01 Y127.31 E.00447
G1 X135.86 Y127.31 E.00447
G1 X135.86 Y127.46 E.00447
G1 X135.71 Y127.46 E.00447
G1 X135.71 Y127.61 E.00447
G1 X135.41 Y127.61 E.00894
G1 X135.41 Y127.76 E.00447
G1 X135.26 Y127.76 E.00447
G1 X135.26 Y127.91 E.00447
G1 X134.96 Y127.91 E.00894
G1 X134.96 Y128.06 E.00447
G1 X134.66 Y128.06 E.00894
G1 X134.66 Y128.21 E.00447
G1 X134.36 Y128.21 E.00894
G1 X134.36 Y128.36 E.00447
G1 X134.06 Y128.36 E.00894
G1 X134.06 Y128.51 E.00447
G1 X133.61 Y128.51 E.0134
G1 X133.61 Y128.66 E.00447
G1 X133.16 Y128.66 E.0134
G1 X133.16 Y128.81 E.00447
G1 X132.71 Y128.81 E.0134
G1 X132.71 Y128.96 E.00447
G1 X131.96 Y128.96 E.02234
G1 X131.96 Y129.11 E.00447
G1 X131.81 Y129.11 E.00447
G1 X131.81 Y129.41 E.00894
G1 X131.66 Y129.41 E.00447
G1 X131.66 Y129.71 E.00894
G1 X131.51 Y129.71 E.00447
G1 X131.51 Y130.01 E.00894
G1 X131.36 Y130.01 E.00447
G1 X131.36 Y130.16 E.00447
G1 X131.21 Y130.16 E.00447
G1 X131.21 Y130.31 E.00447
G1 X131.06 Y130.31 E.00447
G1 X131.06 Y130.61 E.00894
G1 X130.91 Y130.61 E.00447
G1 X130.91 Y130.76 E.00447
G1 X130.61 Y130.76 E.00894
G1 X130.61 Y131.03 E.00804
M204 S10000
G1 X131.106 Y130.925 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.276054
G1 F3788
G2 X131.285 Y130.923 I.075 J-1.468 E.0033
G1 X131.308 Y130.865 E.00116
; LINE_WIDTH: 0.215726
G1 X131.331 Y130.806 E.00086
; LINE_WIDTH: 0.19282
G1 X131.331 Y130.506 E.00355
; WIPE_START
G1 F15000
G1 X131.331 Y130.806 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X138.169 Y128.344 Z1.4 F36000
G1 Z1
G1 E.8 F1800
G1 F3788
G1 X138.169 Y127.806 E.00637
; WIPE_START
G1 F15000
G1 X138.169 Y128.344 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X137.47 Y126.538 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3788
M204 S2000
G1 X138.083 Y127.151 E.02581
G1 X138.216 Y127.285
G1 X138.131 Y127.732
G1 X137.997 Y127.599
G1 X137.117 Y126.719 E.03706
G1 X136.984 Y126.585
G1 X136.684 Y126.819
G1 X136.817 Y126.952
G1 X137.865 Y128 E.04414
G1 X137.999 Y128.134
G1 X137.999 Y128.667
G1 X137.865 Y128.533
G1 X136.549 Y127.217 E.05543
G1 X136.416 Y127.084
G1 X136.084 Y127.285
G1 X136.217 Y127.419
G1 X138.083 Y129.284 E.07857
G1 X138.216 Y129.418
G1 X138.066 Y129.801
G1 X137.933 Y129.667
G1 X135.933 Y127.667 E.08424
G1 X135.799 Y127.534
G1 X135.484 Y127.752
G1 X135.617 Y127.885
G1 X137.783 Y130.05 E.09121
G1 X137.916 Y130.184
G1 X137.766 Y130.567
G1 X137.633 Y130.434
G1 X135.316 Y128.117 E.09757
G1 X135.183 Y127.984
G1 X134.799 Y128.134
M73 P94 R0
G1 X134.933 Y128.267
G1 X137.398 Y130.733 E.10385
G1 X137.532 Y130.866
G1 X137.299 Y131.166
G1 X137.165 Y131.033
G1 X134.567 Y128.435 E.10942
G1 X134.434 Y128.301
G1 X134.134 Y128.535
G1 X134.267 Y128.668
G1 X136.782 Y131.183 E.10592
G1 X136.915 Y131.316
G1 X136.682 Y131.616
G1 X136.549 Y131.483
G1 X133.817 Y128.751 E.11505
G1 X133.684 Y128.618
G1 X133.266 Y128.734
G1 X133.4 Y128.867
G1 X136.165 Y131.633 E.11649
G1 X136.299 Y131.766
G1 X135.916 Y131.916
G1 X135.782 Y131.783
G1 X133.017 Y129.017 E.11649
G1 X132.883 Y128.884
G1 X132.5 Y129.034
G1 X132.633 Y129.167
G1 X135.249 Y131.783 E.11017
G1 X135.382 Y131.916
G1 X134.999 Y132.066
G1 X134.865 Y131.933
G1 X132.167 Y129.235 E.11366
G1 X132.034 Y129.101
G1 X131.883 Y129.484
G1 X132.017 Y129.617
G1 X134.332 Y131.933 E.09753
G1 X134.466 Y132.066
G1 X133.783 Y131.916
G1 X133.649 Y131.783
G1 X131.784 Y129.917 E.07857
G1 X131.65 Y129.784
G1 X131.501 Y130.168
G1 X131.635 Y130.302
G1 X132.966 Y131.633 E.05606
G1 X133.099 Y131.766
G1 X132.266 Y131.466
G1 X132.132 Y131.333
G1 X131.675 Y130.875 E.01927
; WIPE_START
G1 F9547.055
M204 S10000
G1 X132.132 Y131.333 E-.24586
G1 X132.266 Y131.466 E-.07182
G1 X133.099 Y131.766 E-.33654
G1 X132.966 Y131.633 E-.07182
G1 X132.902 Y131.569 E-.03397
; WIPE_END
G1 E-.04 F1800
G1 X138.101 Y126.813 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.173467
G1 F3788
G1 X137.887 Y126.599 E.00312
G1 X137.848 Y126.503 E.00106
; WIPE_START
G1 F15000
G1 X137.887 Y126.599 E-.19326
G1 X138.101 Y126.813 E-.56674
; WIPE_END
G1 E-.04 F1800
G1 X131.697 Y130.84 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.111585
G1 F3788
G1 X131.711 Y130.773 E.00037
; LINE_WIDTH: 0.144204
G1 X131.731 Y130.742 E.0003
G2 X131.616 Y130.644 I-.202 J.119 E.00123
; WIPE_START
G1 F15000
G1 X131.731 Y130.742 E-.61063
G1 X131.711 Y130.773 E-.14937
; WIPE_END
G1 E-.04 F1800
G1 X137.406 Y126.231 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.199599
G1 F3788
G1 X137.556 Y126.231 E.00186
G1 X137.606 Y126.206 E.00069
; LINE_WIDTH: 0.26777
G1 X137.656 Y126.181 E.00099
; LINE_WIDTH: 0.317737
G1 X137.706 Y126.156 E.00121
; LINE_WIDTH: 0.347907
G1 X137.784 Y126.146 E.00189
G1 X137.804 Y126.076 E.00176
; LINE_WIDTH: 0.301407
G1 X137.825 Y126.006 E.00149
; LINE_WIDTH: 0.28086
G1 X137.825 Y125.856 E.00282
; WIPE_START
G1 F15000
G1 X137.825 Y126.006 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X133.54 Y119.69 Z1.4 F36000
G1 X131.81 Y117.14 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3788
M204 S6000
G1 X132.26 Y117.14 E.0134
G1 X132.26 Y117.29 E.00447
G1 X132.56 Y117.29 E.00894
G1 X132.56 Y117.44 E.00447
G1 X133.01 Y117.44 E.0134
G1 X133.01 Y117.59 E.00447
G1 X133.31 Y117.59 E.00894
G1 X133.31 Y117.74 E.00447
G1 X133.61 Y117.74 E.00894
G1 X133.61 Y117.89 E.00447
G1 X133.91 Y117.89 E.00894
G1 X133.91 Y118.04 E.00447
G1 X134.21 Y118.04 E.00894
G1 X134.21 Y118.19 E.00447
G1 X134.36 Y118.19 E.00447
G1 X134.36 Y118.34 E.00447
G1 X134.66 Y118.34 E.00894
G1 X134.66 Y118.49 E.00447
G1 X134.96 Y118.49 E.00894
G1 X134.96 Y118.64 E.00447
G1 X135.11 Y118.64 E.00447
G1 X135.11 Y118.79 E.00447
G1 X135.26 Y118.79 E.00447
G1 X135.26 Y118.94 E.00447
G1 X135.56 Y118.94 E.00894
G1 X135.56 Y119.09 E.00447
G1 X135.71 Y119.09 E.00447
G1 X135.71 Y119.24 E.00447
G1 X135.86 Y119.24 E.00447
G1 X135.86 Y119.39 E.00447
G1 X136.16 Y119.39 E.00894
G1 X136.16 Y119.54 E.00447
G1 X136.31 Y119.54 E.00447
G1 X136.31 Y119.69 E.00447
G1 X136.46 Y119.69 E.00447
G1 X136.46 Y119.84 E.00447
G1 X136.61 Y119.84 E.00447
G1 X136.61 Y119.99 E.00447
G1 X136.76 Y119.99 E.00447
G1 X136.76 Y120.14 E.00447
G1 X137.06 Y120.14 E.00894
G1 X137.06 Y120.29 E.00447
G1 X137.21 Y120.29 E.00447
G1 X137.21 Y120.44 E.00447
G1 X137.36 Y120.44 E.00447
G1 X137.36 Y120.74 E.00894
G1 X137.51 Y120.74 E.00447
G1 X137.51 Y120.89 E.00447
G1 X137.66 Y120.89 E.00447
G1 X137.66 Y121.04 E.00447
G1 X137.81 Y121.04 E.00447
G1 X137.81 Y121.19 E.00447
G1 X137.96 Y121.19 E.00447
G1 X137.96 Y121.34 E.00447
G1 X138.11 Y121.34 E.00447
G1 X138.11 Y121.49 E.00447
G1 X138.26 Y121.49 E.00447
G1 X138.26 Y121.79 E.00894
G1 X138.41 Y121.79 E.00447
G1 X138.41 Y121.94 E.00447
G1 X138.56 Y121.94 E.00447
G1 X138.56 Y122.09 E.00447
G1 X138.71 Y122.09 E.00447
G1 X138.71 Y122.39 E.00894
G1 X138.86 Y122.39 E.00447
G1 X138.86 Y122.69 E.00894
G1 X139.01 Y122.69 E.00447
G1 X139.01 Y122.84 E.00447
G1 X139.16 Y122.84 E.00447
G1 X139.16 Y123.14 E.00894
G1 X139.31 Y123.14 E.00447
G1 X139.31 Y123.44 E.00894
G1 X139.46 Y123.44 E.00447
G1 X139.46 Y123.74 E.00894
G1 X139.61 Y123.74 E.00447
G1 X139.61 Y124.04 E.00894
G1 X139.76 Y124.04 E.00447
G1 X139.76 Y124.34 E.00894
G1 X139.91 Y124.34 E.00447
G1 X139.91 Y124.64 E.00894
G1 X140.06 Y124.64 E.00447
G1 X140.06 Y125.09 E.0134
G1 X140.21 Y125.09 E.00447
G1 X140.21 Y125.54 E.0134
G1 X140.36 Y125.54 E.00447
G1 X140.36 Y125.99 E.0134
G1 X140.39 Y125.99 E.00089
G1 X140.39 Y125.51 E.0143
G1 X140.24 Y125.51 E.00447
G1 X140.24 Y124.91 E.01787
G1 X140.09 Y124.91 E.00447
G1 X140.09 Y124.46 E.0134
G1 X139.94 Y124.46 E.00447
G1 X139.94 Y124.01 E.0134
G1 X139.79 Y124.01 E.00447
G1 X139.79 Y123.56 E.0134
G1 X139.64 Y123.56 E.00447
G1 X139.64 Y123.26 E.00894
G1 X139.49 Y123.26 E.00447
G1 X139.49 Y122.96 E.00894
G1 X139.34 Y122.96 E.00447
G1 X139.34 Y122.66 E.00894
G1 X139.19 Y122.66 E.00447
G1 X139.19 Y122.36 E.00894
G1 X139.04 Y122.36 E.00447
G1 X139.04 Y122.21 E.00447
G1 X138.89 Y122.21 E.00447
G1 X138.89 Y121.91 E.00894
G1 X138.74 Y121.91 E.00447
G1 X138.74 Y121.76 E.00447
G1 X138.59 Y121.76 E.00447
G1 X138.59 Y121.46 E.00894
G1 X138.44 Y121.46 E.00447
G1 X138.44 Y121.31 E.00447
G1 X138.29 Y121.31 E.00447
G1 X138.29 Y121.01 E.00894
G1 X138.14 Y121.01 E.00447
G1 X138.14 Y120.86 E.00447
G1 X137.99 Y120.86 E.00447
G1 X137.99 Y120.71 E.00447
G1 X137.84 Y120.71 E.00447
G1 X137.84 Y120.56 E.00447
G1 X137.69 Y120.56 E.00447
G1 X137.69 Y120.41 E.00447
G1 X137.54 Y120.41 E.00447
G1 X137.54 Y120.26 E.00447
G1 X137.39 Y120.26 E.00447
G1 X137.39 Y120.11 E.00447
G1 X137.24 Y120.11 E.00447
G1 X137.24 Y119.96 E.00447
G1 X137.09 Y119.96 E.00447
G1 X137.09 Y119.81 E.00447
G1 X136.94 Y119.81 E.00447
G1 X136.94 Y119.66 E.00447
G1 X136.79 Y119.66 E.00447
G1 X136.79 Y119.51 E.00447
G1 X136.64 Y119.51 E.00447
G1 X136.64 Y119.36 E.00447
G1 X136.49 Y119.36 E.00447
G1 X136.49 Y119.21 E.00447
G1 X136.19 Y119.21 E.00894
G1 X136.19 Y119.06 E.00447
G1 X136.04 Y119.06 E.00447
G1 X136.04 Y118.91 E.00447
G1 X135.74 Y118.91 E.00894
G1 X135.74 Y118.76 E.00447
G1 X135.59 Y118.76 E.00447
G1 X135.59 Y118.61 E.00447
G1 X135.29 Y118.61 E.00894
G1 X135.29 Y118.46 E.00447
G1 X135.14 Y118.46 E.00447
G1 X135.14 Y118.31 E.00447
G1 X134.84 Y118.31 E.00894
G1 X134.84 Y118.16 E.00447
G1 X134.54 Y118.16 E.00894
G1 X134.54 Y118.01 E.00447
G1 X134.24 Y118.01 E.00894
G1 X134.24 Y117.86 E.00447
G1 X133.94 Y117.86 E.00894
G1 X133.94 Y117.71 E.00447
G1 X133.64 Y117.71 E.00894
G1 X133.64 Y117.56 E.00447
G1 X133.19 Y117.56 E.0134
G1 X133.19 Y117.41 E.00447
G1 X132.74 Y117.41 E.0134
G1 X132.74 Y117.26 E.00447
G1 X132.29 Y117.26 E.0134
G1 X132.29 Y117.11 E.00447
G1 X131.84 Y117.11 E.0134
M204 S250
G1 X131.36 Y116.99 F36000
G1 F3788
M204 S6000
G1 X131.69 Y116.99 E.00983
G1 X131.69 Y116.96 E.00089
G1 X131.39 Y116.96 E.00894
M204 S250
G1 X130.91 Y116.84 F36000
G1 F3788
M204 S6000
G1 X131.09 Y116.84 E.00536
G1 X131.09 Y116.81 E.00089
G1 X130.94 Y116.81 E.00447
; WIPE_START
G1 F9547.055
M204 S10000
G1 X131.09 Y116.84 E-.34915
G1 X131.09 Y116.81 E-.06849
G1 X130.94 Y116.81 E-.34237
; WIPE_END
G1 E-.04 F1800
G1 X136.371 Y122.173 Z1.4 F36000
G1 X140.51 Y126.26 Z1.4
G1 Z1
G1 E.8 F1800
G1 F3788
M204 S6000
G1 X140.51 Y126.44 E.00536
G1 X140.54 Y126.44 E.00089
G1 X140.54 Y126.29 E.00447
; WIPE_START
G1 F9547.055
M204 S10000
G1 X140.51 Y126.44 E-.34915
G1 X140.54 Y126.44 E-.06849
G1 X140.54 Y126.29 E-.34237
; WIPE_END
G1 E-.04 F1800
G1 X134.351 Y121.823 Z1.4 F36000
G1 X129.11 Y118.04 Z1.4
G1 Z1
G1 E.8 F1800
G1 F3788
M204 S6000
G1 X129.11 Y118.19 E.00447
G1 X129.26 Y118.19 E.00447
G1 X129.26 Y118.49 E.00894
G1 X129.41 Y118.49 E.00447
G1 X129.41 Y118.64 E.00447
G1 X129.56 Y118.64 E.00447
G1 X129.56 Y118.94 E.00894
G1 X129.71 Y118.94 E.00447
G1 X129.71 Y119.24 E.00894
G1 X129.86 Y119.24 E.00447
G1 X129.86 Y119.54 E.00894
G1 X130.01 Y119.54 E.00447
G1 X130.01 Y119.84 E.00894
G1 X130.16 Y119.84 E.00447
G1 X130.16 Y120.44 E.01787
G1 X130.31 Y120.44 E.00447
G1 X130.31 Y121.04 E.01787
G1 X130.46 Y121.04 E.00447
G1 X130.46 Y121.94 E.02681
G1 X130.61 Y121.94 E.00447
G1 X130.61 Y123.71 E.05272
G1 X130.46 Y123.71 E.00447
G1 X130.46 Y124.79 E.03217
G1 X130.61 Y124.79 E.00447
G1 X130.61 Y124.94 E.00447
G1 X130.76 Y124.94 E.00447
G1 X130.76 Y125.09 E.00447
G1 X130.91 Y125.09 E.00447
G1 X130.91 Y125.24 E.00447
G1 X131.06 Y125.24 E.00447
G1 X131.06 Y125.39 E.00447
G1 X131.21 Y125.39 E.00447
G1 X131.21 Y125.54 E.00447
G1 X131.36 Y125.54 E.00447
G1 X131.36 Y125.84 E.00894
G1 X131.51 Y125.84 E.00447
G1 X131.51 Y126.14 E.00894
G1 X131.66 Y126.14 E.00447
G1 X131.66 Y126.44 E.00894
G1 X131.84 Y126.44 E.00536
G1 X131.84 Y126.29 E.00447
G1 X132.14 Y126.29 E.00894
G1 X132.14 Y126.14 E.00447
G1 X132.29 Y126.14 E.00447
G1 X132.29 Y125.99 E.00447
G1 X132.44 Y125.99 E.00447
G1 X132.44 Y125.84 E.00447
G1 X132.59 Y125.84 E.00447
G1 X132.59 Y125.69 E.00447
G1 X132.74 Y125.69 E.00447
G1 X132.74 Y125.54 E.00447
G1 X132.89 Y125.54 E.00447
G1 X132.89 Y125.39 E.00447
G1 X133.04 Y125.39 E.00447
G1 X133.04 Y125.09 E.00894
G1 X133.19 Y125.09 E.00447
G1 X133.19 Y124.94 E.00447
G1 X133.34 Y124.94 E.00447
G1 X133.34 Y124.79 E.00447
G1 X133.49 Y124.79 E.00447
G1 X133.49 Y124.49 E.00894
G1 X133.64 Y124.49 E.00447
G1 X133.64 Y124.34 E.00447
G1 X133.79 Y124.34 E.00447
G1 X133.79 Y124.04 E.00894
G1 X133.94 Y124.04 E.00447
G1 X133.94 Y123.89 E.00447
G1 X134.09 Y123.89 E.00447
G1 X134.09 Y123.59 E.00894
G1 X134.24 Y123.59 E.00447
G1 X134.24 Y123.29 E.00894
G1 X134.39 Y123.29 E.00447
G1 X134.39 Y122.99 E.00894
G1 X134.54 Y122.99 E.00447
G1 X134.54 Y122.39 E.01787
G1 X134.69 Y122.39 E.00447
G1 X134.69 Y121.31 E.03217
G1 X134.54 Y121.31 E.00447
G1 X134.54 Y121.01 E.00894
G1 X134.39 Y121.01 E.00447
G1 X134.39 Y120.71 E.00894
G1 X134.24 Y120.71 E.00447
G1 X134.24 Y120.56 E.00447
G1 X134.09 Y120.56 E.00447
G1 X134.09 Y120.41 E.00447
G1 X133.94 Y120.41 E.00447
G1 X133.94 Y120.26 E.00447
G1 X133.79 Y120.26 E.00447
G1 X133.79 Y120.11 E.00447
G1 X133.64 Y120.11 E.00447
G1 X133.64 Y119.96 E.00447
G1 X133.49 Y119.96 E.00447
G1 X133.49 Y119.81 E.00447
G1 X133.19 Y119.81 E.00894
G1 X133.19 Y119.66 E.00447
G1 X133.04 Y119.66 E.00447
G1 X133.04 Y119.51 E.00447
G1 X132.89 Y119.51 E.00447
G1 X132.89 Y119.36 E.00447
G1 X132.59 Y119.36 E.00894
G1 X132.59 Y119.21 E.00447
G1 X132.29 Y119.21 E.00894
G1 X132.29 Y119.06 E.00447
G1 X131.99 Y119.06 E.00894
G1 X131.99 Y118.91 E.00447
G1 X131.69 Y118.91 E.00894
G1 X131.69 Y118.76 E.00447
G1 X131.39 Y118.76 E.00894
G1 X131.39 Y118.61 E.00447
G1 X130.94 Y118.61 E.0134
G1 X130.94 Y118.46 E.00447
G1 X130.64 Y118.46 E.00894
G1 X130.64 Y118.31 E.00447
G1 X130.19 Y118.31 E.0134
G1 X130.19 Y118.16 E.00447
G1 X129.74 Y118.16 E.0134
G1 X129.74 Y118.01 E.00447
G1 X128.99 Y118.01 E.02234
G1 X128.99 Y117.86 E.00447
G1 X128.96 Y117.86 E.00089
G1 X128.96 Y118.04 E.00536
G1 X129.05 Y118.04 E.00268
; WIPE_START
G1 F9547.055
M204 S10000
G1 X129.11 Y118.19 E-.06139
G1 X129.26 Y118.19 E-.057
G1 X129.26 Y118.49 E-.114
G1 X129.41 Y118.49 E-.057
G1 X129.41 Y118.64 E-.057
G1 X129.56 Y118.64 E-.057
G1 X129.56 Y118.94 E-.114
G1 X129.71 Y118.94 E-.057
G1 X129.71 Y119.24 E-.114
G1 X129.86 Y119.24 E-.057
G1 X129.86 Y119.278 E-.01461
; WIPE_END
G1 E-.04 F1800
G1 X129.964 Y118.606 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.274875
G1 F3788
G1 X129.933 Y118.619 E.0006
G1 X129.955 Y118.656 E.00079
; LINE_WIDTH: 0.231595
G1 X129.968 Y118.7 E.00068
; LINE_WIDTH: 0.194535
G1 X129.981 Y119.044 E.00412
G1 X129.964 Y118.606 F36000
; LINE_WIDTH: 0.238584
G1 F3788
G1 X129.994 Y118.594 E.00051
; LINE_WIDTH: 0.194616
G1 X130.444 Y118.581 E.00539
; WIPE_START
G1 F15000
G1 X129.994 Y118.594 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.483 Y121.951 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3788
M204 S2000
G1 X131.799 Y119.267 E.11305
G1 X131.665 Y119.134
G1 X130.682 Y118.684
G1 X130.816 Y118.817
G1 X134.333 Y122.334 E.14815
G1 X134.466 Y122.468
G1 X134.381 Y122.916
G1 X134.248 Y122.783
G1 X130.351 Y118.886 E.16415
G1 X130.217 Y118.752
G1 X130.049 Y119.118
G1 X130.183 Y119.251
G1 X134.033 Y123.101 E.16216
G1 X134.166 Y123.235
G1 X134.016 Y123.618
G1 X133.883 Y123.484
M73 P95 R0
G1 X130.367 Y119.969 E.14808
G1 X130.234 Y119.835
G1 X130.384 Y120.519
G1 X130.517 Y120.652
G1 X133.698 Y123.833 E.13397
G1 X133.831 Y123.966
G1 X133.598 Y124.266
G1 X133.465 Y124.133
G1 X130.667 Y121.335 E.11783
G1 X130.534 Y121.202
G1 X130.684 Y121.885
G1 X130.817 Y122.019
G1 X133.283 Y124.484 E.10385
G1 X133.416 Y124.618
G1 X133.132 Y124.866
G1 X132.998 Y124.733
G1 X130.817 Y122.552 E.09186
G1 X130.684 Y122.418
G1 X130.684 Y122.952
G1 X130.817 Y123.085
G1 X132.833 Y125.1 E.08489
G1 X132.966 Y125.234
G1 X132.666 Y125.467
G1 X132.533 Y125.334
G1 X130.817 Y123.618 E.07225
G1 X130.684 Y123.485
G1 X130.534 Y123.868
G1 X130.667 Y124.002
G1 X132.298 Y125.633 E.0687
G1 X132.432 Y125.766
G1 X132.199 Y126.066
G1 X132.065 Y125.933
G1 X131.567 Y125.435 E.02096
M204 S10000
G1 X131.032 Y124.751 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.210115
G1 F3788
G1 X130.649 Y124.368 E.00716
; WIPE_START
G1 F15000
G1 X131.032 Y124.751 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.641 Y125.361 Z1.4 F36000
G1 Z1
G1 E.8 F1800
G1 F3788
G1 X130.649 Y124.368 E.01855
; WIPE_START
G1 F15000
G1 X131.641 Y125.361 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X131.641 Y125.361 Z1 F36000
G1 E.8 F1800
G1 F3788
G1 X131.249 Y124.968 E.00734
G1 X131.641 Y125.361 F36000
G1 F3788
G1 X131.399 Y125.118 E.00454
G1 X131.578 Y125.424 F36000
; LINE_WIDTH: 0.142201
G1 F3788
G1 X131.589 Y125.363 E.00049
; LINE_WIDTH: 0.171162
G1 X131.6 Y125.302 E.00063
; LINE_WIDTH: 0.197869
G1 X131.249 Y125.069 E.00515
; WIPE_START
G1 F15000
G1 X131.6 Y125.302 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.851 Y119.933 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.212492
G1 F3788
G1 X132.401 Y119.483 E.00852
G1 X133.001 Y120.083 F36000
G1 F3788
G1 X132.401 Y119.483 E.01137
; WIPE_START
G1 F15000
G1 X133.001 Y120.083 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X134.201 Y121.107 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.336953
G1 F3788
G3 X133.901 Y120.895 I.105 J-.467 E.00876
G1 X133.301 Y120.295 E.01971
G3 X133.093 Y119.999 I.253 J-.4 E.00865
; WIPE_START
G1 F12243.54
G1 X133.155 Y120.149 E-.07742
G1 X133.301 Y120.295 E-.09913
G1 X133.901 Y120.895 E-.40482
G1 X134.051 Y121.045 E-.10121
G1 X134.201 Y121.107 E-.07742
; WIPE_END
G1 E-.04 F1800
G1 X127.94 Y123.89 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3788
M204 S6000
G1 X127.94 Y123.71 E.00536
G1 X127.79 Y123.71 E.00447
G1 X127.79 Y123.26 E.0134
G1 X127.64 Y123.26 E.00447
G1 X127.64 Y122.96 E.00894
G1 X127.49 Y122.96 E.00447
G1 X127.49 Y122.66 E.00894
G1 X127.34 Y122.66 E.00447
G1 X127.34 Y122.36 E.00894
G1 X127.19 Y122.36 E.00447
G1 X127.19 Y122.06 E.00894
G1 X127.04 Y122.06 E.00447
G1 X127.04 Y121.91 E.00447
G1 X126.89 Y121.91 E.00447
G1 X126.89 Y121.61 E.00894
G1 X126.74 Y121.61 E.00447
G1 X126.74 Y121.46 E.00447
G1 X126.59 Y121.46 E.00447
G1 X126.59 Y121.31 E.00447
G1 X126.44 Y121.31 E.00447
G1 X126.44 Y121.01 E.00894
G1 X126.29 Y121.01 E.00447
G1 X126.29 Y120.86 E.00447
G1 X126.14 Y120.86 E.00447
G1 X126.14 Y120.71 E.00447
G1 X125.99 Y120.71 E.00447
G1 X125.99 Y120.56 E.00447
G1 X125.84 Y120.56 E.00447
G1 X125.84 Y120.41 E.00447
G1 X125.69 Y120.41 E.00447
G1 X125.69 Y120.26 E.00447
G1 X125.39 Y120.26 E.00894
G1 X125.39 Y120.11 E.00447
G1 X125.24 Y120.11 E.00447
G1 X125.24 Y119.96 E.00447
G1 X124.94 Y119.96 E.00894
G1 X124.94 Y119.81 E.00447
G1 X124.64 Y119.81 E.00894
G1 X124.64 Y119.66 E.00447
G1 X124.34 Y119.66 E.00894
G1 X124.34 Y119.51 E.00447
G1 X124.04 Y119.51 E.00894
G1 X124.04 Y119.36 E.00447
G1 X122.51 Y119.36 E.04557
G1 X122.51 Y119.51 E.00447
G1 X122.21 Y119.51 E.00894
G1 X122.21 Y119.66 E.00447
G1 X121.76 Y119.66 E.0134
G1 X121.76 Y119.81 E.00447
G1 X121.61 Y119.81 E.00447
G1 X121.61 Y119.96 E.00447
G1 X121.31 Y119.96 E.00894
G1 X121.31 Y120.11 E.00447
G1 X121.16 Y120.11 E.00447
G1 X121.16 Y120.26 E.00447
G1 X121.01 Y120.26 E.00447
G1 X121.01 Y120.41 E.00447
G1 X120.86 Y120.41 E.00447
G1 X120.86 Y120.56 E.00447
G1 X120.71 Y120.56 E.00447
G1 X120.71 Y120.71 E.00447
G1 X120.41 Y120.71 E.00894
G1 X120.41 Y120.86 E.00447
G1 X120.26 Y120.86 E.00447
G1 X120.26 Y121.16 E.00894
G1 X120.11 Y121.16 E.00447
G1 X120.11 Y121.31 E.00447
G1 X119.96 Y121.31 E.00447
G1 X119.96 Y121.46 E.00447
G1 X119.81 Y121.46 E.00447
G1 X119.81 Y121.61 E.00447
G1 X119.66 Y121.61 E.00447
G1 X119.66 Y121.91 E.00894
G1 X119.51 Y121.91 E.00447
G1 X119.51 Y122.06 E.00447
G1 X119.36 Y122.06 E.00447
G1 X119.36 Y122.36 E.00894
G1 X119.21 Y122.36 E.00447
G1 X119.21 Y122.51 E.00447
G1 X119.06 Y122.51 E.00447
G1 X119.06 Y122.81 E.00894
G1 X118.91 Y122.81 E.00447
G1 X118.91 Y122.96 E.00447
G1 X118.76 Y122.96 E.00447
G1 X118.76 Y123.26 E.00894
G1 X118.61 Y123.26 E.00447
G1 X118.61 Y123.59 E.00983
G1 X118.79 Y123.59 E.00536
G1 X118.79 Y123.44 E.00447
G1 X119.39 Y123.44 E.01787
G1 X119.39 Y123.29 E.00447
G1 X120.29 Y123.29 E.02681
G1 X120.29 Y123.14 E.00447
G1 X122.21 Y123.14 E.05719
G1 X122.21 Y123.29 E.00447
G1 X123.11 Y123.29 E.02681
G1 X123.11 Y123.44 E.00447
G1 X123.56 Y123.44 E.0134
G1 X123.56 Y123.59 E.00447
G1 X124.16 Y123.59 E.01787
G1 X124.16 Y123.74 E.00447
G1 X124.46 Y123.74 E.00894
G1 X124.46 Y123.89 E.00447
G1 X124.76 Y123.89 E.00894
G1 X124.76 Y124.04 E.00447
G1 X125.06 Y124.04 E.00894
G1 X125.06 Y124.19 E.00447
G1 X125.36 Y124.19 E.00894
G1 X125.36 Y124.34 E.00447
G1 X125.66 Y124.34 E.00894
G1 X125.66 Y124.49 E.00447
G1 X125.84 Y124.49 E.00536
G1 X125.84 Y124.34 E.00447
G1 X126.14 Y124.34 E.00894
G1 X126.14 Y124.19 E.00447
G1 X126.44 Y124.19 E.00894
G1 X126.44 Y124.04 E.00447
G1 X127.04 Y124.04 E.01787
G1 X127.04 Y123.89 E.00447
G1 X127.88 Y123.89 E.02502
M204 S10000
G1 X127.594 Y123.575 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.281152
G1 F3788
G3 X127.415 Y123.573 I-.075 J-1.468 E.00337
; LINE_WIDTH: 0.26152
G1 X127.392 Y123.515 E.00109
; LINE_WIDTH: 0.19679
G1 X127.369 Y123.456 E.00076
G1 X127.369 Y123.156 E.00365
G1 X126.983 Y122.45 F36000
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3788
M204 S2000
G1 X124.55 Y120.017 E.10247
G1 X124.416 Y119.884
G1 X123.433 Y119.434
G1 X123.567 Y119.567
G1 X127.062 Y123.063 E.14724
G1 X127.196 Y123.196
G1 X127.193 Y123.727
G1 X127.06 Y123.593
G1 X123.033 Y119.567 E.1696
G1 X122.9 Y119.434
G1 X122.517 Y119.584
G1 X122.65 Y119.717
G1 X126.765 Y123.833 E.17335
G1 X126.899 Y123.966
G1 X126.366 Y123.967
G1 X126.233 Y123.833
G1 X122.267 Y119.867 E.16705
G1 X122.133 Y119.734
G1 X121.75 Y119.884
G1 X121.884 Y120.017
G1 X125.631 Y123.765 E.15787
G1 X125.765 Y123.899
G1 X125.299 Y123.966
G1 X125.166 Y123.833
G1 X121.517 Y120.184 E.15368
G1 X121.384 Y120.051
G1 X121.134 Y120.334
G1 X121.267 Y120.467
G1 X124.182 Y123.383 E.1228
G1 X124.316 Y123.516
G1 X123.633 Y123.366
G1 X123.499 Y123.233
G1 X121.034 Y120.767 E.10385
G1 X120.9 Y120.634
G1 X120.517 Y120.784
G1 X120.651 Y120.917
G1 X122.816 Y123.083 E.09121
G1 X122.95 Y123.216
G1 X122.266 Y123.066
G1 X122.133 Y122.933
G1 X120.467 Y121.267 E.07015
G1 X120.334 Y121.134
G1 X120.051 Y121.384
G1 X120.184 Y121.517
G1 X121.599 Y122.933 E.05962
G1 X121.733 Y123.066
G1 X121.2 Y123.066
G1 X121.066 Y122.933
G1 X119.951 Y121.817 E.04698
G1 X119.817 Y121.684
G1 X119.584 Y121.984
G1 X119.718 Y122.117
G1 X120.533 Y122.933 E.03434
; WIPE_START
G1 F9547.055
M204 S10000
G1 X119.718 Y122.117 E-.43812
G1 X119.584 Y121.984 E-.07182
G1 X119.817 Y121.684 E-.1444
G1 X119.951 Y121.817 E-.07182
G1 X120.014 Y121.88 E-.03385
; WIPE_END
G1 E-.04 F1800
G1 X125.501 Y120.641 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.128705
G1 F3788
G1 X125.309 Y120.449 E.00185
G1 X125.651 Y120.791 F36000
; LINE_WIDTH: 0.128706
G1 F3788
G1 X125.309 Y120.449 E.00329
; WIPE_START
G1 F15000
G1 X125.651 Y120.791 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.251 Y121.391 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.128707
G1 F3788
G1 X125.309 Y120.449 E.00904
; WIPE_START
G1 F15000
G1 X126.251 Y121.391 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.251 Y121.391 Z1 F36000
G1 E.8 F1800
; LINE_WIDTH: 0.128708
G1 F3788
G1 X125.909 Y121.049 E.00329
G1 X126.251 Y121.391 F36000
; LINE_WIDTH: 0.128712
G1 F3788
G1 X126.059 Y121.199 E.00185
; WIPE_START
G1 F15000
G1 X126.251 Y121.391 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.151 Y122.738 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.187311
G1 F3788
G1 X126.944 Y122.583 E.00295
; LINE_WIDTH: 0.158561
G1 X126.976 Y122.457 E.00119
G1 X127.273 Y122.967 F36000
; LINE_WIDTH: 0.145587
G1 F3788
G1 X127.1 Y122.549 E.00368
; WIPE_START
G1 F15000
G1 X127.273 Y122.967 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.944 Y124.069 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.19282
G1 F3788
G1 X125.556 Y124.069 E.00459
; WIPE_START
G1 F15000
G1 X125.944 Y124.069 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.094 Y123.019 Z1.4 F36000
G1 Z1
G1 E.8 F1800
G1 F3788
G1 X119.556 Y123.019 E.00637
; LINE_WIDTH: 0.217804
G1 X119.506 Y122.994 E.00077
; LINE_WIDTH: 0.26777
G1 X119.456 Y122.969 E.00099
; LINE_WIDTH: 0.317769
G1 X119.406 Y122.944 E.00121
; LINE_WIDTH: 0.34282
G1 X119.406 Y122.856 E.00209
; LINE_WIDTH: 0.317737
G1 X119.431 Y122.806 E.00121
; LINE_WIDTH: 0.26777
G1 X119.456 Y122.756 E.00099
; LINE_WIDTH: 0.1996
G1 X119.481 Y122.706 E.00069
G1 X119.481 Y122.556 E.00186
G1 X119.556 Y122.9 F36000
; LINE_WIDTH: 0.196815
G1 F3788
G1 X119.406 Y122.975 E.00204
; LINE_WIDTH: 0.139002
G1 X119.256 Y123.05 E.00127
G2 X119.15 Y123.094 I-.037 J.06 E.00102
G3 X119.106 Y123.2 I-.06 J.037 E.00102
G1 X118.956 Y123.2 E.00114
; WIPE_START
G1 F15000
G1 X119.106 Y123.2 E-.19335
G1 X119.142 Y123.192 E-.04795
G1 X119.15 Y123.094 E-.12732
G1 X119.158 Y123.058 E-.04795
G1 X119.256 Y123.05 E-.12732
G1 X119.406 Y122.975 E-.2161
; WIPE_END
G1 E-.04 F1800
G1 X126.429 Y125.964 Z1.4 F36000
G1 X129.59 Y127.31 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3788
M204 S6000
G1 X128.39 Y127.31 E.03574
G1 X128.39 Y126.26 E.03128
G1 X127.61 Y126.26 E.02323
G1 X127.61 Y127.31 E.03128
G1 X126.41 Y127.31 E.03574
G1 X126.41 Y128.24 E.0277
G1 X127.61 Y128.24 E.03574
G1 X127.61 Y129.44 E.03574
G1 X128.39 Y129.44 E.02323
G1 X128.39 Y128.24 E.03574
M73 P96 R0
G1 X129.59 Y128.24 E.03574
G1 X129.59 Y127.37 E.02591
M204 S10000
G1 X129.394 Y127.775 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.58088
G1 F3788
G1 X128.194 Y127.775 E.05099
; LINE_WIDTH: 0.601764
G1 X128.129 Y127.775 E.00285
; LINE_WIDTH: 0.64353
G1 X128.065 Y127.775 E.00307
; LINE_WIDTH: 0.685297
G1 X128 Y127.775 E.00328
G1 X127.935 Y127.775 E.00328
; LINE_WIDTH: 0.64353
G1 X127.871 Y127.775 E.00307
; LINE_WIDTH: 0.581948
G1 X126.606 Y127.775 E.05385
; WIPE_START
G1 F6678.691
G1 X127.871 Y127.775 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X128 Y127.775 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.683239
G1 F3788
G1 X128 Y127.82 E.00227
; LINE_WIDTH: 0.637355
G1 X128 Y127.865 E.00211
; LINE_WIDTH: 0.591472
G1 X128 Y127.909 E.00194
; LINE_WIDTH: 0.545589
G1 X128 Y127.954 E.00178
; LINE_WIDTH: 0.499705
G1 X128 Y127.999 E.00162
; LINE_WIDTH: 0.431707
G1 X128 Y129.244 E.03823
; WIPE_START
G1 F9259.588
G1 X128 Y127.999 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X124.19 Y126.41 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3788
M204 S6000
G1 X123.41 Y126.41 E.02323
G1 X123.41 Y126.56 E.00447
G1 X122.36 Y126.56 E.03128
G1 X122.36 Y126.71 E.00447
G1 X121.76 Y126.71 E.01787
G1 X121.76 Y126.86 E.00447
G1 X121.31 Y126.86 E.0134
G1 X121.31 Y127.01 E.00447
G1 X121.01 Y127.01 E.00894
G1 X121.01 Y127.16 E.00447
G1 X120.71 Y127.16 E.00894
G1 X120.71 Y127.31 E.00447
G1 X120.41 Y127.31 E.00894
G1 X120.41 Y127.46 E.00447
G1 X120.11 Y127.46 E.00894
G1 X120.11 Y127.61 E.00447
G1 X119.81 Y127.61 E.00894
G1 X119.81 Y127.76 E.00447
G1 X119.66 Y127.76 E.00447
G1 X119.66 Y127.91 E.00447
G1 X119.51 Y127.91 E.00447
G1 X119.51 Y128.06 E.00447
G1 X119.21 Y128.06 E.00894
G1 X119.21 Y128.21 E.00447
G1 X119.06 Y128.21 E.00447
G1 X119.06 Y128.36 E.00447
G1 X118.91 Y128.36 E.00447
G1 X118.91 Y128.66 E.00894
G1 X118.76 Y128.66 E.00447
G1 X118.76 Y128.81 E.00447
G1 X118.61 Y128.81 E.00447
G1 X118.61 Y128.96 E.00447
G1 X118.46 Y128.96 E.00447
G1 X118.46 Y129.26 E.00894
G1 X118.31 Y129.26 E.00447
G1 X118.31 Y129.56 E.00894
G1 X118.16 Y129.56 E.00447
G1 X118.16 Y130.64 E.03217
G1 X118.31 Y130.64 E.00447
G1 X118.31 Y131.09 E.0134
G1 X118.46 Y131.09 E.00447
G1 X118.46 Y131.39 E.00894
G1 X118.61 Y131.39 E.00447
G1 X118.61 Y131.69 E.00894
G1 X118.76 Y131.69 E.00447
G1 X118.76 Y131.99 E.00894
G1 X118.91 Y131.99 E.00447
G1 X118.91 Y132.14 E.00447
G1 X119.06 Y132.14 E.00447
G1 X119.06 Y132.44 E.00894
G1 X119.21 Y132.44 E.00447
G1 X119.21 Y132.59 E.00447
G1 X119.36 Y132.59 E.00447
G1 X119.36 Y132.89 E.00894
G1 X119.51 Y132.89 E.00447
G1 X119.51 Y133.04 E.00447
G1 X119.66 Y133.04 E.00447
G1 X119.66 Y133.34 E.00894
G1 X119.81 Y133.34 E.00447
G1 X119.81 Y133.49 E.00447
G1 X119.96 Y133.49 E.00447
G1 X119.96 Y133.64 E.00447
G1 X120.11 Y133.64 E.00447
G1 X120.11 Y133.94 E.00894
G1 X120.26 Y133.94 E.00447
G1 X120.26 Y134.09 E.00447
G1 X120.41 Y134.09 E.00447
G1 X120.41 Y134.24 E.00447
G1 X120.56 Y134.24 E.00447
G1 X120.56 Y134.39 E.00447
G1 X120.71 Y134.39 E.00447
G1 X120.71 Y134.54 E.00447
G1 X120.86 Y134.54 E.00447
G1 X120.86 Y134.69 E.00447
G1 X121.01 Y134.69 E.00447
G1 X121.01 Y134.99 E.00894
G1 X121.16 Y134.99 E.00447
G1 X121.16 Y135.14 E.00447
G1 X121.31 Y135.14 E.00447
G1 X121.31 Y135.29 E.00447
G1 X121.34 Y135.29 E.00089
G1 X121.34 Y133.34 E.05808
G1 X121.49 Y133.34 E.00447
G1 X121.49 Y132.74 E.01787
G1 X121.64 Y132.74 E.00447
G1 X121.64 Y132.29 E.0134
G1 X121.79 Y132.29 E.00447
G1 X121.79 Y131.84 E.0134
G1 X121.94 Y131.84 E.00447
G1 X121.94 Y131.54 E.00894
G1 X122.09 Y131.54 E.00447
G1 X122.09 Y131.24 E.00894
G1 X122.24 Y131.24 E.00447
G1 X122.24 Y131.09 E.00447
G1 X122.39 Y131.09 E.00447
G1 X122.39 Y130.79 E.00894
G1 X122.54 Y130.79 E.00447
G1 X122.54 Y130.64 E.00447
G1 X122.69 Y130.64 E.00447
G1 X122.69 Y130.34 E.00894
G1 X122.84 Y130.34 E.00447
G1 X122.84 Y130.19 E.00447
G1 X122.99 Y130.19 E.00447
G1 X122.99 Y130.04 E.00447
G1 X123.14 Y130.04 E.00447
G1 X123.14 Y129.89 E.00447
G1 X123.29 Y129.89 E.00447
G1 X123.29 Y129.74 E.00447
G1 X123.44 Y129.74 E.00447
G1 X123.44 Y129.59 E.00447
G1 X123.59 Y129.59 E.00447
G1 X123.59 Y129.44 E.00447
G1 X123.74 Y129.44 E.00447
G1 X123.74 Y129.29 E.00447
G1 X123.89 Y129.29 E.00447
G1 X123.89 Y129.14 E.00447
G1 X124.04 Y129.14 E.00447
G1 X124.04 Y128.99 E.00447
G1 X124.19 Y128.99 E.00447
G1 X124.19 Y128.66 E.00983
G1 X124.04 Y128.66 E.00447
G1 X124.04 Y126.74 E.05719
G1 X124.19 Y126.74 E.00447
G1 X124.19 Y126.47 E.00804
M204 S10000
G1 X123.301 Y126.767 F36000
; FEATURE: Top surface
G1 F3788
M204 S2000
G1 X123.833 Y127.299 E.02239
G1 X123.966 Y127.432
G1 X123.966 Y127.966
G1 X123.833 Y127.832
G1 X122.768 Y126.767 E.04485
G1 X122.634 Y126.634
G1 X122.251 Y126.784
G1 X122.385 Y126.917
G1 X123.833 Y128.365 E.061
G1 X123.966 Y128.499
G1 X123.966 Y129.032
G1 X123.833 Y128.899
G1 X121.967 Y127.033 E.07857
G1 X121.834 Y126.9
G1 X121.384 Y126.983
G1 X121.517 Y127.117
G1 X123.533 Y129.132 E.08489
G1 X123.666 Y129.266
G1 X123.384 Y129.516
G1 X123.25 Y129.383
G1 X121.217 Y127.35 E.08563
G1 X121.084 Y127.216
G1 X120.718 Y127.384
G1 X120.852 Y127.517
G1 X123.017 Y129.683 E.09121
G1 X123.15 Y129.816
G1 X122.916 Y130.115
G1 X122.783 Y129.982
G1 X120.468 Y127.667 E.09749
G1 X120.335 Y127.534
G1 X119.951 Y127.684
G1 X120.085 Y127.817
G1 X122.483 Y130.215 E.101
G1 X122.616 Y130.349
G1 X122.451 Y130.716
G1 X122.317 Y130.583
G1 X119.852 Y128.117 E.10385
G1 X119.718 Y127.984
G1 X119.335 Y128.134
G1 X119.469 Y128.267
G1 X122.084 Y130.883 E.11017
G1 X122.217 Y131.016
G1 X122.016 Y131.348
G1 X121.883 Y131.215
G1 X119.235 Y128.567 E.11152
G1 X119.102 Y128.434
G1 X118.868 Y128.734
G1 X119.002 Y128.867
G1 X121.733 Y131.598 E.11502
G1 X121.866 Y131.732
G1 X121.716 Y132.115
G1 X121.583 Y131.981
G1 X118.769 Y129.167 E.11853
G1 X118.635 Y129.034
G1 X118.402 Y129.334
G1 X118.536 Y129.467
G1 X121.433 Y132.364 E.12204
G1 X121.566 Y132.498
G1 X121.416 Y132.881
G1 X121.283 Y132.748
G1 X118.367 Y129.832 E.1228
G1 X118.234 Y129.699
G1 X118.384 Y130.382
G1 X118.517 Y130.516
G1 X121.134 Y133.133 E.11024
G1 X121.268 Y133.266
G1 X121.266 Y133.798
G1 X121.133 Y133.664
G1 X118.967 Y131.499 E.09121
M204 S10000
G1 X119.06 Y131.406 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.157095
G1 F3788
G1 X118.649 Y130.994 E.00525
; WIPE_START
G1 F15000
G1 X119.06 Y131.406 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X120.676 Y133.683 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.336799
G1 F3788
G1 X120.145 Y133.151 E.01744
G2 X119.849 Y132.942 I-.402 J.256 E.00865
; WIPE_START
G1 F12249.941
G1 X119.999 Y133.005 E-.11013
G1 X120.145 Y133.151 E-.14079
G1 X120.676 Y133.683 E-.50908
; WIPE_END
G1 E-.04 F1800
G1 X120.606 Y133.969 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.1996
G1 F3788
G1 X120.756 Y133.969 E.00186
G1 X120.806 Y133.994 E.00069
; LINE_WIDTH: 0.26777
G1 X120.856 Y134.019 E.00099
; LINE_WIDTH: 0.317737
G1 X120.906 Y134.044 E.00121
; LINE_WIDTH: 0.347906
G1 X120.984 Y134.054 E.00189
G1 X121.004 Y134.124 E.00176
; LINE_WIDTH: 0.301405
G1 X121.025 Y134.194 E.00149
; LINE_WIDTH: 0.274434
G2 X121.041 Y134.241 I.031 J.016 E.001
; LINE_WIDTH: 0.234315
G1 X121.056 Y134.256 E.00033
; LINE_WIDTH: 0.196815
G1 X121.078 Y134.3 E.0006
; LINE_WIDTH: 0.152845
G1 X121.1 Y134.344 E.00043
; LINE_WIDTH: 0.13086
G1 X121.1 Y134.494 E.00104
; WIPE_START
G1 F15000
G1 X121.1 Y134.344 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X125.51 Y131.06 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3788
M204 S6000
G1 X125.51 Y131.36 E.00894
G1 X125.36 Y131.36 E.00447
G1 X125.36 Y131.96 E.01787
G1 X125.21 Y131.96 E.00447
G1 X125.21 Y133.64 E.05004
G1 X125.36 Y133.64 E.00447
G1 X125.36 Y134.39 E.02234
G1 X125.51 Y134.39 E.00447
G1 X125.51 Y134.84 E.0134
G1 X125.66 Y134.84 E.00447
G1 X125.66 Y135.29 E.0134
G1 X125.81 Y135.29 E.00447
G1 X125.81 Y135.59 E.00894
G1 X125.96 Y135.59 E.00447
G1 X125.96 Y135.89 E.00894
G1 X126.11 Y135.89 E.00447
G1 X126.11 Y136.19 E.00894
G1 X126.26 Y136.19 E.00447
G1 X126.26 Y136.49 E.00894
G1 X126.41 Y136.49 E.00447
G1 X126.41 Y136.64 E.00447
G1 X126.56 Y136.64 E.00447
G1 X126.56 Y136.79 E.00447
G1 X126.71 Y136.79 E.00447
G1 X126.71 Y137.09 E.00894
G1 X126.86 Y137.09 E.00447
G1 X126.86 Y137.24 E.00447
G1 X127.16 Y137.24 E.00894
G1 X127.16 Y137.39 E.00447
G1 X127.31 Y137.39 E.00447
G1 X127.31 Y137.54 E.00447
G1 X127.61 Y137.54 E.00894
G1 X127.61 Y137.69 E.00447
G1 X127.76 Y137.69 E.00447
G1 X127.76 Y137.84 E.00447
G1 X128.06 Y137.84 E.00894
G1 X128.06 Y137.99 E.00447
G1 X128.81 Y137.99 E.02234
G1 X128.81 Y138.14 E.00447
G1 X128.84 Y138.14 E.00089
G1 X128.84 Y137.99 E.00447
G1 X130.04 Y137.99 E.03574
G1 X130.04 Y137.84 E.00447
G1 X130.64 Y137.84 E.01787
G1 X130.64 Y137.69 E.00447
G1 X131.09 Y137.69 E.0134
G1 X131.09 Y137.54 E.00447
G1 X131.54 Y137.54 E.0134
G1 X131.54 Y137.39 E.00447
G1 X131.99 Y137.39 E.0134
G1 X131.99 Y137.24 E.00447
G1 X132.29 Y137.24 E.00894
G1 X132.29 Y137.09 E.00447
G1 X132.59 Y137.09 E.00894
G1 X132.59 Y136.94 E.00447
G1 X132.89 Y136.94 E.00894
G1 X132.89 Y136.79 E.00447
G1 X133.19 Y136.79 E.00894
G1 X133.19 Y136.64 E.00447
G1 X133.49 Y136.64 E.00894
G1 X133.49 Y136.49 E.00447
G1 X133.64 Y136.49 E.00447
G1 X133.64 Y136.34 E.00447
G1 X133.94 Y136.34 E.00894
G1 X133.94 Y136.19 E.00447
G1 X134.09 Y136.19 E.00447
G1 X134.09 Y136.04 E.00447
G1 X134.24 Y136.04 E.00447
G1 X134.24 Y136.01 E.00089
G1 X133.19 Y136.01 E.03128
G1 X133.19 Y135.86 E.00447
G1 X132.59 Y135.86 E.01787
G1 X132.59 Y135.71 E.00447
G1 X132.29 Y135.71 E.00894
G1 X132.29 Y135.56 E.00447
G1 X131.84 Y135.56 E.0134
G1 X131.84 Y135.41 E.00447
G1 X131.69 Y135.41 E.00447
G1 X131.69 Y135.26 E.00447
G1 X131.39 Y135.26 E.00894
G1 X131.39 Y135.11 E.00447
G1 X131.24 Y135.11 E.00447
G1 X131.24 Y134.96 E.00447
G1 X130.94 Y134.96 E.00894
G1 X130.94 Y134.81 E.00447
G1 X130.79 Y134.81 E.00447
G1 X130.79 Y134.66 E.00447
G1 X130.64 Y134.66 E.00447
G1 X130.64 Y134.51 E.00447
G1 X130.49 Y134.51 E.00447
G1 X130.49 Y134.36 E.00447
G1 X130.34 Y134.36 E.00447
G1 X130.34 Y134.21 E.00447
G1 X130.19 Y134.21 E.00447
G1 X130.19 Y134.06 E.00447
G1 X130.04 Y134.06 E.00447
G1 X130.04 Y133.91 E.00447
G1 X129.89 Y133.91 E.00447
G1 X129.89 Y133.76 E.00447
G1 X129.74 Y133.76 E.00447
G1 X129.74 Y133.46 E.00894
G1 X129.59 Y133.46 E.00447
G1 X129.59 Y133.31 E.00447
G1 X129.44 Y133.31 E.00447
G1 X129.44 Y133.01 E.00894
G1 X129.29 Y133.01 E.00447
G1 X129.29 Y132.71 E.00894
G1 X129.14 Y132.71 E.00447
G1 X129.14 Y132.56 E.00447
G1 X128.99 Y132.56 E.00447
G1 X128.99 Y132.26 E.00894
G1 X128.84 Y132.26 E.00447
G1 X128.84 Y131.81 E.0134
G1 X128.69 Y131.81 E.00447
G1 X128.69 Y131.66 E.00447
G1 X128.66 Y131.66 E.00089
G1 X128.66 Y131.81 E.00447
G1 X126.74 Y131.81 E.05719
G1 X126.74 Y131.66 E.00447
G1 X126.29 Y131.66 E.0134
G1 X126.29 Y131.51 E.00447
G1 X125.99 Y131.51 E.00894
G1 X125.99 Y131.36 E.00447
G1 X125.84 Y131.36 E.00447
G1 X125.84 Y131.21 E.00447
G1 X125.54 Y131.21 E.00894
G1 X125.54 Y131.09 E.00357
M204 S10000
G1 X125.675 Y131.556 F36000
; FEATURE: Gap infill
; LINE_WIDTH: 0.276054
G1 F3788
G2 X125.677 Y131.735 I1.468 J.075 E.0033
G1 X125.735 Y131.758 E.00116
; LINE_WIDTH: 0.215726
G1 X125.794 Y131.781 E.00086
; LINE_WIDTH: 0.19282
G1 X126.094 Y131.781 E.00355
; WIPE_START
G1 F15000
G1 X125.794 Y131.781 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X132.041 Y136.166 Z1.4 F36000
G1 X132.46 Y136.459 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Top surface
; LINE_WIDTH: 0.42
G1 F3788
M204 S2000
G1 X131.768 Y135.767 E.02915
; WIPE_START
G1 F9547.055
M204 S10000
G1 X132.46 Y136.459 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.083 Y133.082 Z1.4 F36000
G1 Z1
G1 E.8 F1800
G1 F3788
M204 S2000
G1 X128.018 Y132.017 E.04485
G1 X127.884 Y131.884
G1 X127.351 Y131.884
G1 X127.485 Y132.017
G1 X132.35 Y136.883 E.20495
G1 X132.484 Y137.016
G1 X132.1 Y137.166
G1 X131.967 Y137.033
G1 X126.951 Y132.017 E.21127
G1 X126.818 Y131.884
G1 X126.168 Y131.767
G1 X126.301 Y131.901
G1 X131.583 Y137.183 E.2225
G1 X131.717 Y137.316
M73 P97 R0
G1 X131.334 Y137.466
G1 X131.2 Y137.333
G1 X125.952 Y132.085 E.22106
G1 X125.819 Y131.951
G1 X125.368 Y132.034
G1 X125.502 Y132.167
G1 X130.817 Y137.483 E.2239
G1 X130.95 Y137.616
G1 X130.566 Y137.765
G1 X130.433 Y137.632
G1 X125.417 Y132.616 E.21127
G1 X125.284 Y132.483
G1 X125.284 Y133.016
G1 X125.417 Y133.15
G1 X129.9 Y137.633 E.18884
G1 X130.034 Y137.766
G1 X129.651 Y137.916
G1 X129.517 Y137.783
G1 X125.567 Y133.833 E.16638
G1 X125.434 Y133.699
G1 X125.734 Y134.533
G1 X125.867 Y134.666
G1 X128.984 Y137.783 E.13128
G1 X129.117 Y137.916
G1 X128.584 Y137.916
G1 X128.451 Y137.783
G1 X126.167 Y135.499 E.09618
; WIPE_START
G1 F9547.055
M204 S10000
G1 X127.582 Y136.914 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.792 Y136.451 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; FEATURE: Gap infill
; LINE_WIDTH: 0.129167
G1 F3788
G1 X126.449 Y136.108 E.00331
G1 X126.942 Y136.601 F36000
G1 F3788
G1 X126.449 Y136.108 E.00475
; WIPE_START
G1 F15000
G1 X126.942 Y136.601 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X127.216 Y137.051 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.262419
G1 F3788
G2 X126.899 Y136.734 I-.423 J.106 E.00817
; WIPE_START
G1 F15000
G1 X127.049 Y136.796 E-.26055
G1 X127.154 Y136.901 E-.2389
G1 X127.216 Y137.051 E-.26055
; WIPE_END
G1 E-.04 F1800
G1 X127.692 Y137.351 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.129167
G1 F3788
G1 X127.349 Y137.008 E.00331
; WIPE_START
G1 F15000
G1 X127.692 Y137.351 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X126.174 Y135.492 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.158447
G1 F3788
G1 X126.206 Y135.366 E.00119
; LINE_WIDTH: 0.187678
G1 X125.999 Y135.213 E.00295
; WIPE_START
G1 F15000
G1 X126.206 Y135.366 E-.76
; WIPE_END
G1 E-.04 F1800
G1 X129.251 Y133.398 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.172085
G1 F3788
G1 X129.04 Y133.215 E.00285
G1 X129.085 Y133.079 E.00146
; WIPE_START
G1 F15000
G1 X129.04 Y133.215 E-.25795
G1 X129.251 Y133.398 E-.50205
; WIPE_END
G1 E-.04 F1800
G1 X131.684 Y135.851 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.182866
G1 F3788
G1 X131.051 Y135.218 E.00989
G1 X131.771 Y135.764 F36000
; LINE_WIDTH: 0.174375
G1 F3788
G1 X131.635 Y135.81 E.00149
G1 X131.194 Y135.299 E.00701
; WIPE_START
G1 F15000
G1 X131.635 Y135.81 E-.62668
G1 X131.771 Y135.764 E-.13332
; WIPE_END
G1 E-.04 F1800
G1 X132.519 Y136.201 Z1.4 F36000
G1 Z1
G1 E.8 F1800
; LINE_WIDTH: 0.113886
G1 F3788
G1 X132.216 Y135.899 E.0024
G1 X132.91 Y136.325 F36000
; LINE_WIDTH: 0.335436
G1 F3788
G1 X132.952 Y136.325 E.00097
; LINE_WIDTH: 0.299052
G1 X132.994 Y136.325 E.00085
; LINE_WIDTH: 0.279183
G1 X133.175 Y136.325 E.00338
G1 X133.191 Y136.309 E.00041
; LINE_WIDTH: 0.234315
G1 X133.206 Y136.294 E.00033
; LINE_WIDTH: 0.196815
G1 X133.25 Y136.272 E.0006
; LINE_WIDTH: 0.152845
G1 X133.294 Y136.25 E.00043
; LINE_WIDTH: 0.13086
G1 X133.444 Y136.25 E.00104
G1 X132.91 Y136.325 F36000
; LINE_WIDTH: 0.355849
G1 F3788
G1 X132.868 Y136.325 E.00104
G2 X132.844 Y136.594 I.666 J.194 E.00672
; WIPE_START
G1 F11504.229
G1 X132.844 Y136.444 E-.36375
G1 X132.868 Y136.325 E-.29413
G1 X132.91 Y136.325 E-.10212
; WIPE_END
G1 E-.04 F1800
G1 X125.535 Y138.293 Z1.4 F36000
G1 X123.86 Y138.74 Z1.4
G1 Z1
G1 E.8 F1800
; FEATURE: Outer wall
; LINE_WIDTH: 0.42
G1 F3788
M204 S6000
G1 X124.19 Y138.74 E.00983
G1 X124.19 Y138.71 E.00089
G1 X123.89 Y138.71 E.00894
M204 S250
M73 P98 R0
G1 X124.49 Y138.86 F36000
G1 F3788
M204 S6000
G1 X124.31 Y138.86 E.00536
G1 X124.31 Y138.89 E.00089
G1 X124.46 Y138.89 E.00447
M204 S250
G1 X124.94 Y139.01 F36000
G1 F3788
M204 S6000
G1 X124.76 Y139.01 E.00536
G1 X124.76 Y139.04 E.00089
G1 X124.91 Y139.04 E.00447
M204 S250
G1 X125.51 Y139.16 F36000
G1 F3788
M204 S6000
G1 X125.51 Y139.19 E.00089
G1 X125.54 Y139.19 E.00089
; WIPE_START
G1 F9547.055
M204 S10000
G1 X125.51 Y139.19 E-.37987
G1 X125.54 Y139.19 E-.37987
G1 X125.54 Y139.19 E-.00025
; WIPE_END
G1 E-.04 F1800
G1 X120.183 Y133.753 Z1.4 F36000
G1 X115.46 Y128.96 Z1.4
G1 Z1
G1 E.8 F1800
G1 F3788
M204 S6000
G1 X115.46 Y129.59 E.01877
G1 X115.61 Y129.59 E.00447
G1 X115.61 Y130.34 E.02234
G1 X115.76 Y130.34 E.00447
G1 X115.76 Y130.79 E.0134
G1 X115.91 Y130.79 E.00447
G1 X115.91 Y131.24 E.0134
G1 X116.06 Y131.24 E.00447
G1 X116.06 Y131.69 E.0134
G1 X116.21 Y131.69 E.00447
G1 X116.21 Y131.99 E.00894
G1 X116.36 Y131.99 E.00447
G1 X116.36 Y132.29 E.00894
G1 X116.51 Y132.29 E.00447
G1 X116.51 Y132.59 E.00894
G1 X116.66 Y132.59 E.00447
G1 X116.66 Y132.89 E.00894
G1 X116.81 Y132.89 E.00447
G1 X116.81 Y133.19 E.00894
G1 X116.96 Y133.19 E.00447
G1 X116.96 Y133.49 E.00894
G1 X117.11 Y133.49 E.00447
G1 X117.11 Y133.64 E.00447
G1 X117.26 Y133.64 E.00447
G1 X117.26 Y133.94 E.00894
G1 X117.41 Y133.94 E.00447
G1 X117.41 Y134.09 E.00447
G1 X117.56 Y134.09 E.00447
G1 X117.56 Y134.39 E.00894
G1 X117.71 Y134.39 E.00447
G1 X117.71 Y134.54 E.00447
G1 X117.86 Y134.54 E.00447
G1 X117.86 Y134.69 E.00447
G1 X118.01 Y134.69 E.00447
G1 X118.01 Y134.99 E.00894
G1 X118.16 Y134.99 E.00447
G1 X118.16 Y135.14 E.00447
G1 X118.31 Y135.14 E.00447
G1 X118.31 Y135.29 E.00447
G1 X118.46 Y135.29 E.00447
G1 X118.46 Y135.44 E.00447
G1 X118.61 Y135.44 E.00447
G1 X118.61 Y135.59 E.00447
G1 X118.76 Y135.59 E.00447
G1 X118.76 Y135.74 E.00447
G1 X118.91 Y135.74 E.00447
G1 X118.91 Y135.89 E.00447
G1 X119.06 Y135.89 E.00447
G1 X119.06 Y136.04 E.00447
G1 X119.21 Y136.04 E.00447
G1 X119.21 Y136.19 E.00447
G1 X119.36 Y136.19 E.00447
G1 X119.36 Y136.34 E.00447
G1 X119.66 Y136.34 E.00894
G1 X119.66 Y136.49 E.00447
G1 X119.81 Y136.49 E.00447
G1 X119.81 Y136.64 E.00447
G1 X119.96 Y136.64 E.00447
G1 X119.96 Y136.79 E.00447
G1 X120.26 Y136.79 E.00894
G1 X120.26 Y136.94 E.00447
G1 X120.41 Y136.94 E.00447
G1 X120.41 Y137.09 E.00447
G1 X120.71 Y137.09 E.00894
G1 X120.71 Y137.24 E.00447
G1 X120.86 Y137.24 E.00447
G1 X120.86 Y137.39 E.00447
G1 X121.16 Y137.39 E.00894
G1 X121.16 Y137.54 E.00447
G1 X121.31 Y137.54 E.00447
G1 X121.31 Y137.69 E.00447
G1 X121.61 Y137.69 E.00894
G1 X121.61 Y137.84 E.00447
G1 X121.91 Y137.84 E.00894
G1 X121.91 Y137.99 E.00447
G1 X122.21 Y137.99 E.00894
G1 X122.21 Y138.14 E.00447
G1 X122.66 Y138.14 E.0134
G1 X122.66 Y138.29 E.00447
G1 X122.96 Y138.29 E.00894
G1 X122.96 Y138.44 E.00447
G1 X123.41 Y138.44 E.0134
G1 X123.41 Y138.59 E.00447
G1 X123.74 Y138.59 E.00983
G1 X123.74 Y138.56 E.00089
G1 X123.44 Y138.56 E.00894
G1 X123.44 Y138.41 E.00447
G1 X123.14 Y138.41 E.00894
G1 X123.14 Y138.26 E.00447
G1 X122.84 Y138.26 E.00894
G1 X122.84 Y138.11 E.00447
G1 X122.54 Y138.11 E.00894
G1 X122.54 Y137.96 E.00447
G1 X122.24 Y137.96 E.00894
G1 X122.24 Y137.81 E.00447
G1 X121.94 Y137.81 E.00894
G1 X121.94 Y137.66 E.00447
G1 X121.64 Y137.66 E.00894
G1 X121.64 Y137.51 E.00447
G1 X121.49 Y137.51 E.00447
G1 X121.49 Y137.36 E.00447
G1 X121.19 Y137.36 E.00894
G1 X121.19 Y137.21 E.00447
G1 X121.04 Y137.21 E.00447
G1 X121.04 Y137.06 E.00447
G1 X120.74 Y137.06 E.00894
G1 X120.74 Y136.91 E.00447
G1 X120.59 Y136.91 E.00447
G1 X120.59 Y136.76 E.00447
G1 X120.44 Y136.76 E.00447
G1 X120.44 Y136.61 E.00447
G1 X120.14 Y136.61 E.00894
G1 X120.14 Y136.46 E.00447
G1 X119.99 Y136.46 E.00447
G1 X119.99 Y136.31 E.00447
G1 X119.84 Y136.31 E.00447
G1 X119.84 Y136.16 E.00447
G1 X119.69 Y136.16 E.00447
G1 X119.69 Y136.01 E.00447
G1 X119.54 Y136.01 E.00447
G1 X119.54 Y135.86 E.00447
G1 X119.39 Y135.86 E.00447
G1 X119.39 Y135.71 E.00447
G1 X119.24 Y135.71 E.00447
G1 X119.24 Y135.56 E.00447
G1 X119.09 Y135.56 E.00447
G1 X119.09 Y135.41 E.00447
G1 X118.94 Y135.41 E.00447
G1 X118.94 Y135.26 E.00447
G1 X118.79 Y135.26 E.00447
G1 X118.79 Y135.11 E.00447
G1 X118.64 Y135.11 E.00447
G1 X118.64 Y134.96 E.00447
G1 X118.49 Y134.96 E.00447
G1 X118.49 Y134.81 E.00447
G1 X118.34 Y134.81 E.00447
G1 X118.34 Y134.66 E.00447
G1 X118.19 Y134.66 E.00447
G1 X118.19 Y134.51 E.00447
G1 X118.04 Y134.51 E.00447
G1 X118.04 Y134.21 E.00894
G1 X117.89 Y134.21 E.00447
G1 X117.89 Y134.06 E.00447
G1 X117.74 Y134.06 E.00447
G1 X117.74 Y133.91 E.00447
G1 X117.59 Y133.91 E.00447
G1 X117.59 Y133.61 E.00894
G1 X117.44 Y133.61 E.00447
G1 X117.44 Y133.46 E.00447
G1 X117.29 Y133.46 E.00447
G1 X117.29 Y133.16 E.00894
G1 X117.14 Y133.16 E.00447
G1 X117.14 Y133.01 E.00447
G1 X116.99 Y133.01 E.00447
G1 X116.99 Y132.71 E.00894
G1 X116.84 Y132.71 E.00447
G1 X116.84 Y132.56 E.00447
G1 X116.69 Y132.56 E.00447
G1 X116.69 Y132.26 E.00894
G1 X116.54 Y132.26 E.00447
G1 X116.54 Y131.81 E.0134
G1 X116.39 Y131.81 E.00447
G1 X116.39 Y131.51 E.00894
G1 X116.24 Y131.51 E.00447
G1 X116.24 Y131.21 E.00894
G1 X116.09 Y131.21 E.00447
G1 X116.09 Y130.91 E.00894
G1 X115.94 Y130.91 E.00447
G1 X115.94 Y130.46 E.0134
G1 X115.79 Y130.46 E.00447
G1 X115.79 Y130.01 E.0134
G1 X115.64 Y130.01 E.00447
G1 X115.64 Y129.56 E.0134
G1 X115.49 Y129.56 E.00447
G1 X115.49 Y128.99 E.01698
M204 S250
G1 X115.31 Y128.36 F36000
G1 F3788
M204 S6000
G1 X115.31 Y128.54 E.00536
G1 X115.34 Y128.54 E.00089
G1 X115.34 Y128.39 E.00447
; close powerlost recovery
M1003 S0
; WIPE_START
G1 F9547.055
M204 S10000
G1 X115.31 Y128.54 E-.34915
G1 X115.34 Y128.54 E-.06849
G1 X115.34 Y128.39 E-.34237
; WIPE_END
G1 E-.04 F1800
G17
G3 Z1.4 I1.217 J0 P1  F36000
M106 S0
M106 P2 S0
M981 S0 P20000 ; close spaghetti detector
; FEATURE: Custom
; MACHINE_END_GCODE_START
; filament end gcode 

;======== P2S end gcode ==========
;===== 2026/05/18 =====
M400 ; wait for buffer to clear
G92 E0 ; zero the extruder
M211 Z1

G90
G1 Z1.4 F900 ; lower z a little
M1002 judge_flag timelapse_record_flag
M622 J1
    G150.3
    M400 ; wait all motion done
    M991 S0 P-1 ;end smooth timelapse at safe pos
    M400 S5 ;wait for last picture to be taken
M623  ;end of "timelapse_record_flag

G90
G1 Z11 F900 ; lower z a little

M140 S0 ; turn off bed
M106 S0 ; turn off fan
M106 P2 S0 ; turn off remote part cooling fan
M106 P3 S0 ; turn off chamber cooling fan
M106 P10 S0 ; turn off left aux fan

; pull back filament to AMS
M620 S65535
T65535
G150.1 F8000
M621 S65535

G150.3
M104 S0 ; turn off hotend
M400 ; wait all motion done
M17 S
M17 Z0.4 ; lower z motor current to reduce impact if there is something in the bottom

    
        G1 Z80.5 F600
        G1 Z78.5
    

M400 P100
M17 R ; restore z current


M220 S100  ; Reset feedrate magnitude
M201.2 K1.0 ; Reset acc magnitude
M73.2 R1.0 ;Reset left time magnitude
M1002 set_gcode_claim_speed_level : 0

M1015.3 S0 ;disable clog detect
M1015.4 S0 K0 ;disable air printing detect

;=====printer finish air purification=========
M622.1 S0
M1002 judge_flag print_finish_air_filt_flag

M622 J1
M1002 gcode_claim_action : 66
M145 P1
M106 P2 S255
M400 S180
M106 P2 S0
M623

M622 J2
M1002 gcode_claim_action : 66
M145 P0
M106 P3 S255
M400 S180
M106 P3 S0
M623
;=====printer finish air purification=========

;=====printer finish  sound=========
M17
M400 S1
M1006 S1
M1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 
M1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A53 B10 L50 C53 D10 M50 E53 F10 N50 
M1006 A57 B10 L50 C57 D10 M50 E57 F10 N50 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A48 B10 L50 C48 D10 M50 E48 F10 N50 
M1006 A0 B15 L0 C0 D15 M0 E0 F15 N0 
M1006 A60 B10 L50 C60 D10 M50 E60 F10 N50 
M1006 W
;=====printer finish  sound=========
M400
M18
M73 P100 R0
; EXECUTABLE_BLOCK_END

