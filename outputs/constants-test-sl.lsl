/*
constants-test.lsl.in - This is a LSL2dfg.py input file for the constantvalues.py output module

(C) Copyright 2013 Sei Lisa.
Sei Lisa is the author's username in the Second Life online virtual world.

This file is part of LSL2 Derived Files Generator.

   LSL2 Derived Files Generator is free software: you can redistribute it
   and/or modify it under the terms of the GNU Lesser General Public License
   as published by the Free Software Foundation, either version 3 of the
   License, or (at your option) any later version.

   LSL2 Derived Files Generator is distributed in the hope that it will be
   useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU Lesser General Public License for more details.

   You should have received a copy of the GNU Lesser General Public License
   along with LSL2 Derived Files Generator. If not, see
   <http://www.gnu.org/licenses/>.

Second Life is a trademark of Linden Research, Inc.


This script checks the values of the actual constants against those reported
by the database. In case of mismatch, an error is reported together with the
line number of the line that produced it. The function c() does the actual
check. Parameter is a strided list containing any number of pairs with this
structure:

  database value, actual value

Example:
  c([
  0,FALSE
  ,1,TRUE
  ,"00000000-0000-0000-0000-000000000000",NULL_KEY
  ,<0.0, 0.0, 0.0>,ZERO_VECTOR
  ]);

The variable "line" is initialized to the line where the LSL KEYWORDS hook is,
plus one, following the viewer's editor line numbering convention that the
first line is line 0, rather than the customary one where the first line is 1.
Errors are reported using a line number that follows that same convention.
*/

integer errors;
integer line;
string outp;

c(list elements)
{
    integer i;
    integer nparams = llGetListLength(elements);
    ++line;
    while (i < nparams)
    {
        integer typ = llGetListEntryType(elements, i);
        if (typ != llGetListEntryType(elements, i+1))
        {
            errors = TRUE;
            outp += "\nType mismatch in line " + (string)line + ": type in database is " + (string)llGetListEntryType(elements, i+1) + ", should be " + (string)typ;
        }
        else if (typ == TYPE_FLOAT)
        {
            if (llList2Float(elements, i) != llList2Float(elements, i+1))
            {
                errors = TRUE;
                outp += "\nFloat constant value mismatch in line " + (string)line;
            }
        }
        else if (typ == TYPE_VECTOR)
        {
            if (llList2Vector(elements, i) != llList2Vector(elements, i+1))
            {
                errors = TRUE;
                outp += "\nVector constant value mismatch in line " + (string)line;
            }
        }
        else if (typ == TYPE_ROTATION)
        {
            if (llList2Rot(elements, i) != llList2Rot(elements, i+1))
            {
                errors = TRUE;
                outp += "\nRotation constant value mismatch in line " + (string)line;
            }
        }
        // The rest transform to string losslessly
        else if (llList2String(elements, i) != llList2String(elements, i+1))
        {
                errors = TRUE;
                outp += "\nConstant value mismatch in line " + (string)line;
        }
        i+=2;
        ++line;
    }
    ++line;
}

default
{
    state_entry()
    {
        outp = "\nConstants test run on " + llGetDate() + " in " + llGetEnv("sim_channel") + " " + llGetEnv("sim_version");
        line = 107;
outp += "\nGenerated by LSL2 Derived Files Generator. Database version: 0.0.20140625000; output module version: 0.0.20140625000";
c([
1,TRUE
,0,FALSE
,0x1,STATUS_PHYSICS
,0x10,STATUS_PHANTOM
,0x2,STATUS_ROTATE_X
,0x4,STATUS_ROTATE_Y
,0x8,STATUS_ROTATE_Z
,0x20,STATUS_SANDBOX
,0x40,STATUS_BLOCK_GRAB
,0x400,STATUS_BLOCK_GRAB_OBJECT
,0x80,STATUS_DIE_AT_EDGE
,0x100,STATUS_RETURN_AT_EDGE
,0x200,STATUS_CAST_SHADOWS
,0x1,AGENT
,0x10,AGENT_BY_USERNAME
,0x1,AGENT_BY_LEGACY_NAME
,0x2,ACTIVE
,0x4,PASSIVE
,0x8,SCRIPTED
,0x1,CONTROL_FWD
]);
c([
0x2,CONTROL_BACK
,0x4,CONTROL_LEFT
,0x8,CONTROL_RIGHT
,0x100,CONTROL_ROT_LEFT
,0x200,CONTROL_ROT_RIGHT
,0x10,CONTROL_UP
,0x20,CONTROL_DOWN
,0x10000000,CONTROL_LBUTTON
,0x40000000,CONTROL_ML_LBUTTON
,0x2,PERMISSION_DEBIT
,0x4,PERMISSION_TAKE_CONTROLS
,0x8,PERMISSION_REMAP_CONTROLS
,0x10,PERMISSION_TRIGGER_ANIMATION
,0x20,PERMISSION_ATTACH
,0x40,PERMISSION_RELEASE_OWNERSHIP
,0x80,PERMISSION_CHANGE_LINKS
,0x100,PERMISSION_CHANGE_JOINTS
,0x200,PERMISSION_CHANGE_PERMISSIONS
,0x400,PERMISSION_TRACK_CAMERA
,0x800,PERMISSION_CONTROL_CAMERA
]);
c([
0x1000,PERMISSION_TELEPORT
,0x4000,PERMISSION_SILENT_ESTATE_MANAGEMENT
,0x8000,PERMISSION_OVERRIDE_ANIMATIONS
,0x10000,PERMISSION_RETURN_OBJECTS
,0x7FFFFFFF,DEBUG_CHANNEL
,0,PUBLIC_CHANNEL
,0x1,AGENT_FLYING
,0x2,AGENT_ATTACHMENTS
,0x4,AGENT_SCRIPTED
,0x10,AGENT_SITTING
,0x20,AGENT_ON_OBJECT
,0x8,AGENT_MOUSELOOK
,0x40,AGENT_AWAY
,0x80,AGENT_WALKING
,0x100,AGENT_IN_AIR
,0x200,AGENT_TYPING
,0x400,AGENT_CROUCHING
,0x800,AGENT_BUSY
,0x1000,AGENT_ALWAYS_RUN
,0x2000,AGENT_AUTOPILOT
]);
c([
1,AGENT_LIST_PARCEL
,2,AGENT_LIST_PARCEL_OWNER
,4,AGENT_LIST_REGION
,0,PSYS_PART_FLAGS
,1,PSYS_PART_START_COLOR
,2,PSYS_PART_START_ALPHA
,5,PSYS_PART_START_SCALE
,3,PSYS_PART_END_COLOR
,4,PSYS_PART_END_ALPHA
,6,PSYS_PART_END_SCALE
,7,PSYS_PART_MAX_AGE
,0x1,PSYS_PART_INTERP_COLOR_MASK
,0x2,PSYS_PART_INTERP_SCALE_MASK
,0x4,PSYS_PART_BOUNCE_MASK
,0x8,PSYS_PART_WIND_MASK
,0x10,PSYS_PART_FOLLOW_SRC_MASK
,0x20,PSYS_PART_FOLLOW_VELOCITY_MASK
,0x40,PSYS_PART_TARGET_POS_MASK
,0x80,PSYS_PART_TARGET_LINEAR_MASK
,0x100,PSYS_PART_EMISSIVE_MASK
]);
c([
0x400,PSYS_PART_RIBBON_MASK
,9,PSYS_SRC_PATTERN
,0,PSYS_PART_BF_ONE
,1,PSYS_PART_BF_ZERO
,2,PSYS_PART_BF_DEST_COLOR
,3,PSYS_PART_BF_SOURCE_COLOR
,4,PSYS_PART_BF_ONE_MINUS_DEST_COLOR
,5,PSYS_PART_BF_ONE_MINUS_SOURCE_COLOR
,7,PSYS_PART_BF_SOURCE_ALPHA
,9,PSYS_PART_BF_ONE_MINUS_SOURCE_ALPHA
,10,PSYS_SRC_INNERANGLE
,11,PSYS_SRC_OUTERANGLE
,22,PSYS_SRC_ANGLE_BEGIN
,23,PSYS_SRC_ANGLE_END
,13,PSYS_SRC_BURST_RATE
,15,PSYS_SRC_BURST_PART_COUNT
,16,PSYS_SRC_BURST_RADIUS
,17,PSYS_SRC_BURST_SPEED_MIN
,18,PSYS_SRC_BURST_SPEED_MAX
,19,PSYS_SRC_MAX_AGE
]);
c([
8,PSYS_SRC_ACCEL
,12,PSYS_SRC_TEXTURE
,20,PSYS_SRC_TARGET_KEY
,21,PSYS_SRC_OMEGA
,1,PSYS_SRC_PATTERN_DROP
,2,PSYS_SRC_PATTERN_EXPLODE
,4,PSYS_SRC_PATTERN_ANGLE
,8,PSYS_SRC_PATTERN_ANGLE_CONE
,16,PSYS_SRC_PATTERN_ANGLE_CONE_EMPTY
,1,PSYS_SRC_OBJ_REL_MASK
,24,PSYS_PART_BLEND_FUNC_SOURCE
,25,PSYS_PART_BLEND_FUNC_DEST
,26,PSYS_PART_START_GLOW
,27,PSYS_PART_END_GLOW
,-1,OBJECT_UNKNOWN_DETAIL
,1,OBJECT_NAME
,2,OBJECT_DESC
,3,OBJECT_POS
,4,OBJECT_ROT
,5,OBJECT_VELOCITY
]);
c([
6,OBJECT_OWNER
,7,OBJECT_GROUP
,8,OBJECT_CREATOR
,9,OBJECT_RUNNING_SCRIPT_COUNT
,10,OBJECT_TOTAL_SCRIPT_COUNT
,11,OBJECT_SCRIPT_MEMORY
,12,OBJECT_SCRIPT_TIME
,13,OBJECT_PRIM_EQUIVALENCE
,16,OBJECT_PHYSICS_COST
,14,OBJECT_SERVER_COST
,15,OBJECT_STREAMING_COST
,17,OBJECT_CHARACTER_TIME
,18,OBJECT_ROOT
,19,OBJECT_ATTACHED_POINT
,20,OBJECT_PATHFINDING_TYPE
,24,OBJECT_RENDER_WEIGHT
,1,OPT_AVATAR
,2,OPT_CHARACTER
,6,OPT_EXCLUSION_VOLUME
,0,OPT_LEGACY_LINKSET
]);
c([
5,OPT_MATERIAL_VOLUME
,-1,OPT_OTHER
,4,OPT_STATIC_OBSTACLE
,3,OPT_WALKABLE
,0,VEHICLE_TYPE_NONE
,1,VEHICLE_TYPE_SLED
,2,VEHICLE_TYPE_CAR
,3,VEHICLE_TYPE_BOAT
,4,VEHICLE_TYPE_AIRPLANE
,5,VEHICLE_TYPE_BALLOON
,44,VEHICLE_REFERENCE_FRAME
,16,VEHICLE_LINEAR_FRICTION_TIMESCALE
,17,VEHICLE_ANGULAR_FRICTION_TIMESCALE
,18,VEHICLE_LINEAR_MOTOR_DIRECTION
,20,VEHICLE_LINEAR_MOTOR_OFFSET
,19,VEHICLE_ANGULAR_MOTOR_DIRECTION
,24,VEHICLE_HOVER_HEIGHT
,25,VEHICLE_HOVER_EFFICIENCY
,26,VEHICLE_HOVER_TIMESCALE
,27,VEHICLE_BUOYANCY
]);
c([
28,VEHICLE_LINEAR_DEFLECTION_EFFICIENCY
,29,VEHICLE_LINEAR_DEFLECTION_TIMESCALE
,30,VEHICLE_LINEAR_MOTOR_TIMESCALE
,31,VEHICLE_LINEAR_MOTOR_DECAY_TIMESCALE
,32,VEHICLE_ANGULAR_DEFLECTION_EFFICIENCY
,33,VEHICLE_ANGULAR_DEFLECTION_TIMESCALE
,34,VEHICLE_ANGULAR_MOTOR_TIMESCALE
,35,VEHICLE_ANGULAR_MOTOR_DECAY_TIMESCALE
,36,VEHICLE_VERTICAL_ATTRACTION_EFFICIENCY
,37,VEHICLE_VERTICAL_ATTRACTION_TIMESCALE
,38,VEHICLE_BANKING_EFFICIENCY
,39,VEHICLE_BANKING_MIX
,40,VEHICLE_BANKING_TIMESCALE
,0x1,VEHICLE_FLAG_NO_FLY_UP
,0x1,VEHICLE_FLAG_NO_DEFLECTION_UP
,0x2,VEHICLE_FLAG_LIMIT_ROLL_ONLY
,0x4,VEHICLE_FLAG_HOVER_WATER_ONLY
,0x8,VEHICLE_FLAG_HOVER_TERRAIN_ONLY
,0x10,VEHICLE_FLAG_HOVER_GLOBAL_HEIGHT
,0x20,VEHICLE_FLAG_HOVER_UP_ONLY
]);
c([
0x40,VEHICLE_FLAG_LIMIT_MOTOR_UP
,0x80,VEHICLE_FLAG_MOUSELOOK_STEER
,0x100,VEHICLE_FLAG_MOUSELOOK_BANK
,0x200,VEHICLE_FLAG_CAMERA_DECOUPLED
,0,CAMERA_PITCH
,1,CAMERA_FOCUS_OFFSET
,5,CAMERA_POSITION_LAG
,6,CAMERA_FOCUS_LAG
,7,CAMERA_DISTANCE
,8,CAMERA_BEHINDNESS_ANGLE
,9,CAMERA_BEHINDNESS_LAG
,10,CAMERA_POSITION_THRESHOLD
,11,CAMERA_FOCUS_THRESHOLD
,12,CAMERA_ACTIVE
,13,CAMERA_POSITION
,17,CAMERA_FOCUS
,21,CAMERA_POSITION_LOCKED
,22,CAMERA_FOCUS_LOCKED
,0,INVENTORY_TEXTURE
,1,INVENTORY_SOUND
]);
c([
6,INVENTORY_OBJECT
,10,INVENTORY_SCRIPT
,3,INVENTORY_LANDMARK
,5,INVENTORY_CLOTHING
,7,INVENTORY_NOTECARD
,13,INVENTORY_BODYPART
,20,INVENTORY_ANIMATION
,21,INVENTORY_GESTURE
,-1,INVENTORY_ALL
,-1,INVENTORY_NONE
,1,ATTACH_CHEST
,2,ATTACH_HEAD
,3,ATTACH_LSHOULDER
,4,ATTACH_RSHOULDER
,5,ATTACH_LHAND
,6,ATTACH_RHAND
,7,ATTACH_LFOOT
,8,ATTACH_RFOOT
,9,ATTACH_BACK
,10,ATTACH_PELVIS
]);
c([
11,ATTACH_MOUTH
,12,ATTACH_CHIN
,13,ATTACH_LEAR
,14,ATTACH_REAR
,15,ATTACH_LEYE
,16,ATTACH_REYE
,17,ATTACH_NOSE
,18,ATTACH_RUARM
,19,ATTACH_RLARM
,20,ATTACH_LUARM
,21,ATTACH_LLARM
,22,ATTACH_RHIP
,23,ATTACH_RULEG
,24,ATTACH_RLLEG
,25,ATTACH_LHIP
,26,ATTACH_LULEG
,27,ATTACH_LLLEG
,28,ATTACH_BELLY
,29,ATTACH_RPEC
,30,ATTACH_LPEC
]);
c([
29,ATTACH_LEFT_PEC
,30,ATTACH_RIGHT_PEC
,37,ATTACH_HUD_BOTTOM
,36,ATTACH_HUD_BOTTOM_LEFT
,38,ATTACH_HUD_BOTTOM_RIGHT
,35,ATTACH_HUD_CENTER_1
,31,ATTACH_HUD_CENTER_2
,33,ATTACH_HUD_TOP_CENTER
,34,ATTACH_HUD_TOP_LEFT
,32,ATTACH_HUD_TOP_RIGHT
,39,ATTACH_NECK
,40,ATTACH_AVATAR_CENTER
,0,LAND_LEVEL
,1,LAND_RAISE
,2,LAND_LOWER
,3,LAND_SMOOTH
,4,LAND_NOISE
,5,LAND_REVERT
,1,LAND_SMALL_BRUSH
,2,LAND_MEDIUM_BRUSH
]);
c([
3,LAND_LARGE_BRUSH
,8,DATA_PAYINFO
,1,DATA_ONLINE
,2,DATA_NAME
,3,DATA_BORN
,4,DATA_RATING
,5,DATA_SIM_POS
,6,DATA_SIM_STATUS
,7,DATA_SIM_RATING
,0x1,PAYMENT_INFO_ON_FILE
,0x2,PAYMENT_INFO_USED
,0x1,ANIM_ON
,0x2,LOOP
,0x4,REVERSE
,0x8,PING_PONG
,0x10,SMOOTH
,0x20,ROTATE
,0x40,SCALE
,-1,ALL_SIDES
,-1,LINK_SET
]);
c([
1,LINK_ROOT
,-2,LINK_ALL_OTHERS
,-3,LINK_ALL_CHILDREN
,-4,LINK_THIS
,0x1,CHANGED_INVENTORY
,0x2,CHANGED_COLOR
,0x4,CHANGED_SHAPE
,0x8,CHANGED_SCALE
,0x10,CHANGED_TEXTURE
,0x20,CHANGED_LINK
,0x40,CHANGED_ALLOWED_DROP
,0x80,CHANGED_OWNER
,0x100,CHANGED_REGION
,0x200,CHANGED_TELEPORT
,0x400,CHANGED_REGION_START
,0x800,CHANGED_MEDIA
,1,TYPE_INTEGER
,2,TYPE_FLOAT
,3,TYPE_STRING
,4,TYPE_KEY
]);
c([
5,TYPE_VECTOR
,6,TYPE_ROTATION
,0,TYPE_INVALID
,1,REMOTE_DATA_CHANNEL
,2,REMOTE_DATA_REQUEST
,3,REMOTE_DATA_REPLY
,9,PRIM_TYPE
,2,PRIM_MATERIAL
,3,PRIM_PHYSICS
,21,PRIM_FLEXIBLE
,23,PRIM_POINT_LIGHT
,4,PRIM_TEMP_ON_REZ
,5,PRIM_PHANTOM
,24,PRIM_CAST_SHADOWS
,6,PRIM_POSITION
,33,PRIM_POS_LOCAL
,7,PRIM_SIZE
,8,PRIM_ROTATION
,29,PRIM_ROT_LOCAL
,17,PRIM_TEXTURE
]);
c([
18,PRIM_COLOR
,19,PRIM_BUMP_SHINY
,20,PRIM_FULLBRIGHT
,22,PRIM_TEXGEN
,25,PRIM_GLOW
,26,PRIM_TEXT
,27,PRIM_NAME
,28,PRIM_DESC
,32,PRIM_OMEGA
,34,PRIM_LINK_TARGET
,30,PRIM_PHYSICS_SHAPE_TYPE
,35,PRIM_SLICE
,0,PRIM_TYPE_BOX
,1,PRIM_TYPE_CYLINDER
,2,PRIM_TYPE_PRISM
,3,PRIM_TYPE_SPHERE
,4,PRIM_TYPE_TORUS
,5,PRIM_TYPE_TUBE
,6,PRIM_TYPE_RING
,7,PRIM_TYPE_SCULPT
]);
c([
0x0,PRIM_HOLE_DEFAULT
,0x20,PRIM_HOLE_SQUARE
,0x10,PRIM_HOLE_CIRCLE
,0x30,PRIM_HOLE_TRIANGLE
,0,PRIM_MATERIAL_STONE
,1,PRIM_MATERIAL_METAL
,2,PRIM_MATERIAL_GLASS
,3,PRIM_MATERIAL_WOOD
,4,PRIM_MATERIAL_FLESH
,5,PRIM_MATERIAL_PLASTIC
,6,PRIM_MATERIAL_RUBBER
,7,PRIM_MATERIAL_LIGHT
,0,PRIM_SHINY_NONE
,1,PRIM_SHINY_LOW
,2,PRIM_SHINY_MEDIUM
,3,PRIM_SHINY_HIGH
,0,PRIM_BUMP_NONE
,1,PRIM_BUMP_BRIGHT
,2,PRIM_BUMP_DARK
,3,PRIM_BUMP_WOOD
]);
c([
4,PRIM_BUMP_BARK
,5,PRIM_BUMP_BRICKS
,6,PRIM_BUMP_CHECKER
,7,PRIM_BUMP_CONCRETE
,8,PRIM_BUMP_TILE
,9,PRIM_BUMP_STONE
,10,PRIM_BUMP_DISKS
,11,PRIM_BUMP_GRAVEL
,12,PRIM_BUMP_BLOBS
,13,PRIM_BUMP_SIDING
,14,PRIM_BUMP_LARGETILE
,15,PRIM_BUMP_STUCCO
,16,PRIM_BUMP_SUCTION
,17,PRIM_BUMP_WEAVE
,0,PRIM_TEXGEN_DEFAULT
,1,PRIM_TEXGEN_PLANAR
,1,PRIM_SCULPT_TYPE_SPHERE
,2,PRIM_SCULPT_TYPE_TORUS
,3,PRIM_SCULPT_TYPE_PLANE
,4,PRIM_SCULPT_TYPE_CYLINDER
]);
c([
7,PRIM_SCULPT_TYPE_MASK
,0x40,PRIM_SCULPT_FLAG_INVERT
,0x80,PRIM_SCULPT_FLAG_MIRROR
,0,PRIM_PHYSICS_SHAPE_PRIM
,2,PRIM_PHYSICS_SHAPE_CONVEX
,1,PRIM_PHYSICS_SHAPE_NONE
,0x1,DENSITY
,0x2,FRICTION
,0x4,RESTITUTION
,0x8,GRAVITY_MULTIPLIER
,0,MASK_BASE
,1,MASK_OWNER
,2,MASK_GROUP
,3,MASK_EVERYONE
,4,MASK_NEXT
,0x00002000,PERM_TRANSFER
,0x00004000,PERM_MODIFY
,0x00008000,PERM_COPY
,0x00080000,PERM_MOVE
,0x7FFFFFFF,PERM_ALL
]);
c([
0,PARCEL_MEDIA_COMMAND_STOP
,1,PARCEL_MEDIA_COMMAND_PAUSE
,2,PARCEL_MEDIA_COMMAND_PLAY
,3,PARCEL_MEDIA_COMMAND_LOOP
,13,PARCEL_MEDIA_COMMAND_LOOP_SET
,4,PARCEL_MEDIA_COMMAND_TEXTURE
,5,PARCEL_MEDIA_COMMAND_URL
,10,PARCEL_MEDIA_COMMAND_TYPE
,12,PARCEL_MEDIA_COMMAND_DESC
,6,PARCEL_MEDIA_COMMAND_TIME
,11,PARCEL_MEDIA_COMMAND_SIZE
,7,PARCEL_MEDIA_COMMAND_AGENT
,8,PARCEL_MEDIA_COMMAND_UNLOAD
,9,PARCEL_MEDIA_COMMAND_AUTO_ALIGN
,-1,PAY_HIDE
,-2,PAY_DEFAULT
,2,LIST_STAT_MAX
,1,LIST_STAT_MIN
,3,LIST_STAT_MEAN
,4,LIST_STAT_MEDIAN
]);
c([
5,LIST_STAT_STD_DEV
,6,LIST_STAT_SUM
,7,LIST_STAT_SUM_SQUARES
,8,LIST_STAT_NUM_COUNT
,9,LIST_STAT_GEOMETRIC_MEAN
,0,LIST_STAT_RANGE
,0x00000001,PARCEL_FLAG_ALLOW_FLY
,0x02000000,PARCEL_FLAG_ALLOW_GROUP_SCRIPTS
,0x00000002,PARCEL_FLAG_ALLOW_SCRIPTS
,0x00000008,PARCEL_FLAG_ALLOW_LANDMARK
,0x00000010,PARCEL_FLAG_ALLOW_TERRAFORM
,0x00000020,PARCEL_FLAG_ALLOW_DAMAGE
,0x00000040,PARCEL_FLAG_ALLOW_CREATE_OBJECTS
,0x04000000,PARCEL_FLAG_ALLOW_CREATE_GROUP_OBJECTS
,0x00000100,PARCEL_FLAG_USE_ACCESS_GROUP
,0x00000200,PARCEL_FLAG_USE_ACCESS_LIST
,0x00000400,PARCEL_FLAG_USE_BAN_LIST
,0x00000800,PARCEL_FLAG_USE_LAND_PASS_LIST
,0x00008000,PARCEL_FLAG_LOCAL_SOUND_ONLY
,0x00200000,PARCEL_FLAG_RESTRICT_PUSHOBJECT
]);
c([
0x08000000,PARCEL_FLAG_ALLOW_ALL_OBJECT_ENTRY
,0x10000000,PARCEL_FLAG_ALLOW_GROUP_OBJECT_ENTRY
,0x00000001,REGION_FLAG_ALLOW_DAMAGE
,0x00000010,REGION_FLAG_FIXED_SUN
,0x00000040,REGION_FLAG_BLOCK_TERRAFORM
,0x00000100,REGION_FLAG_SANDBOX
,0x00001000,REGION_FLAG_DISABLE_COLLISIONS
,0x00004000,REGION_FLAG_DISABLE_PHYSICS
,0x00080000,REGION_FLAG_BLOCK_FLY
,0x00100000,REGION_FLAG_ALLOW_DIRECT_TELEPORT
,0x00400000,REGION_FLAG_RESTRICT_PUSHOBJECT
,0,HTTP_METHOD
,1,HTTP_MIMETYPE
,2,HTTP_BODY_MAXLENGTH
,3,HTTP_VERIFY_CERT
,0,HTTP_BODY_TRUNCATED
,5,HTTP_CUSTOM_HEADER
,4,HTTP_VERBOSE_THROTTLE
,0,PARCEL_COUNT_TOTAL
,1,PARCEL_COUNT_OWNER
]);
c([
2,PARCEL_COUNT_GROUP
,3,PARCEL_COUNT_OTHER
,4,PARCEL_COUNT_SELECTED
,5,PARCEL_COUNT_TEMP
,0,PARCEL_DETAILS_NAME
,1,PARCEL_DETAILS_DESC
,2,PARCEL_DETAILS_OWNER
,3,PARCEL_DETAILS_GROUP
,4,PARCEL_DETAILS_AREA
,5,PARCEL_DETAILS_ID
,6,PARCEL_DETAILS_SEE_AVATARS
,0x1,STRING_TRIM_HEAD
,0x2,STRING_TRIM_TAIL
,0x3,STRING_TRIM
,0,CLICK_ACTION_NONE
,0,CLICK_ACTION_TOUCH
,1,CLICK_ACTION_SIT
,2,CLICK_ACTION_BUY
,3,CLICK_ACTION_PAY
,4,CLICK_ACTION_OPEN
]);
c([
5,CLICK_ACTION_PLAY
,6,CLICK_ACTION_OPEN_MEDIA
,-1,TOUCH_INVALID_FACE
,0,PRIM_MEDIA_ALT_IMAGE_ENABLE
,1,PRIM_MEDIA_CONTROLS
,2,PRIM_MEDIA_CURRENT_URL
,3,PRIM_MEDIA_HOME_URL
,4,PRIM_MEDIA_AUTO_LOOP
,5,PRIM_MEDIA_AUTO_PLAY
,6,PRIM_MEDIA_AUTO_SCALE
,7,PRIM_MEDIA_AUTO_ZOOM
,8,PRIM_MEDIA_FIRST_CLICK_INTERACT
,9,PRIM_MEDIA_WIDTH_PIXELS
,10,PRIM_MEDIA_HEIGHT_PIXELS
,11,PRIM_MEDIA_WHITELIST_ENABLE
,12,PRIM_MEDIA_WHITELIST
,13,PRIM_MEDIA_PERMS_INTERACT
,14,PRIM_MEDIA_PERMS_CONTROL
,14,PRIM_MEDIA_PARAM_MAX
,0,PRIM_MEDIA_CONTROLS_STANDARD
]);
c([
1,PRIM_MEDIA_CONTROLS_MINI
,0x0,PRIM_MEDIA_PERM_NONE
,0x1,PRIM_MEDIA_PERM_OWNER
,0x2,PRIM_MEDIA_PERM_GROUP
,0x4,PRIM_MEDIA_PERM_ANYONE
,1024,PRIM_MEDIA_MAX_URL_LENGTH
,1024,PRIM_MEDIA_MAX_WHITELIST_SIZE
,64,PRIM_MEDIA_MAX_WHITELIST_COUNT
,2048,PRIM_MEDIA_MAX_WIDTH_PIXELS
,2048,PRIM_MEDIA_MAX_HEIGHT_PIXELS
,0,STATUS_OK
,1000,STATUS_MALFORMED_PARAMS
,1001,STATUS_TYPE_MISMATCH
,1002,STATUS_BOUNDS_ERROR
,1003,STATUS_NOT_FOUND
,1004,STATUS_NOT_SUPPORTED
,1999,STATUS_INTERNAL_ERROR
,2001,STATUS_WHITELIST_FAILED
,0,CONTENT_TYPE_TEXT
,1,CONTENT_TYPE_HTML
]);
c([
2,CONTENT_TYPE_XML
,3,CONTENT_TYPE_XHTML
,4,CONTENT_TYPE_ATOM
,5,CONTENT_TYPE_JSON
,6,CONTENT_TYPE_LLSD
,7,CONTENT_TYPE_FORM
,8,CONTENT_TYPE_RSS
,0,KFM_COMMAND
,1,KFM_MODE
,2,KFM_DATA
,0,KFM_FORWARD
,1,KFM_LOOP
,2,KFM_PING_PONG
,3,KFM_REVERSE
,1,KFM_ROTATION
,2,KFM_TRANSLATION
,0,KFM_CMD_PLAY
,1,KFM_CMD_STOP
,2,KFM_CMD_PAUSE
,3,KFM_CMD_SET_MODE
]);
c([
0x4,ESTATE_ACCESS_ALLOWED_AGENT_ADD
,0x8,ESTATE_ACCESS_ALLOWED_AGENT_REMOVE
,0x10,ESTATE_ACCESS_ALLOWED_GROUP_ADD
,0x20,ESTATE_ACCESS_ALLOWED_GROUP_REMOVE
,0x40,ESTATE_ACCESS_BANNED_AGENT_ADD
,0x80,ESTATE_ACCESS_BANNED_AGENT_REMOVE
,0,PROFILE_NONE
,1,PROFILE_SCRIPT_MEMORY
,-1,RCERR_UNKNOWN
,-2,RCERR_SIM_PERF_LOW
,-3,RCERR_CAST_TIME_EXCEEDED
,0,RC_REJECT_TYPES
,1,RC_DETECT_PHANTOM
,2,RC_DATA_FLAGS
,3,RC_MAX_HITS
,0x1,RC_REJECT_AGENTS
,0x2,RC_REJECT_PHYSICAL
,0x4,RC_REJECT_NONPHYSICAL
,0x8,RC_REJECT_LAND
,0x1,RC_GET_NORMAL
]);
c([
0x2,RC_GET_ROOT_KEY
,0x4,RC_GET_LINK_NUM
,2,REQUIRE_LINE_OF_SIGHT
,3,PURSUIT_FUZZ_FACTOR
,4,PURSUIT_INTERCEPT
,5,PURSUIT_GOAL_TOLERANCE
,1,PURSUIT_OFFSET
,1,FORCE_DIRECT_PATH
,1,AVOID_CHARACTERS
,2,AVOID_DYNAMIC_OBSTACLES
,0,AVOID_NONE
,7,PU_EVADE_HIDDEN
,8,PU_EVADE_SPOTTED
,3,PU_FAILURE_INVALID_GOAL
,2,PU_FAILURE_INVALID_START
,6,PU_FAILURE_NO_VALID_DESTINATION
,1000000,PU_FAILURE_OTHER
,5,PU_FAILURE_TARGET_GONE
,4,PU_FAILURE_UNREACHABLE
,1,PU_GOAL_REACHED
]);
c([
0,PU_SLOWDOWN_DISTANCE_REACHED
,9,PU_FAILURE_NO_NAVMESH
,10,PU_FAILURE_DYNAMIC_PATHFINDING_DISABLED
,11,PU_FAILURE_PARCEL_UNREACHABLE
,7,TRAVERSAL_TYPE
,0,TRAVERSAL_TYPE_SLOW
,1,TRAVERSAL_TYPE_FAST
,2,TRAVERSAL_TYPE_NONE
,5,CHARACTER_AVOIDANCE_MODE
,1,CHARACTER_CMD_JUMP
,2,CHARACTER_CMD_SMOOTH_STOP
,0,CHARACTER_CMD_STOP
,1,CHARACTER_DESIRED_SPEED
,12,CHARACTER_DESIRED_TURN_SPEED
,3,CHARACTER_LENGTH
,8,CHARACTER_MAX_ACCEL
,9,CHARACTER_MAX_DECEL
,13,CHARACTER_MAX_SPEED
,10,CHARACTER_MAX_TURN_RADIUS
,4,CHARACTER_ORIENTATION
]);
c([
2,CHARACTER_RADIUS
,6,CHARACTER_TYPE
,0,CHARACTER_TYPE_A
,1,CHARACTER_TYPE_B
,2,CHARACTER_TYPE_C
,3,CHARACTER_TYPE_D
,4,CHARACTER_TYPE_NONE
,0,GCNP_RADIUS
,1,GCNP_STATIC
,1,HORIZONTAL
,0,VERTICAL
,0,PATROL_PAUSE_AT_WAYPOINTS
,0,WANDER_PAUSE_AT_WAYPOINTS
,14,CHARACTER_ACCOUNT_FOR_SKIPPED_FRAMES
,15,CHARACTER_STAY_WITHIN_PARCEL
,0,SIM_STAT_PCT_CHARS_STEPPED
,6,HTTP_PRAGMA_NO_CACHE
,21,OBJECT_PHYSICS
,22,OBJECT_PHANTOM
,23,OBJECT_TEMP_ON_REZ
]);
c([
-1,JSON_APPEND
,0x1,OBJECT_RETURN_PARCEL
,0x2,OBJECT_RETURN_PARCEL_OWNER
,0x4,OBJECT_RETURN_REGION
,-1,ERR_GENERIC
,-2,ERR_PARCEL_PERMISSIONS
,-3,ERR_MALFORMED_PARAMS
,-4,ERR_RUNTIME_PERMISSIONS
,-5,ERR_THROTTLED
,37,PRIM_NORMAL
,36,PRIM_SPECULAR
,38,PRIM_ALPHA_MODE
,0,PRIM_ALPHA_MODE_NONE
,1,PRIM_ALPHA_MODE_BLEND
,2,PRIM_ALPHA_MODE_MASK
,3,PRIM_ALPHA_MODE_EMISSIVE
,"00000000-0000-0000-0000-000000000000",NULL_KEY
,"\n\n\n",EOF
,"5748decc-f629-461c-9a36-a35a221fe21f",TEXTURE_BLANK
,"89556747-24cb-43ed-920b-47caed15465f",TEXTURE_DEFAULT
]);
c([
"8b5fec65-8d8d-9dc5-cda8-8fdf2716e361",TEXTURE_MEDIA
,"89556747-24cb-43ed-920b-47caed15465f",TEXTURE_PLYWOOD
,"8dcd4a48-2d37-4909-9f78-f7a9eb4ef903",TEXTURE_TRANSPARENT
,"URL_REQUEST_GRANTED",URL_REQUEST_GRANTED
,"URL_REQUEST_DENIED",URL_REQUEST_DENIED
,llUnescapeURL("%EF%B7%90"),JSON_INVALID
,llUnescapeURL("%EF%B7%91"),JSON_OBJECT
,llUnescapeURL("%EF%B7%92"),JSON_ARRAY
,llUnescapeURL("%EF%B7%93"),JSON_NUMBER
,llUnescapeURL("%EF%B7%94"),JSON_STRING
,llUnescapeURL("%EF%B7%95"),JSON_NULL
,llUnescapeURL("%EF%B7%96"),JSON_TRUE
,llUnescapeURL("%EF%B7%97"),JSON_FALSE
,llUnescapeURL("%EF%B7%98"),JSON_DELETE
,3.14159265,PI
,6.2831853,TWO_PI
,1.57079632,PI_BY_TWO
,0.017453292,DEG_TO_RAD
,57.295779,RAD_TO_DEG
,1.4142135,SQRT2
]);
c([
<0.0, 0.0, 0.0>,ZERO_VECTOR
,<-1.0, -1.0, 0.0>,TOUCH_INVALID_TEXCOORD
,<0.0, 0.0, 0.0>,TOUCH_INVALID_VECTOR
,<0.0, 0.0, 0.0, 1.0>,ZERO_ROTATION
]);
        if (errors)
            outp += "\nConstants test finished with errors.";
        else
            outp += "\nConstants test finished successfully.";
        llOwnerSay(outp);
    }
}
