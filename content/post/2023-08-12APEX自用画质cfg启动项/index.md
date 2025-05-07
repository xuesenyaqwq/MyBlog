---
title: APEX自用画质cfg/启动项
slug: 246
date: 2023-08-12
image: 20230812110138apex-legends-keyart457.jpg
categories:
    - 我得
tags:
    - APEX
    - CFG
    - 画质文件
---
### 画质CFG:

Win+R输入 `%USERPROFILE%\Saved Games\Respawn\Apex\local` \
找到`videoconfig.txt` \
复制粘贴：

```
"VideoConfig"
{
	"setting.cl_gib_allow"		"0"
	"setting.cl_particle_fallback_base"		"-999999"
	"setting.cl_particle_fallback_multiplier"		"-999999"
	"setting.cl_ragdoll_maxcount"		"0"
	"setting.cl_ragdoll_self_collision"		"0"
	"setting.mat_forceaniso"		"0"
	"setting.mat_mip_linear"		"0"
	"setting.stream_memory"		"0"
	"setting.mat_picmip"		"0"
	"setting.particle_cpu_level"		"0"
	"setting.r_createmodeldecals"		"0"
	"setting.r_decals"		"0"
	"setting.r_lod_switch_scale"		"0.300000"
	"setting.shadow_enable"		"0"
	"setting.shadow_depth_dimen_min"		"0"
	"setting.shadow_depth_upres_factor_max"		"0"
	"setting.shadow_maxdynamic"		"0"
	"setting.ssao_enabled"		"0"
	"setting.ssao_downsample"		"0"
	"setting.dvs_enable"		"0"
	"setting.dvs_gpuframetime_min"		"15000"
	"setting.dvs_gpuframetime_max"		"16500"
	"setting.last_display_width"		"2560"
	"setting.last_display_height"		"1440"
	"setting.nowindowborder"		"0"
	"setting.fullscreen"		"1"
	"setting.defaultres"		"2560"
	"setting.defaultresheight"		"1440"
	"setting.volumetric_lighting"		"0"
	"setting.volumetric_fog"		"2"
	"setting.mat_vsync_mode"		"0"
	"setting.mat_backbuffer_count"		"0"
	"setting.mat_antialias_mode"		"12"
	"setting.csm_enabled"		"0"
	"setting.csm_coverage"		"1"
	"setting.csm_cascade_res"		"0"
	"setting.fadeDistScale"		"1.000000"
	"setting.dvs_supersample_enable"		"0"
	"setting.new_shadow_settings"		"1"
	"setting.gamma"		"1.000000"
	"setting.configversion"		"7"
	"setting.dx_version_check_timestamp"		"0"
}
```
其中**2560**和**1440**为自己屏幕分辨率

### 启动项：
`+fps_max unlimited +miles_language english +cl_showpos "1" -freq 165 +mat_compressedtextures 1 -dxlevel 95`
>-freq 165 //165为自己屏幕刷新率
+miles_language english//修改语音为英文