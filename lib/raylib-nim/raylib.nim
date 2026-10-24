import std / [paths]

when not defined(windows):
  quit("This binding is Windows only")

const projectDir = currentSourcePath().Path.parentDir()
const raylibHeaderDir = projectDir / Path"include"

when defined(gcc):
  const lib = projectDir / Path"lib" / Path"windows" / Path"mingw-w64" / Path"libraylib.a"
  {.passL: lib.}
  {.passL: "-lopengl32 -lgdi32 -lwinmm -luser32 -lshell32".}
  {.passC: "-I" & raylibHeaderDir.string .}

when defined(vcc):
  const lib = projectDir / Path"lib" / Path"windows" / Path"msvc16" / Path"raylib.lib"
  {.passL: lib.}
  {.passL: "msvcrt.lib opengl32.lib gdi32.lib winmm.lib user32.lib shell32.lib".}
  {.passL: "/link /NODEFAULTLIB:LIBCMT".}
  {.passC: "/I" & raylibHeaderDir.string .}

type
# Vector2, 2 components
  Vector2* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    x*: float32 # Vector x component
    y*: float32 # Vector y component

# Vector3, 3 components
  Vector3* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    x*: float32 # Vector x component
    y*: float32 # Vector y component
    z*: float32 # Vector z component

# Vector4, 4 components
  Vector4* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    x*: float32 # Vector x component
    y*: float32 # Vector y component
    z*: float32 # Vector z component
    w*: float32 # Vector w component

# Matrix, 4x4 components, column major, OpenGL style, right-handed
  Matrix* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    m0*: float32 # Matrix first row (4 components)
    m4*: float32 # Matrix first row (4 components)
    m8*: float32 # Matrix first row (4 components)
    m12*: float32 # Matrix first row (4 components)
    m1*: float32 # Matrix second row (4 components)
    m5*: float32 # Matrix second row (4 components)
    m9*: float32 # Matrix second row (4 components)
    m13*: float32 # Matrix second row (4 components)
    m2*: float32 # Matrix third row (4 components)
    m6*: float32 # Matrix third row (4 components)
    m10*: float32 # Matrix third row (4 components)
    m14*: float32 # Matrix third row (4 components)
    m3*: float32 # Matrix fourth row (4 components)
    m7*: float32 # Matrix fourth row (4 components)
    m11*: float32 # Matrix fourth row (4 components)
    m15*: float32 # Matrix fourth row (4 components)

# Color, 4 components, R8G8B8A8 (32bit)
  Color* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    r*: uint8 # Color red value
    g*: uint8 # Color green value
    b*: uint8 # Color blue value
    a*: uint8 # Color alpha value

# Rectangle, 4 components
  Rectangle* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    x*: float32 # Rectangle top-left corner position x
    y*: float32 # Rectangle top-left corner position y
    width*: float32 # Rectangle width
    height*: float32 # Rectangle height

# Image, pixel data stored in CPU memory (RAM)
  Image* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    data*: pointer # Image raw data
    width*: int32 # Image base width
    height*: int32 # Image base height
    mipmaps*: int32 # Mipmap levels, 1 by default
    format*: int32 # Data format (PixelFormat type)

# Texture, tex data stored in GPU memory (VRAM)
  Texture* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    id*: uint32 # OpenGL texture id
    width*: int32 # Texture base width
    height*: int32 # Texture base height
    mipmaps*: int32 # Mipmap levels, 1 by default
    format*: int32 # Data format (PixelFormat type)

# RenderTexture, fbo for texture rendering
  RenderTexture* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    id*: uint32 # OpenGL framebuffer object id
    texture*: Texture # Color buffer attachment texture
    depth*: Texture # Depth buffer attachment texture

# NPatchInfo, n-patch layout info
  NPatchInfo* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    source*: Rectangle # Texture source rectangle
    left*: int32 # Left border offset
    top*: int32 # Top border offset
    right*: int32 # Right border offset
    bottom*: int32 # Bottom border offset
    layout*: int32 # Layout of the n-patch: 3x3, 1x3 or 3x1

# GlyphInfo, font characters glyphs info
  GlyphInfo* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    value*: int32 # Character value (Unicode)
    offsetX*: int32 # Character offset X when drawing
    offsetY*: int32 # Character offset Y when drawing
    advanceX*: int32 # Character advance position X
    image*: Image # Character image data

# Font, font texture and GlyphInfo array data
  Font* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    baseSize*: int32 # Base size (default chars height)
    glyphCount*: int32 # Number of glyph characters
    glyphPadding*: int32 # Padding around the glyph characters
    texture*: Texture2D # Texture atlas containing the glyphs
    recs*: ptr Rectangle # Rectangles in texture for the glyphs
    glyphs*: ptr GlyphInfo # Glyphs info data

# Camera, defines position/orientation in 3d space
  Camera3D* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    position*: Vector3 # Camera position
    target*: Vector3 # Camera target it looks-at
    up*: Vector3 # Camera up vector (rotation over its axis)
    fovy*: float32 # Camera field-of-view aperture in Y (degrees) in perspective, used as near plane height in world units in orthographic
    projection*: int32 # Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC

# Camera2D, defines position/orientation in 2d space
  Camera2D* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    offset*: Vector2 # Camera offset (screen space offset from window origin, unscaled by DPI, real pixel size)
    target*: Vector2 # Camera target (world space target point that is mapped to screen space offset)
    rotation*: float32 # Camera rotation in degrees (pivots around target)
    zoom*: float32 # Camera zoom (scaling around target), must not be set to 0, set to 1.0f for no scale

# Mesh, vertex data and vao/vbo
  Mesh* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    vertexCount*: int32 # Number of vertices stored in arrays
    triangleCount*: int32 # Number of triangles stored (indexed or not)
    vertices*: ptr float32 # Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    texcoords*: ptr float32 # Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords2*: ptr float32 # Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    normals*: ptr float32 # Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    tangents*: ptr float32 # Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    colors*: ptr uint8 # Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    indices*: ptr uint16 # Vertex indices (in case vertex data comes indexed)
    boneCount*: int32 # Number of bones (MAX: 256 bones)
    boneIndices*: ptr uint8 # Vertex bone indices, up to 4 bones influence by vertex (skinning) (shader-location = 6)
    boneWeights*: ptr float32 # Vertex bone weight, up to 4 bones influence by vertex (skinning) (shader-location = 7)
    animVertices*: ptr float32 # Animated vertex positions (after bones transformations)
    animNormals*: ptr float32 # Animated normals (after bones transformations)
    vaoId*: uint32 # OpenGL Vertex Array Object id
    vboId*: ptr uint32 # OpenGL Vertex Buffer Objects id (default vertex data)

# Shader
  Shader* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    id*: uint32 # Shader program id
    locs*: ptr int32 # Shader locations array (RL_MAX_SHADER_LOCATIONS)

# MaterialMap
  MaterialMap* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    texture*: Texture2D # Material map texture
    color*: Color # Material map color
    value*: float32 # Material map value

# Material, includes shader and maps
  Material* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    shader*: Shader # Material shader
    maps*: ptr MaterialMap # Material maps array (MAX_MATERIAL_MAPS)
    params*: array[4, float32] # Material generic parameters (if required)

# Transform, vertex transformation data
  Transform* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    translation*: Vector3 # Translation
    rotation*: Quaternion # Rotation
    scale*: Vector3 # Scale

# Bone, skeletal animation bone
  BoneInfo* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    name*: array[32, char] # Bone name
    parent*: int32 # Bone parent

# Skeleton, animation bones hierarchy
  ModelSkeleton* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    boneCount*: uint32 # Number of bones
    bones*: ptr BoneInfo # Bones information (skeleton)
    bindPose*: ModelAnimPose # Bones base transformation (Transform[])

# Model, meshes, materials and animation data
  Model* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    transform*: Matrix # Local transform matrix
    meshCount*: int32 # Number of meshes
    materialCount*: int32 # Number of materials
    meshes*: ptr Mesh # Meshes array
    materials*: ptr Material # Materials array
    meshMaterial*: ptr int32 # Mesh material number
    skeleton*: ModelSkeleton # Skeleton for animation
    currentPose*: ModelAnimPose # Current animation pose (Transform[])
    boneMatrices*: ptr Matrix # Bones animated transformation matrices

# ModelAnimation, contains a full animation sequence
  ModelAnimation* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    name*: array[32, char] # Animation name
    boneCount*: uint32 # Number of bones (per pose)
    keyframeCount*: int32 # Number of animation key frames
    keyframePoses*: ptr ModelAnimPose # Animation sequence keyframe poses [keyframe][pose]

# Ray, ray for raycasting
  Ray* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    position*: Vector3 # Ray position (origin)
    direction*: Vector3 # Ray direction (normalized)

# RayCollision, ray hit information
  RayCollision* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    hit*: bool # Did the ray hit something?
    distance*: float32 # Distance to the nearest hit
    point*: Vector3 # Point of the nearest hit
    normal*: Vector3 # Surface normal of hit

# BoundingBox
  BoundingBox* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    min*: Vector3 # Minimum vertex box-corner
    max*: Vector3 # Maximum vertex box-corner

# Wave, audio wave data
  Wave* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    frameCount*: uint32 # Total number of frames (considering channels)
    sampleRate*: uint32 # Frequency (samples per second)
    sampleSize*: uint32 # Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    channels*: uint32 # Number of channels (1-mono, 2-stereo, ...)
    data*: pointer # Buffer data pointer

# AudioStream, custom audio stream
  AudioStream* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    buffer*: ptr rAudioBuffer # Pointer to internal data used by the audio system
    processor*: ptr rAudioProcessor # Pointer to internal data processor, useful for audio effects
    sampleRate*: uint32 # Frequency (samples per second)
    sampleSize*: uint32 # Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    channels*: uint32 # Number of channels (1-mono, 2-stereo, ...)

# Sound
  Sound* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    stream*: AudioStream # Audio stream
    frameCount*: uint32 # Total number of frames (considering channels)

# Music, audio stream, anything longer than ~10 seconds should be streamed
  Music* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    stream*: AudioStream # Audio stream
    frameCount*: uint32 # Total number of frames (considering channels)
    looping*: bool # Music looping enable
    ctxType*: int32 # Type of music context (audio filetype)
    ctxData*: pointer # Audio context data, depends on type

# VrDeviceInfo, Head-Mounted-Display device parameters
  VrDeviceInfo* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    hResolution*: int32 # Horizontal resolution in pixels
    vResolution*: int32 # Vertical resolution in pixels
    hScreenSize*: float32 # Horizontal size in meters
    vScreenSize*: float32 # Vertical size in meters
    eyeToScreenDistance*: float32 # Distance between eye and display in meters
    lensSeparationDistance*: float32 # Lens separation distance in meters
    interpupillaryDistance*: float32 # IPD (distance between pupils) in meters
    lensDistortionValues*: array[4, float32] # Lens distortion constant parameters
    chromaAbCorrection*: array[4, float32] # Chromatic aberration correction parameters

# VrStereoConfig, VR stereo rendering configuration for simulator
  VrStereoConfig* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    projection*: array[2, Matrix] # VR projection matrices (per eye)
    viewOffset*: array[2, Matrix] # VR view offset matrices (per eye)
    leftLensCenter*: array[2, float32] # VR left lens center
    rightLensCenter*: array[2, float32] # VR right lens center
    leftScreenCenter*: array[2, float32] # VR left screen center
    rightScreenCenter*: array[2, float32] # VR right screen center
    scale*: array[2, float32] # VR distortion scale
    scaleIn*: array[2, float32] # VR distortion scale in

# File path list
  FilePathList* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    count*: uint32 # Filepaths entries count
    paths*: cstringArray # Filepaths entries

# Automation event
  AutomationEvent* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    frame*: uint32 # Event frame
    `type`*: uint32 # Event type (AutomationEventType)
    params*: array[4, int32] # Event parameters (if required)

# Automation event list
  AutomationEventList* {.completeStruct, bycopy, importc, header: "raylib.h".} = object
    capacity*: uint32 # Events max entries (MAX_AUTOMATION_EVENTS)
    count*: uint32 # Events entries count
    events*: ptr AutomationEvent # Events entries

# Opaque structs declaration
# NOTE: Actual structs are defined internally in raudio module
  rAudioBuffer* {.importc, nodecl, bycopy.} = object
  rAudioProcessor* {.importc, nodecl, bycopy.} = object

# Quaternion, 4 components (Vector4 alias)
  Quaternion* = Vector4

# Texture2D, same as Texture
  Texture2D* = Texture

# TextureCubemap, same as Texture
  TextureCubemap* = Texture

# RenderTexture2D, same as RenderTexture
  RenderTexture2D* = RenderTexture

# Camera type fallback, defaults to Camera3D
  Camera* = Camera3D

  ModelAnimPose* = ptr Transform


const RAYLIB_VERSION_MAJOR* = 6
const RAYLIB_VERSION_MINOR* = 2
const RAYLIB_VERSION_PATCH* = 0
const RAYLIB_VERSION* = "6.2"

const PI* = 3.141592653589793'f
const DEG2RAD* = (PI / 180.0'f)
const RAD2DEG* = (180.0'f / PI)

const LIGHTGRAY* = Color(r: 200, g: 200, b: 200, a: 255) # Light Gray
const GRAY* = Color(r: 130, g: 130, b: 130, a: 255) # Gray
const DARKGRAY* = Color(r: 80, g: 80, b: 80, a: 255) # Dark Gray
const YELLOW* = Color(r: 253, g: 249, b: 0, a: 255) # Yellow
const GOLD* = Color(r: 255, g: 203, b: 0, a: 255) # Gold
const ORANGE* = Color(r: 255, g: 161, b: 0, a: 255) # Orange
const PINK* = Color(r: 255, g: 109, b: 194, a: 255) # Pink
const RED* = Color(r: 230, g: 41, b: 55, a: 255) # Red
const MAROON* = Color(r: 190, g: 33, b: 55, a: 255) # Maroon
const GREEN* = Color(r: 0, g: 228, b: 48, a: 255) # Green
const LIME* = Color(r: 0, g: 158, b: 47, a: 255) # Lime
const DARKGREEN* = Color(r: 0, g: 117, b: 44, a: 255) # Dark Green
const SKYBLUE* = Color(r: 102, g: 191, b: 255, a: 255) # Sky Blue
const BLUE* = Color(r: 0, g: 121, b: 241, a: 255) # Blue
const DARKBLUE* = Color(r: 0, g: 82, b: 172, a: 255) # Dark Blue
const PURPLE* = Color(r: 200, g: 122, b: 255, a: 255) # Purple
const VIOLET* = Color(r: 135, g: 60, b: 190, a: 255) # Violet
const DARKPURPLE* = Color(r: 112, g: 31, b: 126, a: 255) # Dark Purple
const BEIGE* = Color(r: 211, g: 176, b: 131, a: 255) # Beige
const BROWN* = Color(r: 127, g: 106, b: 79, a: 255) # Brown
const DARKBROWN* = Color(r: 76, g: 63, b: 47, a: 255) # Dark Brown
const WHITE* = Color(r: 255, g: 255, b: 255, a: 255) # White
const BLACK* = Color(r: 0, g: 0, b: 0, a: 255) # Black
const BLANK* = Color(r: 0, g: 0, b: 0, a: 0) # Blank (Transparent)
const MAGENTA* = Color(r: 255, g: 0, b: 255, a: 255) # Magenta
const RAYWHITE* = Color(r: 245, g: 245, b: 245, a: 255) # My own White (raylib logo)

type
# System/Window config flags
  ConfigFlags* {.size: sizeof(int32).} = enum
    FLAG_VSYNC_HINT = 64 # Set to try enabling V-Sync on GPU
    FLAG_FULLSCREEN_MODE = 2 # Set to run program in fullscreen
    FLAG_WINDOW_RESIZABLE = 4 # Set to allow resizable window
    FLAG_WINDOW_UNDECORATED = 8 # Set to disable window decoration (frame and buttons)
    FLAG_WINDOW_HIDDEN = 128 # Set to hide window
    FLAG_WINDOW_MINIMIZED = 512 # Set to minimize window (iconify)
    FLAG_WINDOW_MAXIMIZED = 1024 # Set to maximize window (expanded to monitor)
    FLAG_WINDOW_UNFOCUSED = 2048 # Set to window non focused
    FLAG_WINDOW_TOPMOST = 4096 # Set to window always on top
    FLAG_WINDOW_ALWAYS_RUN = 256 # Set to allow windows running while minimized
    FLAG_WINDOW_TRANSPARENT = 16 # Set to allow transparent framebuffer
    FLAG_WINDOW_HIGHDPI = 8192 # Set to support HighDPI
    FLAG_WINDOW_MOUSE_PASSTHROUGH = 16384 # Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    FLAG_BORDERLESS_WINDOWED_MODE = 32768 # Set to run program in borderless windowed mode
    FLAG_MSAA_4X_HINT = 32 # Set to try enabling MSAA 4X
    FLAG_INTERLACED_HINT = 65536 # Set to try enabling interlaced video format (for V3D)

# Trace log level
  TraceLogLevel* {.size: sizeof(int32).} = enum
    LOG_ALL = 0 # Display all logs
    LOG_TRACE = 1 # Trace logging, intended for internal use only
    LOG_DEBUG = 2 # Debug logging, used for internal debugging, it should be disabled on release builds
    LOG_INFO = 3 # Info logging, used for program execution info
    LOG_WARNING = 4 # Warning logging, used on recoverable failures
    LOG_ERROR = 5 # Error logging, used on unrecoverable failures
    LOG_FATAL = 6 # Fatal logging, used to abort program: exit(EXIT_FAILURE)
    LOG_NONE = 7 # Disable logging

# Keyboard keys (US keyboard layout)
  KeyboardKey* {.size: sizeof(int32).} = enum
    KEY_NULL = 0 # Key: NULL, used for no key pressed
    KEY_APOSTROPHE = 39 # Key: '
    KEY_COMMA = 44 # Key: ,
    KEY_MINUS = 45 # Key: -
    KEY_PERIOD = 46 # Key: .
    KEY_SLASH = 47 # Key: /
    KEY_ZERO = 48 # Key: 0
    KEY_ONE = 49 # Key: 1
    KEY_TWO = 50 # Key: 2
    KEY_THREE = 51 # Key: 3
    KEY_FOUR = 52 # Key: 4
    KEY_FIVE = 53 # Key: 5
    KEY_SIX = 54 # Key: 6
    KEY_SEVEN = 55 # Key: 7
    KEY_EIGHT = 56 # Key: 8
    KEY_NINE = 57 # Key: 9
    KEY_SEMICOLON = 59 # Key: ;
    KEY_EQUAL = 61 # Key: =
    KEY_A = 65 # Key: A | a
    KEY_B = 66 # Key: B | b
    KEY_C = 67 # Key: C | c
    KEY_D = 68 # Key: D | d
    KEY_E = 69 # Key: E | e
    KEY_F = 70 # Key: F | f
    KEY_G = 71 # Key: G | g
    KEY_H = 72 # Key: H | h
    KEY_I = 73 # Key: I | i
    KEY_J = 74 # Key: J | j
    KEY_K = 75 # Key: K | k
    KEY_L = 76 # Key: L | l
    KEY_M = 77 # Key: M | m
    KEY_N = 78 # Key: N | n
    KEY_O = 79 # Key: O | o
    KEY_P = 80 # Key: P | p
    KEY_Q = 81 # Key: Q | q
    KEY_R = 82 # Key: R | r
    KEY_S = 83 # Key: S | s
    KEY_T = 84 # Key: T | t
    KEY_U = 85 # Key: U | u
    KEY_V = 86 # Key: V | v
    KEY_W = 87 # Key: W | w
    KEY_X = 88 # Key: X | x
    KEY_Y = 89 # Key: Y | y
    KEY_Z = 90 # Key: Z | z
    KEY_LEFT_BRACKET = 91 # Key: [
    KEY_BACKSLASH = 92 # Key: '\'
    KEY_RIGHT_BRACKET = 93 # Key: ]
    KEY_GRAVE = 96 # Key: `
    KEY_SPACE = 32 # Key: Space
    KEY_ESCAPE = 256 # Key: Esc
    KEY_ENTER = 257 # Key: Enter
    KEY_TAB = 258 # Key: Tab
    KEY_BACKSPACE = 259 # Key: Backspace
    KEY_INSERT = 260 # Key: Ins
    KEY_DELETE = 261 # Key: Del
    KEY_RIGHT = 262 # Key: Cursor right
    KEY_LEFT = 263 # Key: Cursor left
    KEY_DOWN = 264 # Key: Cursor down
    KEY_UP = 265 # Key: Cursor up
    KEY_PAGE_UP = 266 # Key: Page up
    KEY_PAGE_DOWN = 267 # Key: Page down
    KEY_HOME = 268 # Key: Home
    KEY_END = 269 # Key: End
    KEY_CAPS_LOCK = 280 # Key: Caps lock
    KEY_SCROLL_LOCK = 281 # Key: Scroll down
    KEY_NUM_LOCK = 282 # Key: Num lock
    KEY_PRINT_SCREEN = 283 # Key: Print screen
    KEY_PAUSE = 284 # Key: Pause
    KEY_F1 = 290 # Key: F1
    KEY_F2 = 291 # Key: F2
    KEY_F3 = 292 # Key: F3
    KEY_F4 = 293 # Key: F4
    KEY_F5 = 294 # Key: F5
    KEY_F6 = 295 # Key: F6
    KEY_F7 = 296 # Key: F7
    KEY_F8 = 297 # Key: F8
    KEY_F9 = 298 # Key: F9
    KEY_F10 = 299 # Key: F10
    KEY_F11 = 300 # Key: F11
    KEY_F12 = 301 # Key: F12
    KEY_LEFT_SHIFT = 340 # Key: Shift left
    KEY_LEFT_CONTROL = 341 # Key: Control left
    KEY_LEFT_ALT = 342 # Key: Alt left
    KEY_LEFT_SUPER = 343 # Key: Super left
    KEY_RIGHT_SHIFT = 344 # Key: Shift right
    KEY_RIGHT_CONTROL = 345 # Key: Control right
    KEY_RIGHT_ALT = 346 # Key: Alt right
    KEY_RIGHT_SUPER = 347 # Key: Super right
    KEY_KB_MENU = 348 # Key: KB menu
    KEY_KP_0 = 320 # Key: Keypad 0
    KEY_KP_1 = 321 # Key: Keypad 1
    KEY_KP_2 = 322 # Key: Keypad 2
    KEY_KP_3 = 323 # Key: Keypad 3
    KEY_KP_4 = 324 # Key: Keypad 4
    KEY_KP_5 = 325 # Key: Keypad 5
    KEY_KP_6 = 326 # Key: Keypad 6
    KEY_KP_7 = 327 # Key: Keypad 7
    KEY_KP_8 = 328 # Key: Keypad 8
    KEY_KP_9 = 329 # Key: Keypad 9
    KEY_KP_DECIMAL = 330 # Key: Keypad .
    KEY_KP_DIVIDE = 331 # Key: Keypad /
    KEY_KP_MULTIPLY = 332 # Key: Keypad *
    KEY_KP_SUBTRACT = 333 # Key: Keypad -
    KEY_KP_ADD = 334 # Key: Keypad +
    KEY_KP_ENTER = 335 # Key: Keypad Enter
    KEY_KP_EQUAL = 336 # Key: Keypad =
    KEY_BACK = 4 # Key: Android back button
    KEY_MENU = 5 # Key: Android menu button
    KEY_VOLUME_UP = 24 # Key: Android volume up button
    KEY_VOLUME_DOWN = 25 # Key: Android volume down button

# Mouse buttons
  MouseButton* {.size: sizeof(int32).} = enum
    MOUSE_BUTTON_LEFT = 0 # Mouse button left
    MOUSE_BUTTON_RIGHT = 1 # Mouse button right
    MOUSE_BUTTON_MIDDLE = 2 # Mouse button middle (pressed wheel)
    MOUSE_BUTTON_SIDE = 3 # Mouse button side (advanced mouse device)
    MOUSE_BUTTON_EXTRA = 4 # Mouse button extra (advanced mouse device)
    MOUSE_BUTTON_FORWARD = 5 # Mouse button forward (advanced mouse device)
    MOUSE_BUTTON_BACK = 6 # Mouse button back (advanced mouse device)

# Mouse cursor
  MouseCursor* {.size: sizeof(int32).} = enum
    MOUSE_CURSOR_DEFAULT = 0 # Default pointer shape
    MOUSE_CURSOR_ARROW = 1 # Arrow shape
    MOUSE_CURSOR_IBEAM = 2 # Text writing cursor shape
    MOUSE_CURSOR_CROSSHAIR = 3 # Cross shape
    MOUSE_CURSOR_POINTING_HAND = 4 # Pointing hand cursor
    MOUSE_CURSOR_RESIZE_EW = 5 # Horizontal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NS = 6 # Vertical resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NWSE = 7 # Top-left to bottom-right diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_NESW = 8 # The top-right to bottom-left diagonal resize/move arrow shape
    MOUSE_CURSOR_RESIZE_ALL = 9 # The omnidirectional resize/move cursor shape
    MOUSE_CURSOR_NOT_ALLOWED = 10 # The operation-not-allowed shape

# Gamepad buttons
  GamepadButton* {.size: sizeof(int32).} = enum
    GAMEPAD_BUTTON_UNKNOWN = 0 # Unknown button, for error checking
    GAMEPAD_BUTTON_LEFT_FACE_UP = 1 # Gamepad left DPAD up button
    GAMEPAD_BUTTON_LEFT_FACE_RIGHT = 2 # Gamepad left DPAD right button
    GAMEPAD_BUTTON_LEFT_FACE_DOWN = 3 # Gamepad left DPAD down button
    GAMEPAD_BUTTON_LEFT_FACE_LEFT = 4 # Gamepad left DPAD left button
    GAMEPAD_BUTTON_RIGHT_FACE_UP = 5 # Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
    GAMEPAD_BUTTON_RIGHT_FACE_RIGHT = 6 # Gamepad right button right (i.e. PS3: Circle, Xbox: B)
    GAMEPAD_BUTTON_RIGHT_FACE_DOWN = 7 # Gamepad right button down (i.e. PS3: Cross, Xbox: A)
    GAMEPAD_BUTTON_RIGHT_FACE_LEFT = 8 # Gamepad right button left (i.e. PS3: Square, Xbox: X)
    GAMEPAD_BUTTON_LEFT_TRIGGER_1 = 9 # Gamepad top/back trigger left (first), it could be a trailing button
    GAMEPAD_BUTTON_LEFT_TRIGGER_2 = 10 # Gamepad top/back trigger left (second), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_1 = 11 # Gamepad top/back trigger right (first), it could be a trailing button
    GAMEPAD_BUTTON_RIGHT_TRIGGER_2 = 12 # Gamepad top/back trigger right (second), it could be a trailing button
    GAMEPAD_BUTTON_MIDDLE_LEFT = 13 # Gamepad center buttons, left one (i.e. PS3: Select)
    GAMEPAD_BUTTON_MIDDLE = 14 # Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
    GAMEPAD_BUTTON_MIDDLE_RIGHT = 15 # Gamepad center buttons, right one (i.e. PS3: Start)
    GAMEPAD_BUTTON_LEFT_THUMB = 16 # Gamepad joystick pressed button left
    GAMEPAD_BUTTON_RIGHT_THUMB = 17 # Gamepad joystick pressed button right

# Gamepad axes
  GamepadAxis* {.size: sizeof(int32).} = enum
    GAMEPAD_AXIS_LEFT_X = 0 # Gamepad left stick X axis
    GAMEPAD_AXIS_LEFT_Y = 1 # Gamepad left stick Y axis
    GAMEPAD_AXIS_RIGHT_X = 2 # Gamepad right stick X axis
    GAMEPAD_AXIS_RIGHT_Y = 3 # Gamepad right stick Y axis
    GAMEPAD_AXIS_LEFT_TRIGGER = 4 # Gamepad back trigger left, pressure level: [1..-1]
    GAMEPAD_AXIS_RIGHT_TRIGGER = 5 # Gamepad back trigger right, pressure level: [1..-1]

# Material map index
  MaterialMapIndex* {.size: sizeof(int32).} = enum
    MATERIAL_MAP_ALBEDO = 0 # Albedo material (same as: MATERIAL_MAP_DIFFUSE)
    MATERIAL_MAP_METALNESS = 1 # Metalness material (same as: MATERIAL_MAP_SPECULAR)
    MATERIAL_MAP_NORMAL = 2 # Normal material
    MATERIAL_MAP_ROUGHNESS = 3 # Roughness material
    MATERIAL_MAP_OCCLUSION = 4 # Ambient occlusion material
    MATERIAL_MAP_EMISSION = 5 # Emission material
    MATERIAL_MAP_HEIGHT = 6 # Heightmap material
    MATERIAL_MAP_CUBEMAP = 7 # Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_IRRADIANCE = 8 # Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_PREFILTER = 9 # Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
    MATERIAL_MAP_BRDF = 10 # Brdf material

# Shader location index
  ShaderLocationIndex* {.size: sizeof(int32).} = enum
    SHADER_LOC_VERTEX_POSITION = 0 # Shader location: vertex attribute: position
    SHADER_LOC_VERTEX_TEXCOORD01 = 1 # Shader location: vertex attribute: texcoord01
    SHADER_LOC_VERTEX_TEXCOORD02 = 2 # Shader location: vertex attribute: texcoord02
    SHADER_LOC_VERTEX_NORMAL = 3 # Shader location: vertex attribute: normal
    SHADER_LOC_VERTEX_TANGENT = 4 # Shader location: vertex attribute: tangent
    SHADER_LOC_VERTEX_COLOR = 5 # Shader location: vertex attribute: color
    SHADER_LOC_MATRIX_MVP = 6 # Shader location: matrix uniform: model-view-projection
    SHADER_LOC_MATRIX_VIEW = 7 # Shader location: matrix uniform: view (camera transform)
    SHADER_LOC_MATRIX_PROJECTION = 8 # Shader location: matrix uniform: projection
    SHADER_LOC_MATRIX_MODEL = 9 # Shader location: matrix uniform: model (transform)
    SHADER_LOC_MATRIX_NORMAL = 10 # Shader location: matrix uniform: normal
    SHADER_LOC_VECTOR_VIEW = 11 # Shader location: vector uniform: view
    SHADER_LOC_COLOR_DIFFUSE = 12 # Shader location: vector uniform: diffuse color
    SHADER_LOC_COLOR_SPECULAR = 13 # Shader location: vector uniform: specular color
    SHADER_LOC_COLOR_AMBIENT = 14 # Shader location: vector uniform: ambient color
    SHADER_LOC_MAP_ALBEDO = 15 # Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
    SHADER_LOC_MAP_METALNESS = 16 # Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
    SHADER_LOC_MAP_NORMAL = 17 # Shader location: sampler2d texture: normal
    SHADER_LOC_MAP_ROUGHNESS = 18 # Shader location: sampler2d texture: roughness
    SHADER_LOC_MAP_OCCLUSION = 19 # Shader location: sampler2d texture: occlusion
    SHADER_LOC_MAP_EMISSION = 20 # Shader location: sampler2d texture: emission
    SHADER_LOC_MAP_HEIGHT = 21 # Shader location: sampler2d texture: heightmap
    SHADER_LOC_MAP_CUBEMAP = 22 # Shader location: samplerCube texture: cubemap
    SHADER_LOC_MAP_IRRADIANCE = 23 # Shader location: samplerCube texture: irradiance
    SHADER_LOC_MAP_PREFILTER = 24 # Shader location: samplerCube texture: prefilter
    SHADER_LOC_MAP_BRDF = 25 # Shader location: sampler2d texture: brdf
    SHADER_LOC_VERTEX_BONEIDS = 26 # Shader location: vertex attribute: bone indices
    SHADER_LOC_VERTEX_BONEWEIGHTS = 27 # Shader location: vertex attribute: bone weights
    SHADER_LOC_MATRIX_BONETRANSFORMS = 28 # Shader location: matrix attribute: bone transforms (animation)
    SHADER_LOC_VERTEX_INSTANCETRANSFORM = 29 # Shader location: vertex attribute: instance transforms

# Shader uniform data type
  ShaderUniformDataType* {.size: sizeof(int32).} = enum
    SHADER_UNIFORM_FLOAT = 0 # Shader uniform type: float
    SHADER_UNIFORM_VEC2 = 1 # Shader uniform type: vec2 (2 float)
    SHADER_UNIFORM_VEC3 = 2 # Shader uniform type: vec3 (3 float)
    SHADER_UNIFORM_VEC4 = 3 # Shader uniform type: vec4 (4 float)
    SHADER_UNIFORM_INT = 4 # Shader uniform type: int
    SHADER_UNIFORM_IVEC2 = 5 # Shader uniform type: ivec2 (2 int)
    SHADER_UNIFORM_IVEC3 = 6 # Shader uniform type: ivec3 (3 int)
    SHADER_UNIFORM_IVEC4 = 7 # Shader uniform type: ivec4 (4 int)
    SHADER_UNIFORM_UINT = 8 # Shader uniform type: unsigned int
    SHADER_UNIFORM_UIVEC2 = 9 # Shader uniform type: uivec2 (2 unsigned int)
    SHADER_UNIFORM_UIVEC3 = 10 # Shader uniform type: uivec3 (3 unsigned int)
    SHADER_UNIFORM_UIVEC4 = 11 # Shader uniform type: uivec4 (4 unsigned int)
    SHADER_UNIFORM_SAMPLER2D = 12 # Shader uniform type: sampler2d

# Shader attribute data types
  ShaderAttributeDataType* {.size: sizeof(int32).} = enum
    SHADER_ATTRIB_FLOAT = 0 # Shader attribute type: float
    SHADER_ATTRIB_VEC2 = 1 # Shader attribute type: vec2 (2 float)
    SHADER_ATTRIB_VEC3 = 2 # Shader attribute type: vec3 (3 float)
    SHADER_ATTRIB_VEC4 = 3 # Shader attribute type: vec4 (4 float)

# Pixel formats
  PixelFormat* {.size: sizeof(int32).} = enum
    PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1 # 8 bit per pixel (no alpha)
    PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2 # 8*2 bpp (2 channels)
    PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3 # 16 bpp
    PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4 # 24 bpp
    PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5 # 16 bpp (1 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6 # 16 bpp (4 bit alpha)
    PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7 # 32 bpp
    PIXELFORMAT_UNCOMPRESSED_R32 = 8 # 32 bpp (1 channel - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9 # 32*3 bpp (3 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10 # 32*4 bpp (4 channels - float)
    PIXELFORMAT_UNCOMPRESSED_R16 = 11 # 16 bpp (1 channel - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16 = 12 # 16*3 bpp (3 channels - half float)
    PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13 # 16*4 bpp (4 channels - half float)
    PIXELFORMAT_COMPRESSED_DXT1_RGB = 14 # 4 bpp (no alpha)
    PIXELFORMAT_COMPRESSED_DXT1_RGBA = 15 # 4 bpp (1 bit alpha)
    PIXELFORMAT_COMPRESSED_DXT3_RGBA = 16 # 8 bpp
    PIXELFORMAT_COMPRESSED_DXT5_RGBA = 17 # 8 bpp
    PIXELFORMAT_COMPRESSED_ETC1_RGB = 18 # 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_RGB = 19 # 4 bpp
    PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 20 # 8 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGB = 21 # 4 bpp
    PIXELFORMAT_COMPRESSED_PVRT_RGBA = 22 # 4 bpp
    PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 23 # 8 bpp
    PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 24 # 2 bpp

# Texture parameters: filter mode
  TextureFilter* {.size: sizeof(int32).} = enum
    TEXTURE_FILTER_POINT = 0 # No filter, pixel approximation
    TEXTURE_FILTER_BILINEAR = 1 # Linear filtering
    TEXTURE_FILTER_TRILINEAR = 2 # Trilinear filtering (linear with mipmaps)
    TEXTURE_FILTER_ANISOTROPIC_4X = 3 # Anisotropic filtering 4x
    TEXTURE_FILTER_ANISOTROPIC_8X = 4 # Anisotropic filtering 8x
    TEXTURE_FILTER_ANISOTROPIC_16X = 5 # Anisotropic filtering 16x

# Texture parameters: wrap mode
  TextureWrap* {.size: sizeof(int32).} = enum
    TEXTURE_WRAP_REPEAT = 0 # Repeats texture in tiled mode
    TEXTURE_WRAP_CLAMP = 1 # Clamps texture to edge pixel in tiled mode
    TEXTURE_WRAP_MIRROR_REPEAT = 2 # Mirrors and repeats the texture in tiled mode
    TEXTURE_WRAP_MIRROR_CLAMP = 3 # Mirrors and clamps to border the texture in tiled mode

# Cubemap layouts
  CubemapLayout* {.size: sizeof(int32).} = enum
    CUBEMAP_LAYOUT_AUTO_DETECT = 0 # Automatically detect layout type
    CUBEMAP_LAYOUT_LINE_VERTICAL = 1 # Layout is defined by a vertical line with faces
    CUBEMAP_LAYOUT_LINE_HORIZONTAL = 2 # Layout is defined by a horizontal line with faces
    CUBEMAP_LAYOUT_CROSS_THREE_BY_FOUR = 3 # Layout is defined by a 3x4 cross with cubemap faces
    CUBEMAP_LAYOUT_CROSS_FOUR_BY_THREE = 4 # Layout is defined by a 4x3 cross with cubemap faces

# Font type, defines generation method
  FontType* {.size: sizeof(int32).} = enum
    FONT_DEFAULT = 0 # Default font generation, anti-aliased
    FONT_BITMAP = 1 # Bitmap font generation, no anti-aliasing
    FONT_SDF = 2 # SDF font generation, requires external shader

# Color blending modes (pre-defined)
  BlendMode* {.size: sizeof(int32).} = enum
    BLEND_ALPHA = 0 # Blend textures considering alpha (default)
    BLEND_ADDITIVE = 1 # Blend textures adding colors
    BLEND_MULTIPLIED = 2 # Blend textures multiplying colors
    BLEND_ADD_COLORS = 3 # Blend textures adding colors (alternative)
    BLEND_SUBTRACT_COLORS = 4 # Blend textures subtracting colors (alternative)
    BLEND_ALPHA_PREMULTIPLY = 5 # Blend premultiplied textures considering alpha
    BLEND_CUSTOM = 6 # Blend textures using custom src/dst factors (use rlSetBlendFactors())
    BLEND_CUSTOM_SEPARATE = 7 # Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparate())

# Gesture
  Gesture* {.size: sizeof(int32).} = enum
    GESTURE_NONE = 0 # No gesture
    GESTURE_TAP = 1 # Tap gesture
    GESTURE_DOUBLETAP = 2 # Double tap gesture
    GESTURE_HOLD = 4 # Hold gesture
    GESTURE_DRAG = 8 # Drag gesture
    GESTURE_SWIPE_RIGHT = 16 # Swipe right gesture
    GESTURE_SWIPE_LEFT = 32 # Swipe left gesture
    GESTURE_SWIPE_UP = 64 # Swipe up gesture
    GESTURE_SWIPE_DOWN = 128 # Swipe down gesture
    GESTURE_PINCH_IN = 256 # Pinch in gesture
    GESTURE_PINCH_OUT = 512 # Pinch out gesture

# Camera system modes
  CameraMode* {.size: sizeof(int32).} = enum
    CAMERA_CUSTOM = 0 # Camera custom, controlled by user (UpdateCamera() does nothing)
    CAMERA_FREE = 1 # Camera free mode
    CAMERA_ORBITAL = 2 # Camera orbital, around target, zoom supported
    CAMERA_FIRST_PERSON = 3 # Camera first person
    CAMERA_THIRD_PERSON = 4 # Camera third person

# Camera projection
  CameraProjection* {.size: sizeof(int32).} = enum
    CAMERA_PERSPECTIVE = 0 # Perspective projection
    CAMERA_ORTHOGRAPHIC = 1 # Orthographic projection

# N-patch layout
  NPatchLayout* {.size: sizeof(int32).} = enum
    NPATCH_NINE_PATCH = 0 # Npatch layout: 3x3 tiles
    NPATCH_THREE_PATCH_VERTICAL = 1 # Npatch layout: 1x3 tiles
    NPATCH_THREE_PATCH_HORIZONTAL = 2 # Npatch layout: 3x1 tiles

type va_list {.importc: "va_list", header: "<stdarg.h>".} = object # Only used by TraceLogCallback
proc vsprintf*(s: cstring, format: cstring, args: va_list) {.cdecl, importc: "vsprintf", header: "<stdio.h>".}
type ConstCstring {.importc: "const char *".} = cstring

# Callbacks to hook some internal functions
# WARNING: This callbacks are intended for advance users

type
# Logging: Redirect trace log messages
  TraceLogCallback = proc(logLevel: int32, text: ConstCstring, args: va_list) {.cdecl.}
# FileIO: Load binary data
  LoadFileDataCallback = proc(fileName: ConstCstring, dataSize: ptr int32): ptr uint8 {.cdecl.}
# FileIO: Save binary data
  SaveFileDataCallback = proc(fileName: ConstCstring, data: pointer, dataSize: int32): bool {.cdecl.}
# FileIO: Load text data
  LoadFileTextCallback = proc(fileName: ConstCstring): cstring {.cdecl.}
# FileIO: Save text data
  SaveFileTextCallback = proc(fileName: ConstCstring, text: ConstCstring): bool {.cdecl.}
# 
  AudioCallback = proc(bufferData: pointer, frames: uint32) {.cdecl.}


{.push callconv: cdecl, importc, header: "raylib.h".}

# Initialize window and OpenGL context
proc InitWindow*(width: int32, height: int32, title: cstring)
# Close window and unload OpenGL context
proc CloseWindow*()
# Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
proc WindowShouldClose*(): bool
# Check if window has been initialized successfully
proc IsWindowReady*(): bool
# Check if window is currently fullscreen
proc IsWindowFullscreen*(): bool
# Check if window is currently hidden
proc IsWindowHidden*(): bool
# Check if window is currently minimized
proc IsWindowMinimized*(): bool
# Check if window is currently maximized
proc IsWindowMaximized*(): bool
# Check if window is currently focused
proc IsWindowFocused*(): bool
# Check if window has been resized last frame
proc IsWindowResized*(): bool
# Check if one specific window flag is enabled
proc IsWindowState*(flag: uint32): bool
# Set window configuration state using flags
proc SetWindowState*(flags: uint32)
# Clear window configuration state flags
proc ClearWindowState*(flags: uint32)
# Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
proc ToggleFullscreen*()
# Toggle window state: borderless windowed, resizes window to match monitor resolution
proc ToggleBorderlessWindowed*()
# Set window state: maximized, if resizable
proc MaximizeWindow*()
# Set window state: minimized, if resizable
proc MinimizeWindow*()
# Restore window from being minimized/maximized
proc RestoreWindow*()
# Set icon for window (single image, RGBA 32bit)
proc SetWindowIcon*(image: Image)
# Set icon for window (multiple images, RGBA 32bit)
proc SetWindowIcons*(images: ptr Image, count: int32)
# Set title for window
proc SetWindowTitle*(title: cstring)
# Set window position on screen
proc SetWindowPosition*(x: int32, y: int32)
# Set monitor for the current window
proc SetWindowMonitor*(monitor: int32)
# Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
proc SetWindowMinSize*(width: int32, height: int32)
# Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
proc SetWindowMaxSize*(width: int32, height: int32)
# Set window dimensions
proc SetWindowSize*(width: int32, height: int32)
# Set window opacity [0.0f..1.0f]
proc SetWindowOpacity*(opacity: float32)
# Set window focused
proc SetWindowFocused*()
# Get native window handle
proc GetWindowHandle*(): pointer
# Get current screen width
proc GetScreenWidth*(): int32
# Get current screen height
proc GetScreenHeight*(): int32
# Get current render width (it considers HiDPI)
proc GetRenderWidth*(): int32
# Get current render height (it considers HiDPI)
proc GetRenderHeight*(): int32
# Get number of connected monitors
proc GetMonitorCount*(): int32
# Get current monitor where window is placed
proc GetCurrentMonitor*(): int32
# Get specified monitor position
proc GetMonitorPosition*(monitor: int32): Vector2
# Get specified monitor width (current video mode used by monitor)
proc GetMonitorWidth*(monitor: int32): int32
# Get specified monitor height (current video mode used by monitor)
proc GetMonitorHeight*(monitor: int32): int32
# Get specified monitor physical width in millimetres
proc GetMonitorPhysicalWidth*(monitor: int32): int32
# Get specified monitor physical height in millimetres
proc GetMonitorPhysicalHeight*(monitor: int32): int32
# Get specified monitor refresh rate
proc GetMonitorRefreshRate*(monitor: int32): int32
# Get window position XY on monitor
proc GetWindowPosition*(): Vector2
# Get window scale DPI factor
proc GetWindowScaleDPI*(): Vector2
# Get the human-readable, UTF-8 encoded name of the specified monitor
proc GetMonitorName*(monitor: int32): cstring
# Set clipboard text content
proc SetClipboardText*(text: cstring)
# Get clipboard text content
proc GetClipboardText*(): cstring
# Get clipboard image content
proc GetClipboardImage*(): Image
# Enable waiting for events on EndDrawing(), no automatic event polling
proc EnableEventWaiting*()
# Disable waiting for events on EndDrawing(), automatic events polling
proc DisableEventWaiting*()
# Show cursor
proc ShowCursor*()
# Hide cursor
proc HideCursor*()
# Check if cursor is not visible
proc IsCursorHidden*(): bool
# Enable cursor (unlock cursor)
proc EnableCursor*()
# Disable cursor (lock cursor)
proc DisableCursor*()
# Check if cursor is on the screen
proc IsCursorOnScreen*(): bool
# Clear background (framebuffer) to color
proc ClearBackground*(color: Color)
# Begin canvas (framebuffer) drawing
proc BeginDrawing*()
# End canvas (framebuffer) drawing and swap buffers (double buffering)
proc EndDrawing*()
# Begin 2D mode with custom camera (2D)
proc BeginMode2D*(camera: Camera2D)
# End 2D mode with custom camera
proc EndMode2D*()
# Begin 3D mode with custom camera (3D)
proc BeginMode3D*(camera: Camera3D)
# End 3D mode and returns to default 2D orthographic mode
proc EndMode3D*()
# Begin drawing to render texture
proc BeginTextureMode*(target: RenderTexture2D)
# End drawing to render texture
proc EndTextureMode*()
# Begin custom shader drawing
proc BeginShaderMode*(shader: Shader)
# End custom shader drawing (use default shader)
proc EndShaderMode*()
# Begin blending mode (alpha, additive, multiplied, subtract, custom)
proc BeginBlendMode*(mode: int32)
# End blending mode (reset to default: alpha blending)
proc EndBlendMode*()
# Begin scissor mode (define screen area for following drawing)
proc BeginScissorMode*(x: int32, y: int32, width: int32, height: int32)
# End scissor mode
proc EndScissorMode*()
# Begin stereo rendering (requires VR simulator)
proc BeginVrStereoMode*(config: VrStereoConfig)
# End stereo rendering (requires VR simulator)
proc EndVrStereoMode*()
# Load VR stereo config for VR simulator device parameters
proc LoadVrStereoConfig*(device: VrDeviceInfo): VrStereoConfig
# Unload VR stereo config
proc UnloadVrStereoConfig*(config: VrStereoConfig)
# Load shader from files and bind default locations
proc LoadShader*(vsFileName: cstring, fsFileName: cstring): Shader
# Load shader from code strings and bind default locations
proc LoadShaderFromMemory*(vsCode: cstring, fsCode: cstring): Shader
# Check if shader is valid (loaded on GPU)
proc IsShaderValid*(shader: Shader): bool
# Get shader uniform location
proc GetShaderLocation*(shader: Shader, uniformName: cstring): int32
# Get shader attribute location
proc GetShaderLocationAttrib*(shader: Shader, attribName: cstring): int32
# Set shader uniform value
proc SetShaderValue*(shader: Shader, locIndex: int32, value: pointer, uniformType: int32)
# Set shader uniform value vector
proc SetShaderValueV*(shader: Shader, locIndex: int32, value: pointer, uniformType: int32, count: int32)
# Set shader uniform value (matrix 4x4)
proc SetShaderValueMatrix*(shader: Shader, locIndex: int32, mat: Matrix)
# Set shader uniform value and bind the texture (sampler2d)
proc SetShaderValueTexture*(shader: Shader, locIndex: int32, texture: Texture2D)
# Unload shader from GPU memory (VRAM)
proc UnloadShader*(shader: Shader)
# Get a ray trace from screen position (i.e mouse)
proc GetScreenToWorldRay*(position: Vector2, camera: Camera): Ray
# Get a ray trace from screen position (i.e mouse) in a viewport
proc GetScreenToWorldRayEx*(position: Vector2, camera: Camera, width: int32, height: int32): Ray
# Get screen space position for a 3d world space position
proc GetWorldToScreen*(position: Vector3, camera: Camera): Vector2
# Get sized screen space position for a 3d world space position
proc GetWorldToScreenEx*(position: Vector3, camera: Camera, width: int32, height: int32): Vector2
# Get screen space position for a 2d camera world space position
proc GetWorldToScreen2D*(position: Vector2, camera: Camera2D): Vector2
# Get world space position for a 2d camera screen space position
proc GetScreenToWorld2D*(position: Vector2, camera: Camera2D): Vector2
# Get camera transform matrix (view matrix)
proc GetCameraMatrix*(camera: Camera): Matrix
# Get camera 2d transform matrix
proc GetCameraMatrix2D*(camera: Camera2D): Matrix
# Set target FPS (maximum)
proc SetTargetFPS*(fps: int32)
# Get time in seconds for last frame drawn (delta time)
proc GetFrameTime*(): float32
# Get elapsed time in seconds since InitWindow()
proc GetTime*(): float64
# Get current FPS
proc GetFPS*(): int32
# Swap back buffer with front buffer (screen drawing)
proc SwapScreenBuffer*()
# Register all input events
proc PollInputEvents*()
# Wait for some time (halt program execution)
proc WaitTime*(seconds: float64)
# Set the seed for the random number generator
proc SetRandomSeed*(seed: uint32)
# Get a random value between min and max (both included)
proc GetRandomValue*(min: int32, max: int32): int32
# Load random values sequence, no values repeated
proc LoadRandomSequence*(count: uint32, min: int32, max: int32): ptr int32
# Unload random values sequence
proc UnloadRandomSequence*(sequence: ptr int32)
# Takes a screenshot of current screen (filename extension defines format)
proc TakeScreenshot*(fileName: cstring)
# Set init configuration flags (view FLAGS)
proc SetConfigFlags*(flags: uint32)
# Open URL with default system browser (if available)
proc OpenURL*(url: cstring)
# Set the current threshold (minimum) log level
proc SetTraceLogLevel*(logLevel: int32)
# Set custom trace log
proc SetTraceLogCallback*(callback: TraceLogCallback)
# Internal memory allocator
proc MemAlloc*(size: uint32): pointer
# Internal memory reallocator
proc MemRealloc*(`ptr`: pointer, size: uint32): pointer
# Internal memory free
proc MemFree*(`ptr`: pointer)
# Load file data as byte array (read)
proc LoadFileData*(fileName: cstring, dataSize: ptr int32): ptr uint8
# Unload file data allocated by LoadFileData()
proc UnloadFileData*(data: ptr uint8)
# Save data to file from byte array (write), returns true on success
proc SaveFileData*(fileName: cstring, data: pointer, dataSize: int32): bool
# Export data to code (.h), returns true on success
proc ExportDataAsCode*(data: ptr uint8, dataSize: int32, fileName: cstring): bool
# Load text data from file (read), returns a '\0' terminated string
proc LoadFileText*(fileName: cstring): cstring
# Unload file text data allocated by LoadFileText()
proc UnloadFileText*(text: cstring)
# Save text data to file (write), string must be '\0' terminated, returns true on success
proc SaveFileText*(fileName: cstring, text: cstring): bool
# Set custom file binary data loader
proc SetLoadFileDataCallback*(callback: LoadFileDataCallback)
# Set custom file binary data saver
proc SetSaveFileDataCallback*(callback: SaveFileDataCallback)
# Set custom file text data loader
proc SetLoadFileTextCallback*(callback: LoadFileTextCallback)
# Set custom file text data saver
proc SetSaveFileTextCallback*(callback: SaveFileTextCallback)
# Rename file (if exists), returns 0 on success
proc FileRename*(fileName: cstring, fileRename: cstring): int32
# Remove file (if exists), returns 0 on success
proc FileRemove*(fileName: cstring): int32
# Copy file from one path to another, dstPath created if it doesn't exist, returns 0 on success
proc FileCopy*(srcPath: cstring, dstPath: cstring): int32
# Move file from one directory to another, dstPath created if it doesn't exist, returns 0 on success
proc FileMove*(srcPath: cstring, dstPath: cstring): int32
# Replace text in an existing file, returns 0 on success
proc FileTextReplace*(fileName: cstring, search: cstring, replacement: cstring): int32
# Find text in existing file, returns -1 if index not found or index otherwise
proc FileTextFindIndex*(fileName: cstring, search: cstring): int32
# Check if file exists
proc FileExists*(fileName: cstring): bool
# Check if directory path exists
proc DirectoryExists*(dirPath: cstring): bool
# Check file extension (recommended include point: .png, .wav)
proc IsFileExtension*(fileName: cstring, ext: cstring): bool
# Check if file path (file or directory) is hidden by OS
proc IsFileHidden*(filePath: cstring): bool
# Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
proc GetFileLength*(fileName: cstring): int32
# Get file modification time (last write time)
proc GetFileModTime*(fileName: cstring): clong
# Get pointer to extension for a filename string (includes dot: '.png')
proc GetFileExtension*(fileName: cstring): cstring
# Get pointer to filename for a path string
proc GetFileName*(filePath: cstring): cstring
# Get filename string without extension (uses static string)
proc GetFileNameWithoutExt*(filePath: cstring): cstring
# Get full path for a provided fileName with path (uses static string)
proc GetDirectoryPath*(filePath: cstring): cstring
# Get previous directory path for a provided path (uses static string)
proc GetPrevDirectoryPath*(dirPath: cstring): cstring
# Get current working directory (uses static string)
proc GetWorkingDirectory*(): cstring
# Get the directory of the running application (uses static string)
proc GetApplicationDirectory*(): cstring
# Create directories (including full path requested), returns 0 on success
proc MakeDirectory*(dirPath: cstring): int32
# Change working directory, returns 0 on success
proc ChangeDirectory*(dirPath: cstring): int32
# Check if provided path points to a file
proc IsPathFile*(path: cstring): bool
# Check if provided path points to a directory
proc IsPathDirectory*(path: cstring): bool
# Check if provided path is an absolute path
proc IsPathAbsolute*(path: cstring): bool
# Check if fileName is valid for the platform/OS
proc IsFileNameValid*(fileName: cstring): bool
# Load directory filepaths, files and directories, no subdirs scan
proc LoadDirectoryFiles*(dirPath: cstring): FilePathList
# Load directory filepaths with extension filtering and subdir scan; some filters available: '*.*','FILES*','DIRS*'
proc LoadDirectoryFilesEx*(basePath: cstring, filter: cstring, scanSubdirs: bool): FilePathList
# Unload filepaths
proc UnloadDirectoryFiles*(files: FilePathList)
# Check if file has been dropped into window
proc IsFileDropped*(): bool
# Load dropped filepaths
proc LoadDroppedFiles*(): FilePathList
# Unload dropped filepaths
proc UnloadDroppedFiles*(files: FilePathList)
# Get the file count in a directory
proc GetDirectoryFileCount*(dirPath: cstring): uint32
# Get the file count in a directory with extension filtering and recursive directory scan. Use 'DIR' in the filter string to include directories in the result
proc GetDirectoryFileCountEx*(basePath: cstring, filter: cstring, scanSubdirs: bool): uint32
# Compress data (DEFLATE algorithm), memory must be MemFree()
proc CompressData*(data: ptr uint8, dataSize: int32, compDataSize: ptr int32): ptr uint8
# Decompress data (DEFLATE algorithm), memory must be MemFree()
proc DecompressData*(compData: ptr uint8, compDataSize: int32, dataSize: ptr int32): ptr uint8
# Encode data to Base64 string (includes NULL terminator), memory must be MemFree()
proc EncodeDataBase64*(data: ptr uint8, dataSize: int32, outputSize: ptr int32): cstring
# Decode Base64 string (expected NULL terminated), memory must be MemFree()
proc DecodeDataBase64*(text: cstring, outputSize: ptr int32): ptr uint8
# Compute CRC32 hash code
proc ComputeCRC32*(data: ptr uint8, dataSize: int32): uint32
# Compute MD5 hash code, returns static int[4] (16 bytes)
proc ComputeMD5*(data: ptr uint8, dataSize: int32): ptr uint32
# Compute SHA1 hash code, returns static int[5] (20 bytes)
proc ComputeSHA1*(data: ptr uint8, dataSize: int32): ptr uint32
# Compute SHA256 hash code, returns static int[8] (32 bytes)
proc ComputeSHA256*(data: ptr uint8, dataSize: int32): ptr uint32
# Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
proc LoadAutomationEventList*(fileName: cstring): AutomationEventList
# Unload automation events list from file
proc UnloadAutomationEventList*(list: AutomationEventList)
# Export automation events list as text file
proc ExportAutomationEventList*(list: AutomationEventList, fileName: cstring): bool
# Set automation event list to record to
proc SetAutomationEventList*(list: ptr AutomationEventList)
# Set automation event internal base frame to start recording
proc SetAutomationEventBaseFrame*(frame: int32)
# Start recording automation events (AutomationEventList must be set)
proc StartAutomationEventRecording*()
# Stop recording automation events
proc StopAutomationEventRecording*()
# Play a recorded automation event
proc PlayAutomationEvent*(event: AutomationEvent)
# Check if key has been pressed once
proc IsKeyPressed*(key: int32): bool
# Check if key has been pressed again
proc IsKeyPressedRepeat*(key: int32): bool
# Check if key is being pressed
proc IsKeyDown*(key: int32): bool
# Check if key has been released once
proc IsKeyReleased*(key: int32): bool
# Check if key is NOT being pressed
proc IsKeyUp*(key: int32): bool
# Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
proc GetKeyPressed*(): int32
# Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
proc GetCharPressed*(): int32
# Get name of a QWERTY key on the current keyboard layout (eg returns string 'q' for KEY_A on an AZERTY keyboard)
proc GetKeyName*(key: int32): cstring
# Set a custom key to exit program (default is ESC)
proc SetExitKey*(key: int32)
# Check if gamepad is available
proc IsGamepadAvailable*(gamepad: int32): bool
# Get gamepad internal name id
proc GetGamepadName*(gamepad: int32): cstring
# Check if gamepad button has been pressed once
proc IsGamepadButtonPressed*(gamepad: int32, button: int32): bool
# Check if gamepad button is being pressed
proc IsGamepadButtonDown*(gamepad: int32, button: int32): bool
# Check if gamepad button has been released once
proc IsGamepadButtonReleased*(gamepad: int32, button: int32): bool
# Check if gamepad button is NOT being pressed
proc IsGamepadButtonUp*(gamepad: int32, button: int32): bool
# Get the last gamepad button pressed
proc GetGamepadButtonPressed*(): int32
# Get axis count for a gamepad
proc GetGamepadAxisCount*(gamepad: int32): int32
# Get movement value for a gamepad axis
proc GetGamepadAxisMovement*(gamepad: int32, axis: int32): float32
# Set internal gamepad mappings (SDL_GameControllerDB)
proc SetGamepadMappings*(mappings: cstring): int32
# Set gamepad vibration for both motors (duration in seconds)
proc SetGamepadVibration*(gamepad: int32, leftMotor: float32, rightMotor: float32, duration: float32)
# Check if mouse button has been pressed once
proc IsMouseButtonPressed*(button: int32): bool
# Check if mouse button is being pressed
proc IsMouseButtonDown*(button: int32): bool
# Check if mouse button has been released once
proc IsMouseButtonReleased*(button: int32): bool
# Check if mouse button is NOT being pressed
proc IsMouseButtonUp*(button: int32): bool
# Get mouse position X
proc GetMouseX*(): int32
# Get mouse position Y
proc GetMouseY*(): int32
# Get mouse position XY
proc GetMousePosition*(): Vector2
# Get mouse delta between frames
proc GetMouseDelta*(): Vector2
# Set mouse position XY
proc SetMousePosition*(x: int32, y: int32)
# Set mouse offset
proc SetMouseOffset*(offsetX: int32, offsetY: int32)
# Set mouse scaling
proc SetMouseScale*(scaleX: float32, scaleY: float32)
# Get mouse wheel movement for X or Y, whichever is larger
proc GetMouseWheelMove*(): float32
# Get mouse wheel movement for both X and Y
proc GetMouseWheelMoveV*(): Vector2
# Set mouse cursor
proc SetMouseCursor*(cursor: int32)
# Get touch position X for touch point 0 (relative to screen size)
proc GetTouchX*(): int32
# Get touch position Y for touch point 0 (relative to screen size)
proc GetTouchY*(): int32
# Get touch position XY for a touch point index (relative to screen size)
proc GetTouchPosition*(index: int32): Vector2
# Get touch point identifier for provided index
proc GetTouchPointId*(index: int32): int32
# Get number of touch points
proc GetTouchPointCount*(): int32
# Enable a set of gestures using flags
proc SetGesturesEnabled*(flags: uint32)
# Check if gesture has been detected
proc IsGestureDetected*(gesture: uint32): bool
# Get latest detected gesture
proc GetGestureDetected*(): int32
# Get gesture hold time in seconds
proc GetGestureHoldDuration*(): float32
# Get gesture drag vector
proc GetGestureDragVector*(): Vector2
# Get gesture drag angle
proc GetGestureDragAngle*(): float32
# Get gesture pinch delta
proc GetGesturePinchVector*(): Vector2
# Get gesture pinch angle
proc GetGesturePinchAngle*(): float32
# Update camera position for selected mode
proc UpdateCamera*(camera: ptr Camera, mode: int32)
# Update camera movement/rotation
proc UpdateCameraPro*(camera: ptr Camera, movement: Vector3, rotation: Vector3, zoom: float32)
# Set texture and rectangle to be used on shapes drawing
proc SetShapesTexture*(texture: Texture2D, rec: Rectangle)
# Get texture that is used for shapes drawing
proc GetShapesTexture*(): Texture2D
# Get texture source rectangle that is used for shapes drawing
proc GetShapesTextureRectangle*(): Rectangle
# Draw a pixel using geometry [Can be slow, use with care]
proc DrawPixel*(posX: int32, posY: int32, color: Color)
# Draw a pixel using geometry (Vector version) [Can be slow, use with care]
proc DrawPixelV*(position: Vector2, color: Color)
# Draw a line
proc DrawLine*(startPosX: int32, startPosY: int32, endPosX: int32, endPosY: int32, color: Color)
# Draw a line (using gl lines)
proc DrawLineV*(startPos: Vector2, endPos: Vector2, color: Color)
# Draw a line (using triangles/quads)
proc DrawLineEx*(startPos: Vector2, endPos: Vector2, thick: float32, color: Color)
# Draw lines sequence (using gl lines)
proc DrawLineStrip*(points: ptr Vector2, pointCount: int32, color: Color)
# Draw line segment cubic-bezier in-out interpolation
proc DrawLineBezier*(startPos: Vector2, endPos: Vector2, thick: float32, color: Color)
# Draw a dashed line
proc DrawLineDashed*(startPos: Vector2, endPos: Vector2, dashSize: int32, spaceSize: int32, color: Color)
# Draw a color-filled triangle, counter-clockwise vertex order
proc DrawTriangle*(v1: Vector2, v2: Vector2, v3: Vector2, color: Color)
# Draw triangle with interpolated colors, counter-clockwise vertex/color order
proc DrawTriangleGradient*(v1: Vector2, v2: Vector2, v3: Vector2, c1: Color, c2: Color, c3: Color)
# Draw triangle outline, counter-clockwise vertex order
proc DrawTriangleLines*(v1: Vector2, v2: Vector2, v3: Vector2, color: Color)
# Draw triangle outline with line thickness, counter-clockwise vertex order
proc DrawTriangleLinesEx*(v1: Vector2, v2: Vector2, v3: Vector2, thick: float32, color: Color)
# Draw a triangle fan defined by points (first vertex is the center)
proc DrawTriangleFan*(points: ptr Vector2, pointCount: int32, color: Color)
# Draw a triangle strip defined by points
proc DrawTriangleStrip*(points: ptr Vector2, pointCount: int32, color: Color)
# Draw a color-filled rectangle
proc DrawRectangle*(posX: int32, posY: int32, width: int32, height: int32, color: Color)
# Draw a color-filled rectangle (Vector version)
proc DrawRectangleV*(position: Vector2, size: Vector2, color: Color)
# Draw a color-filled rectangle
proc DrawRectangleRec*(rec: Rectangle, color: Color)
# Draw a color-filled rectangle with pro parameters
proc DrawRectanglePro*(rec: Rectangle, origin: Vector2, rotation: float32, color: Color)
# Draw a vertical-gradient-filled rectangle
proc DrawRectangleGradientV*(posX: int32, posY: int32, width: int32, height: int32, top: Color, bottom: Color)
# Draw a horizontal-gradient-filled rectangle
proc DrawRectangleGradientH*(posX: int32, posY: int32, width: int32, height: int32, left: Color, right: Color)
# Draw a gradient-filled rectangle with custom vertex colors, counter-clockwise color order
proc DrawRectangleGradientEx*(rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color)
# Draw rectangle outline
proc DrawRectangleLines*(posX: int32, posY: int32, width: int32, height: int32, color: Color)
# Draw rectangle outline with line thickness
proc DrawRectangleLinesEx*(rec: Rectangle, thick: float32, color: Color)
# Draw rectangle with rounded edges
proc DrawRectangleRounded*(rec: Rectangle, roundness: float32, segments: int32, color: Color)
# Draw rectangle lines with rounded edges
proc DrawRectangleRoundedLines*(rec: Rectangle, roundness: float32, segments: int32, color: Color)
# Draw rectangle lines with rounded edges outline and line thickness
proc DrawRectangleRoundedLinesEx*(rec: Rectangle, roundness: float32, segments: int32, thick: float32, color: Color)
# Draw a polygon of n sides
proc DrawPoly*(center: Vector2, sides: int32, radius: float32, rotation: float32, color: Color)
# Draw a polygon outline of n sides
proc DrawPolyLines*(center: Vector2, sides: int32, radius: float32, rotation: float32, color: Color)
# Draw a polygon outline of n sides with line thickness
proc DrawPolyLinesEx*(center: Vector2, sides: int32, radius: float32, rotation: float32, thick: float32, color: Color)
# Draw a color-filled circle
proc DrawCircle*(centerX: int32, centerY: int32, radius: float32, color: Color)
# Draw a color-filled circle (Vector version)
proc DrawCircleV*(center: Vector2, radius: float32, color: Color)
# Draw a gradient-filled circle
proc DrawCircleGradient*(center: Vector2, radius: float32, inner: Color, outer: Color)
# Draw a piece of a circle
proc DrawCircleSector*(center: Vector2, radius: float32, startAngle: float32, endAngle: float32, segments: int32, color: Color)
# Draw circle sector outline
proc DrawCircleSectorLines*(center: Vector2, radius: float32, startAngle: float32, endAngle: float32, segments: int32, color: Color)
# Draw circle sector outline with thickness
proc DrawCircleSectorLinesEx*(center: Vector2, radius: float32, startAngle: float32, endAngle: float32, segments: int32, thick: float32, color: Color)
# Draw circle outline
proc DrawCircleLines*(centerX: int32, centerY: int32, radius: float32, color: Color)
# Draw circle outline (Vector version)
proc DrawCircleLinesV*(center: Vector2, radius: float32, color: Color)
# Draw circle outline with line thickness
proc DrawCircleLinesEx*(center: Vector2, radius: float32, thick: float32, color: Color)
# Draw ellipse
proc DrawEllipse*(centerX: int32, centerY: int32, radiusH: float32, radiusV: float32, color: Color)
# Draw ellipse (Vector version)
proc DrawEllipseV*(center: Vector2, radiusH: float32, radiusV: float32, color: Color)
# Draw ellipse outline
proc DrawEllipseLines*(centerX: int32, centerY: int32, radiusH: float32, radiusV: float32, color: Color)
# Draw ellipse outline (Vector version)
proc DrawEllipseLinesV*(center: Vector2, radiusH: float32, radiusV: float32, color: Color)
# Draw ellipse outline with line thickness
proc DrawEllipseLinesEx*(center: Vector2, radiusH: float32, radiusV: float32, thick: float32, color: Color)
# Draw ring
proc DrawRing*(center: Vector2, innerRadius: float32, outerRadius: float32, startAngle: float32, endAngle: float32, segments: int32, color: Color)
# Draw ring outline
proc DrawRingLines*(center: Vector2, innerRadius: float32, outerRadius: float32, startAngle: float32, endAngle: float32, segments: int32, color: Color)
# Draw ring outline with line thickness
proc DrawRingLinesEx*(center: Vector2, innerRadius: float32, outerRadius: float32, startAngle: float32, endAngle: float32, segments: int32, thick: float32, color: Color)
# Draw spline: Linear, minimum 2 points
proc DrawSplineLinear*(points: ptr Vector2, pointCount: int32, thick: float32, color: Color)
# Draw spline: B-Spline, minimum 4 points
proc DrawSplineBasis*(points: ptr Vector2, pointCount: int32, thick: float32, color: Color)
# Draw spline: Catmull-Rom, minimum 4 points
proc DrawSplineCatmullRom*(points: ptr Vector2, pointCount: int32, thick: float32, color: Color)
# Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
proc DrawSplineBezierQuadratic*(points: ptr Vector2, pointCount: int32, thick: float32, color: Color)
# Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
proc DrawSplineBezierCubic*(points: ptr Vector2, pointCount: int32, thick: float32, color: Color)
# Draw spline segment: Linear, 2 points
proc DrawSplineSegmentLinear*(p1: Vector2, p2: Vector2, thick: float32, color: Color)
# Draw spline segment: B-Spline, 4 points
proc DrawSplineSegmentBasis*(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: float32, color: Color)
# Draw spline segment: Catmull-Rom, 4 points
proc DrawSplineSegmentCatmullRom*(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, thick: float32, color: Color)
# Draw spline segment: Quadratic Bezier, 2 points, 1 control point
proc DrawSplineSegmentBezierQuadratic*(p1: Vector2, c2: Vector2, p3: Vector2, thick: float32, color: Color)
# Draw spline segment: Cubic Bezier, 2 points, 2 control points
proc DrawSplineSegmentBezierCubic*(p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, thick: float32, color: Color)
# Get (evaluate) spline point: Linear
proc GetSplinePointLinear*(startPos: Vector2, endPos: Vector2, t: float32): Vector2
# Get (evaluate) spline point: B-Spline
proc GetSplinePointBasis*(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: float32): Vector2
# Get (evaluate) spline point: Catmull-Rom
proc GetSplinePointCatmullRom*(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, t: float32): Vector2
# Get (evaluate) spline point: Quadratic Bezier
proc GetSplinePointBezierQuadratic*(p1: Vector2, c2: Vector2, p3: Vector2, t: float32): Vector2
# Get (evaluate) spline point: Cubic Bezier
proc GetSplinePointBezierCubic*(p1: Vector2, c2: Vector2, c3: Vector2, p4: Vector2, t: float32): Vector2
# Check collision between two rectangles
proc CheckCollisionRecs*(rec1: Rectangle, rec2: Rectangle): bool
# Check collision between two circles
proc CheckCollisionCircles*(center1: Vector2, radius1: float32, center2: Vector2, radius2: float32): bool
# Check collision between circle and rectangle
proc CheckCollisionCircleRec*(center: Vector2, radius: float32, rec: Rectangle): bool
# Check if circle collides with a line created between two points [p1] and [p2]
proc CheckCollisionCircleLine*(center: Vector2, radius: float32, p1: Vector2, p2: Vector2): bool
# Check if point is inside rectangle
proc CheckCollisionPointRec*(point: Vector2, rec: Rectangle): bool
# Check if point is inside circle
proc CheckCollisionPointCircle*(point: Vector2, center: Vector2, radius: float32): bool
# Check if point is inside a triangle
proc CheckCollisionPointTriangle*(point: Vector2, p1: Vector2, p2: Vector2, p3: Vector2): bool
# Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
proc CheckCollisionPointLine*(point: Vector2, p1: Vector2, p2: Vector2, threshold: int32): bool
# Check if point is within a polygon described by array of vertices
proc CheckCollisionPointPoly*(point: Vector2, points: ptr Vector2, pointCount: int32): bool
# Check the collision between two lines defined by two points each, returns collision point by reference
proc CheckCollisionLines*(startPos1: Vector2, endPos1: Vector2, startPos2: Vector2, endPos2: Vector2, collisionPoint: ptr Vector2): bool
# Get collision rectangle for two rectangles collision
proc GetCollisionRec*(rec1: Rectangle, rec2: Rectangle): Rectangle
# Load image from file into CPU memory (RAM)
proc LoadImage*(fileName: cstring): Image
# Load image from RAW file data
proc LoadImageRaw*(fileName: cstring, width: int32, height: int32, format: int32, headerSize: int32): Image
# Load image sequence from file (frames appended to image.data)
proc LoadImageAnim*(fileName: cstring, frames: ptr int32): Image
# Load image sequence from memory buffer
proc LoadImageAnimFromMemory*(fileType: cstring, fileData: ptr uint8, dataSize: int32, frames: ptr int32): Image
# Load image from memory buffer, fileType refers to extension: i.e. '.png'
proc LoadImageFromMemory*(fileType: cstring, fileData: ptr uint8, dataSize: int32): Image
# Load image from GPU texture data
proc LoadImageFromTexture*(texture: Texture2D): Image
# Load image from screen buffer (screenshot)
proc LoadImageFromScreen*(): Image
# Check if an image is valid (data and parameters)
proc IsImageValid*(image: Image): bool
# Unload image from CPU memory (RAM)
proc UnloadImage*(image: Image)
# Export image data to file, returns true on success
proc ExportImage*(image: Image, fileName: cstring): bool
# Export image to memory buffer, memory must be MemFree()
proc ExportImageToMemory*(image: Image, fileType: cstring, fileSize: ptr int32): ptr uint8
# Export image as code file defining an array of bytes, returns true on success
proc ExportImageAsCode*(image: Image, fileName: cstring): bool
# Generate image: plain color
proc GenImageColor*(width: int32, height: int32, color: Color): Image
# Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
proc GenImageGradientLinear*(width: int32, height: int32, direction: int32, start: Color, `end`: Color): Image
# Generate image: radial gradient
proc GenImageGradientRadial*(width: int32, height: int32, density: float32, inner: Color, outer: Color): Image
# Generate image: square gradient
proc GenImageGradientSquare*(width: int32, height: int32, density: float32, inner: Color, outer: Color): Image
# Generate image: checked
proc GenImageChecked*(width: int32, height: int32, checksX: int32, checksY: int32, col1: Color, col2: Color): Image
# Generate image: white noise
proc GenImageWhiteNoise*(width: int32, height: int32, factor: float32): Image
# Generate image: perlin noise
proc GenImagePerlinNoise*(width: int32, height: int32, offsetX: int32, offsetY: int32, scale: float32): Image
# Generate image: cellular algorithm, bigger tileSize means bigger cells
proc GenImageCellular*(width: int32, height: int32, tileSize: int32): Image
# Generate image: grayscale image from text data
proc GenImageText*(width: int32, height: int32, text: cstring): Image
# Create an image duplicate (useful for transformations)
proc ImageCopy*(image: Image): Image
# Create an image from another image piece
proc ImageFromImage*(image: Image, rec: Rectangle): Image
# Create an image from a selected channel of another image (GRAYSCALE)
proc ImageFromChannel*(image: Image, selectedChannel: int32): Image
# Create an image from text (default font)
proc ImageText*(text: cstring, fontSize: int32, color: Color): Image
# Create an image from text (custom sprite font)
proc ImageTextEx*(font: Font, text: cstring, fontSize: float32, spacing: float32, tint: Color): Image
# Convert image data to desired format
proc ImageFormat*(image: ptr Image, newFormat: int32)
# Convert image to POT (power-of-two)
proc ImageToPOT*(image: ptr Image, fill: Color)
# Crop an image to a defined rectangle
proc ImageCrop*(image: ptr Image, crop: Rectangle)
# Crop image depending on alpha value
proc ImageAlphaCrop*(image: ptr Image, threshold: float32)
# Clear alpha channel to desired color
proc ImageAlphaClear*(image: ptr Image, color: Color, threshold: float32)
# Apply alpha mask to image
proc ImageAlphaMask*(image: ptr Image, alphaMask: Image)
# Premultiply alpha channel
proc ImageAlphaPremultiply*(image: ptr Image)
# Apply Gaussian blur using a box blur approximation
proc ImageBlurGaussian*(image: ptr Image, blurSize: int32)
# Apply custom square convolution kernel to image
proc ImageKernelConvolution*(image: ptr Image, kernel: ptr float32, kernelSize: int32)
# Resize image (Bicubic scaling algorithm)
proc ImageResize*(image: ptr Image, newWidth: int32, newHeight: int32)
# Resize image (Nearest-Neighbor scaling algorithm)
proc ImageResizeNN*(image: ptr Image, newWidth: int32, newHeight: int32)
# Resize canvas and fill with color
proc ImageResizeCanvas*(image: ptr Image, newWidth: int32, newHeight: int32, offsetX: int32, offsetY: int32, fill: Color)
# Compute all mipmap levels for a provided image
proc ImageMipmaps*(image: ptr Image)
# Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
proc ImageDither*(image: ptr Image, rBpp: int32, gBpp: int32, bBpp: int32, aBpp: int32)
# Flip image vertically
proc ImageFlipVertical*(image: ptr Image)
# Flip image horizontally
proc ImageFlipHorizontal*(image: ptr Image)
# Rotate image by input angle in degrees (-359 to 359)
proc ImageRotate*(image: ptr Image, degrees: int32)
# Rotate image clockwise 90deg
proc ImageRotateCW*(image: ptr Image)
# Rotate image counter-clockwise 90deg
proc ImageRotateCCW*(image: ptr Image)
# Modify image color: tint
proc ImageColorTint*(image: ptr Image, color: Color)
# Modify image color: invert
proc ImageColorInvert*(image: ptr Image)
# Modify image color: grayscale
proc ImageColorGrayscale*(image: ptr Image)
# Modify image color: contrast (-100 to 100)
proc ImageColorContrast*(image: ptr Image, contrast: int32)
# Modify image color: brightness (-255 to 255)
proc ImageColorBrightness*(image: ptr Image, brightness: int32)
# Modify image color: replace color
proc ImageColorReplace*(image: ptr Image, color: Color, replace: Color)
# Load color data from image as a Color array (RGBA - 32bit)
proc LoadImageColors*(image: Image): ptr Color
# Load colors palette from image as a Color array (RGBA - 32bit)
proc LoadImagePalette*(image: Image, maxPaletteSize: int32, colorCount: ptr int32): ptr Color
# Unload color data loaded with LoadImageColors()
proc UnloadImageColors*(colors: ptr Color)
# Unload colors palette loaded with LoadImagePalette()
proc UnloadImagePalette*(colors: ptr Color)
# Get image alpha border rectangle
proc GetImageAlphaBorder*(image: Image, threshold: float32): Rectangle
# Get image pixel color at (x, y) position
proc GetImageColor*(image: Image, x: int32, y: int32): Color
# Clear image background with provided color
proc ImageClearBackground*(dst: ptr Image, color: Color)
# Draw pixel within an image
proc ImageDrawPixel*(dst: ptr Image, posX: int32, posY: int32, color: Color)
# Draw pixel within an image (Vector version)
proc ImageDrawPixelV*(dst: ptr Image, position: Vector2, color: Color)
# Draw line within an image
proc ImageDrawLine*(dst: ptr Image, startPosX: int32, startPosY: int32, endPosX: int32, endPosY: int32, color: Color)
# Draw line within an image (Vector version)
proc ImageDrawLineV*(dst: ptr Image, start: Vector2, `end`: Vector2, color: Color)
# Draw a line defining thickness within an image
proc ImageDrawLineEx*(dst: ptr Image, start: Vector2, `end`: Vector2, thick: int32, color: Color)
# Draw a lines sequence within an image
proc ImageDrawLineStrip*(dst: ptr Image, points: ptr Vector2, pointCount: int32, color: Color)
# Draw triangle within an image
proc ImageDrawTriangle*(dst: ptr Image, v1: Vector2, v2: Vector2, v3: Vector2, color: Color)
# Draw triangle with interpolated colors within an image
proc ImageDrawTriangleGradient*(dst: ptr Image, v1: Vector2, v2: Vector2, v3: Vector2, c1: Color, c2: Color, c3: Color)
# Draw triangle outline within an image
proc ImageDrawTriangleLines*(dst: ptr Image, v1: Vector2, v2: Vector2, v3: Vector2, color: Color)
# Draw a triangle fan defined by points within an image (first vertex is the center)
proc ImageDrawTriangleFan*(dst: ptr Image, points: ptr Vector2, pointCount: int32, color: Color)
# Draw a triangle strip defined by points within an image
proc ImageDrawTriangleStrip*(dst: ptr Image, points: ptr Vector2, pointCount: int32, color: Color)
# Draw rectangle within an image
proc ImageDrawRectangle*(dst: ptr Image, posX: int32, posY: int32, width: int32, height: int32, color: Color)
# Draw rectangle within an image (Vector version)
proc ImageDrawRectangleV*(dst: ptr Image, position: Vector2, size: Vector2, color: Color)
# Draw rectangle within an image
proc ImageDrawRectangleRec*(dst: ptr Image, rec: Rectangle, color: Color)
# Draw a color-filled rectangle with pro parameters within and image
proc ImageDrawRectanglePro*(dst: ptr Image, rec: Rectangle, origin: Vector2, rotation: float32, color: Color)
# Draw rectangle lines within an image
proc ImageDrawRectangleLines*(dst: ptr Image, posX: int32, posY: int32, width: int32, height: int32, color: Color)
# Draw rectangle lines within an image with line thickness
proc ImageDrawRectangleLinesEx*(dst: ptr Image, rec: Rectangle, thick: int32, color: Color)
# Draw rectangle with gradient colors within an image, counter-clockwise color order
proc ImageDrawRectangleGradientEx*(dst: ptr Image, rec: Rectangle, col1: Color, col2: Color, col3: Color, col4: Color)
# Draw a filled circle within an image
proc ImageDrawCircle*(dst: ptr Image, centerX: int32, centerY: int32, radius: int32, color: Color)
# Draw a filled circle within an image (Vector version)
proc ImageDrawCircleV*(dst: ptr Image, center: Vector2, radius: int32, color: Color)
# Draw circle outline within an image
proc ImageDrawCircleLines*(dst: ptr Image, centerX: int32, centerY: int32, radius: int32, color: Color)
# Draw circle outline within an image (Vector version)
proc ImageDrawCircleLinesV*(dst: ptr Image, center: Vector2, radius: int32, color: Color)
# Draw a gradient-filled circle within an image
proc ImageDrawCircleGradient*(dst: ptr Image, center: Vector2, radius: float32, inner: Color, outer: Color)
# Draw an image within an image
proc ImageDrawImage*(dst: ptr Image, src: Image, posX: int32, posY: int32, tint: Color)
# Draw an image with scaling and rotation within an image
proc ImageDrawImageEx*(dst: ptr Image, src: Image, position: Vector2, rotation: float32, scale: float32, tint: Color)
# Draw a part of an image defined by a rectangle within an image
proc ImageDrawImageRec*(dst: ptr Image, src: Image, srcRec: Rectangle, position: Vector2, tint: Color)
# Draw a part of an image defined by a rectangle into destination rectangle, with scaling and rotation, within an image
proc ImageDrawImagePro*(dst: ptr Image, src: Image, srcRec: Rectangle, dstRec: Rectangle, origin: Vector2, rotation: float32, tint: Color)
# Draw text (using default font) within an image (destination)
proc ImageDrawText*(dst: ptr Image, text: cstring, posX: int32, posY: int32, fontSize: int32, color: Color)
# Draw text (custom sprite font) within an image (destination)
proc ImageDrawTextEx*(dst: ptr Image, font: Font, text: cstring, position: Vector2, fontSize: float32, spacing: float32, tint: Color)
# Draw text using Font and pro parameters (rotation)
proc ImageDrawTextPro*(dst: ptr Image, font: Font, text: cstring, position: Vector2, origin: Vector2, rotation: float32, fontSize: float32, spacing: float32, tint: Color)
# Load texture from file into GPU memory (VRAM)
proc LoadTexture*(fileName: cstring): Texture2D
# Load texture from image data
proc LoadTextureFromImage*(image: Image): Texture2D
# Load cubemap from image, multiple image cubemap layouts supported
proc LoadTextureCubemap*(image: Image, layout: int32): TextureCubemap
# Load texture for rendering (framebuffer)
proc LoadRenderTexture*(width: int32, height: int32): RenderTexture2D
# Load texture for rendering (framebuffer), with specific format
proc LoadRenderTextureEx*(width: int32, height: int32, format: int32): RenderTexture2D
# Check if texture is valid (loaded in GPU)
proc IsTextureValid*(texture: Texture2D): bool
# Unload texture from GPU memory (VRAM)
proc UnloadTexture*(texture: Texture2D)
# Check if render texture is valid (loaded in GPU)
proc IsRenderTextureValid*(target: RenderTexture2D): bool
# Unload render texture from GPU memory (VRAM)
proc UnloadRenderTexture*(target: RenderTexture2D)
# Update GPU texture with new data (pixels should be able to fill texture)
proc UpdateTexture*(texture: Texture2D, pixels: pointer)
# Update GPU texture rectangle with new data (pixels and rec should fit in texture)
proc UpdateTextureRec*(texture: Texture2D, rec: Rectangle, pixels: pointer)
# Generate GPU mipmaps for a texture
proc GenTextureMipmaps*(texture: ptr Texture2D)
# Set texture scaling filter mode
proc SetTextureFilter*(texture: Texture2D, filter: int32)
# Set texture wrapping mode
proc SetTextureWrap*(texture: Texture2D, wrap: int32)
# Draw a Texture2D
proc DrawTexture*(texture: Texture2D, posX: int32, posY: int32, tint: Color)
# Draw a Texture2D with position defined as Vector2
proc DrawTextureV*(texture: Texture2D, position: Vector2, tint: Color)
# Draw a Texture2D with rotation and scale
proc DrawTextureEx*(texture: Texture2D, position: Vector2, rotation: float32, scale: float32, tint: Color)
# Draw a part of a texture defined by a rectangle
proc DrawTextureRec*(texture: Texture2D, rec: Rectangle, position: Vector2, tint: Color)
# Draw a part of a texture defined by a source rectangle to destination rectangle, with scaling and rotation
proc DrawTexturePro*(texture: Texture2D, srcrec: Rectangle, dstrec: Rectangle, origin: Vector2, rotation: float32, tint: Color)
# Draw a texture (or part of it) that stretches or shrinks nicely
proc DrawTextureNPatch*(texture: Texture2D, nPatchInfo: NPatchInfo, dstrec: Rectangle, origin: Vector2, rotation: float32, tint: Color)
# Check if two colors are equal
proc ColorIsEqual*(col1: Color, col2: Color): bool
# Get color with alpha applied, alpha goes from 0.0f to 1.0f
proc Fade*(color: Color, alpha: float32): Color
# Get hexadecimal value for a Color (0xRRGGBBAA)
proc ColorToInt*(color: Color): int32
# Get Color normalized as float [0..1]
proc ColorNormalize*(color: Color): Vector4
# Get Color from normalized values [0..1]
proc ColorFromNormalized*(normalized: Vector4): Color
# Get HSV values for a Color, hue [0..360], saturation/value [0..1]
proc ColorToHSV*(color: Color): Vector3
# Get a Color from HSV values, hue [0..360], saturation/value [0..1]
proc ColorFromHSV*(hue: float32, saturation: float32, value: float32): Color
# Get color multiplied with another color
proc ColorTint*(color: Color, tint: Color): Color
# Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
proc ColorBrightness*(color: Color, factor: float32): Color
# Get color with contrast correction, contrast values between -1.0f and 1.0f
proc ColorContrast*(color: Color, contrast: float32): Color
# Get color with alpha applied, alpha goes from 0.0f to 1.0f
proc ColorAlpha*(color: Color, alpha: float32): Color
# Get src alpha-blended into dst color with tint
proc ColorAlphaBlend*(dst: Color, src: Color, tint: Color): Color
# Get color lerp interpolation between two colors, factor [0.0f..1.0f]
proc ColorLerp*(color1: Color, color2: Color, factor: float32): Color
# Get Color structure from hexadecimal value
proc GetColor*(hexValue: uint32): Color
# Get Color from a source pixel pointer of certain format
proc GetPixelColor*(srcPtr: pointer, format: int32): Color
# Set color formatted into destination pixel pointer
proc SetPixelColor*(dstPtr: pointer, color: Color, format: int32)
# Get pixel data size in bytes for certain format
proc GetPixelDataSize*(width: int32, height: int32, format: int32): int32
# Get the default Font
proc GetFontDefault*(): Font
# Load font from file into GPU memory (VRAM)
proc LoadFont*(fileName: cstring): Font
# Load font from file with defined codepoints and generation size, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
proc LoadFontEx*(fileName: cstring, fontSize: int32, codepoints: ptr int32, codepointCount: int32): Font
# Load font from Image (XNA style)
proc LoadFontFromImage*(image: Image, key: Color, firstChar: int32): Font
# Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
proc LoadFontFromMemory*(fileType: cstring, fileData: ptr uint8, dataSize: int32, fontSize: int32, codepoints: ptr int32, codepointCount: int32): Font
# Check if font is valid (font data loaded, WARNING: GPU texture not checked)
proc IsFontValid*(font: Font): bool
# Load font data for further use
proc LoadFontData*(fileData: ptr uint8, dataSize: int32, fontSize: int32, codepoints: ptr int32, codepointCount: int32, `type`: int32, glyphCount: ptr int32): ptr GlyphInfo
# Generate image font atlas using chars info
proc GenImageFontAtlas*(glyphs: ptr GlyphInfo, glyphRecs: ptr ptr Rectangle, glyphCount: int32, fontSize: int32, padding: int32, packMethod: int32): Image
# Unload font chars info data (RAM)
proc UnloadFontData*(glyphs: ptr GlyphInfo, glyphCount: int32)
# Unload font from GPU memory (VRAM)
proc UnloadFont*(font: Font)
# Export font as code file, returns true on success
proc ExportFontAsCode*(font: Font, fileName: cstring): bool
# Draw current FPS
proc DrawFPS*(posX: int32, posY: int32)
# Draw text (using default font)
proc DrawText*(text: cstring, posX: int32, posY: int32, fontSize: int32, color: Color)
# Draw text using font and additional parameters
proc DrawTextEx*(font: Font, text: cstring, position: Vector2, fontSize: float32, spacing: float32, tint: Color)
# Draw text using Font and pro parameters (rotation)
proc DrawTextPro*(font: Font, text: cstring, position: Vector2, origin: Vector2, rotation: float32, fontSize: float32, spacing: float32, tint: Color)
# Draw one character (codepoint)
proc DrawTextCodepoint*(font: Font, codepoint: int32, position: Vector2, fontSize: float32, tint: Color)
# Draw multiple characters (codepoint)
proc DrawTextCodepoints*(font: Font, codepoints: ptr int32, codepointCount: int32, position: Vector2, fontSize: float32, spacing: float32, tint: Color)
# Set vertical line spacing when drawing with line-breaks
proc SetTextLineSpacing*(spacing: int32)
# Measure string width for default font
proc MeasureText*(text: cstring, fontSize: int32): int32
# Measure string size for Font
proc MeasureTextEx*(font: Font, text: cstring, fontSize: float32, spacing: float32): Vector2
# Measure string size for an existing array of codepoints for Font
proc MeasureTextCodepoints*(font: Font, codepoints: ptr int32, length: int32, fontSize: float32, spacing: float32): Vector2
# Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
proc GetGlyphIndex*(font: Font, codepoint: int32): int32
# Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
proc GetGlyphInfo*(font: Font, codepoint: int32): GlyphInfo
# Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
proc GetGlyphAtlasRec*(font: Font, codepoint: int32): Rectangle
# Load UTF-8 text encoded from codepoints array
proc LoadUTF8*(codepoints: ptr int32, length: int32): cstring
# Unload UTF-8 text encoded from codepoints array
proc UnloadUTF8*(text: cstring)
# Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
proc LoadCodepoints*(text: cstring, count: ptr int32): ptr int32
# Unload codepoints data from memory
proc UnloadCodepoints*(codepoints: ptr int32)
# Get total number of codepoints in a UTF-8 encoded string
proc GetCodepointCount*(text: cstring): int32
# Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
proc GetCodepoint*(text: cstring, codepointSize: ptr int32): int32
# Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
proc GetCodepointNext*(text: cstring, codepointSize: ptr int32): int32
# Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
proc GetCodepointPrevious*(text: cstring, codepointSize: ptr int32): int32
# Encode one codepoint into UTF-8 byte array (array length returned as parameter)
proc CodepointToUTF8*(codepoint: int32, utf8Size: ptr int32): cstring
# Load text as separate lines ('\n')
proc LoadTextLines*(text: cstring, count: ptr int32): cstringArray
# Unload text lines
proc UnloadTextLines*(text: cstringArray, lineCount: int32)
# Copy one string to another, returns bytes copied
proc TextCopy*(dst: cstring, src: cstring): int32
# Check if two text strings are equal
proc TextIsEqual*(text1: cstring, text2: cstring): bool
# Get text length, checks for '\0' ending
proc TextLength*(text: cstring): uint32
# Get a piece of a text string
proc TextSubtext*(text: cstring, position: int32, length: int32): cstring
# Remove text spaces, concat words
proc TextRemoveSpaces*(text: cstring): cstring
# Get text between two strings
proc GetTextBetween*(text: cstring, begin: cstring, `end`: cstring): cstring
# Replace text string with new string
proc TextReplace*(text: cstring, search: cstring, replacement: cstring): cstring
# Replace text string with new string, memory must be MemFree()
proc TextReplaceAlloc*(text: cstring, search: cstring, replacement: cstring): cstring
# Replace text between two specific strings
proc TextReplaceBetween*(text: cstring, begin: cstring, `end`: cstring, replacement: cstring): cstring
# Replace text between two specific strings, memory must be MemFree()
proc TextReplaceBetweenAlloc*(text: cstring, begin: cstring, `end`: cstring, replacement: cstring): cstring
# Insert text in a defined byte position
proc TextInsert*(text: cstring, insert: cstring, position: int32): cstring
# Insert text in a defined byte position, memory must be MemFree()
proc TextInsertAlloc*(text: cstring, insert: cstring, position: int32): cstring
# Join text strings with delimiter
proc TextJoin*(textList: cstringArray, count: int32, delimiter: cstring): cstring
# Split text into multiple strings, using MAX_TEXTSPLIT_COUNT static strings
proc TextSplit*(text: cstring, delimiter: int8, count: ptr int32): cstringArray
# Append text at specific position and move cursor
proc TextAppend*(text: cstring, append: cstring, position: ptr int32)
# Find first text occurrence within a string, -1 if not found
proc TextFindIndex*(text: cstring, search: cstring): int32
# Get upper case version of provided string
proc TextToUpper*(text: cstring): cstring
# Get lower case version of provided string
proc TextToLower*(text: cstring): cstring
# Get Pascal case notation version of provided string
proc TextToPascal*(text: cstring): cstring
# Get Snake case notation version of provided string
proc TextToSnake*(text: cstring): cstring
# Get Camel case notation version of provided string
proc TextToCamel*(text: cstring): cstring
# Get integer value from text
proc TextToInteger*(text: cstring): int32
# Get float value from text
proc TextToFloat*(text: cstring): float32
# Draw a line in 3D world space
proc DrawLine3D*(startPos: Vector3, endPos: Vector3, color: Color)
# Draw a point in 3D space, actually a small line
proc DrawPoint3D*(position: Vector3, color: Color)
# Draw a circle in 3D world space
proc DrawCircle3D*(center: Vector3, radius: float32, rotationAxis: Vector3, rotationAngle: float32, color: Color)
# Draw a color-filled triangle, counter-clockwise vertex order
proc DrawTriangle3D*(v1: Vector3, v2: Vector3, v3: Vector3, color: Color)
# Draw a triangle strip defined by points
proc DrawTriangleStrip3D*(points: ptr Vector3, pointCount: int32, color: Color)
# Draw cube
proc DrawCube*(position: Vector3, width: float32, height: float32, length: float32, color: Color)
# Draw cube (Vector version)
proc DrawCubeV*(position: Vector3, size: Vector3, color: Color)
# Draw cube wires
proc DrawCubeWires*(position: Vector3, width: float32, height: float32, length: float32, color: Color)
# Draw cube wires (Vector version)
proc DrawCubeWiresV*(position: Vector3, size: Vector3, color: Color)
# Draw sphere
proc DrawSphere*(centerPos: Vector3, radius: float32, color: Color)
# Draw sphere with defined rings and slices
proc DrawSphereEx*(centerPos: Vector3, radius: float32, rings: int32, slices: int32, color: Color)
# Draw sphere wires
proc DrawSphereWires*(centerPos: Vector3, radius: float32, rings: int32, slices: int32, color: Color)
# Draw a cylinder/cone
proc DrawCylinder*(position: Vector3, radiusTop: float32, radiusBottom: float32, height: float32, sides: int32, color: Color)
# Draw a cylinder with base at startPos and top at endPos
proc DrawCylinderEx*(startPos: Vector3, endPos: Vector3, startRadius: float32, endRadius: float32, sides: int32, color: Color)
# Draw a cylinder/cone wires
proc DrawCylinderWires*(position: Vector3, radiusTop: float32, radiusBottom: float32, height: float32, sides: int32, color: Color)
# Draw a cylinder wires with base at startPos and top at endPos
proc DrawCylinderWiresEx*(startPos: Vector3, endPos: Vector3, startRadius: float32, endRadius: float32, sides: int32, color: Color)
# Draw a capsule with the center of its sphere caps at startPos and endPos
proc DrawCapsule*(startPos: Vector3, endPos: Vector3, radius: float32, rings: int32, slices: int32, color: Color)
# Draw capsule wireframe with the center of its sphere caps at startPos and endPos
proc DrawCapsuleWires*(startPos: Vector3, endPos: Vector3, radius: float32, rings: int32, slices: int32, color: Color)
# Draw a plane XZ
proc DrawPlane*(centerPos: Vector3, size: Vector2, color: Color)
# Draw a ray line
proc DrawRay*(ray: Ray, color: Color)
# Draw a grid (centered at (0, 0, 0))
proc DrawGrid*(slices: int32, spacing: float32)
# Load model from files (meshes and materials)
proc LoadModel*(fileName: cstring): Model
# Load model from generated mesh (default material)
proc LoadModelFromMesh*(mesh: Mesh): Model
# Check if model is valid (loaded in GPU, VAO/VBOs)
proc IsModelValid*(model: Model): bool
# Unload model (including meshes) from memory (RAM and/or VRAM)
proc UnloadModel*(model: Model)
# Compute model bounding box limits (considers all meshes)
proc GetModelBoundingBox*(model: Model): BoundingBox
# Draw a model (with texture if set)
proc DrawModel*(model: Model, position: Vector3, scale: float32, tint: Color)
# Draw a model with custom transform
proc DrawModelEx*(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: float32, scale: Vector3, tint: Color)
# Draw a model wires (with texture if set)
proc DrawModelWires*(model: Model, position: Vector3, scale: float32, tint: Color)
# Draw a model wires with custom transform
proc DrawModelWiresEx*(model: Model, position: Vector3, rotationAxis: Vector3, rotationAngle: float32, scale: Vector3, tint: Color)
# Draw bounding box (wires)
proc DrawBoundingBox*(box: BoundingBox, color: Color)
# Draw a billboard texture
proc DrawBillboard*(camera: Camera, texture: Texture2D, position: Vector3, scale: float32, tint: Color)
# Draw a billboard texture defined by rectangle
proc DrawBillboardRec*(camera: Camera, texture: Texture2D, rec: Rectangle, position: Vector3, size: Vector2, tint: Color)
# Draw a billboard texture defined by source rectangle with scaling and rotation
proc DrawBillboardPro*(camera: Camera, texture: Texture2D, rec: Rectangle, position: Vector3, up: Vector3, size: Vector2, origin: Vector2, rotation: float32, tint: Color)
# Upload mesh vertex data in GPU and provide VAO/VBO ids
proc UploadMesh*(mesh: ptr Mesh, dynamic: bool)
# Update mesh vertex data in GPU for a specific buffer index
proc UpdateMeshBuffer*(mesh: Mesh, index: int32, data: pointer, dataSize: int32, offset: int32)
# Unload mesh data from CPU and GPU
proc UnloadMesh*(mesh: Mesh)
# Draw a 3d mesh with material and transform
proc DrawMesh*(mesh: Mesh, material: Material, transform: Matrix)
# Draw multiple mesh instances with material and different transforms
proc DrawMeshInstanced*(mesh: Mesh, material: Material, transforms: ptr Matrix, instances: int32)
# Compute mesh bounding box limits
proc GetMeshBoundingBox*(mesh: Mesh): BoundingBox
# Compute mesh tangents
proc GenMeshTangents*(mesh: ptr Mesh)
# Export mesh data to file, returns true on success
proc ExportMesh*(mesh: Mesh, fileName: cstring): bool
# Export mesh as code file (.h) defining multiple arrays of vertex attributes
proc ExportMeshAsCode*(mesh: Mesh, fileName: cstring): bool
# Generate polygonal mesh
proc GenMeshPoly*(sides: int32, radius: float32): Mesh
# Generate plane mesh (with subdivisions)
proc GenMeshPlane*(width: float32, length: float32, resX: int32, resZ: int32): Mesh
# Generate cuboid mesh
proc GenMeshCube*(width: float32, height: float32, length: float32): Mesh
# Generate sphere mesh (standard sphere)
proc GenMeshSphere*(radius: float32, rings: int32, slices: int32): Mesh
# Generate half-sphere mesh (no bottom cap)
proc GenMeshHemiSphere*(radius: float32, rings: int32, slices: int32): Mesh
# Generate cylinder mesh
proc GenMeshCylinder*(radius: float32, height: float32, slices: int32): Mesh
# Generate cone/pyramid mesh
proc GenMeshCone*(radius: float32, height: float32, slices: int32): Mesh
# Generate torus mesh
proc GenMeshTorus*(radius: float32, size: float32, radSeg: int32, sides: int32): Mesh
# Generate trefoil knot mesh
proc GenMeshKnot*(radius: float32, size: float32, radSeg: int32, sides: int32): Mesh
# Generate heightmap mesh from image data
proc GenMeshHeightmap*(heightmap: Image, size: Vector3): Mesh
# Generate cubes-based map mesh from image data
proc GenMeshCubicmap*(cubicmap: Image, cubeSize: Vector3): Mesh
# Load materials from model file
proc LoadMaterials*(fileName: cstring, materialCount: ptr int32): ptr Material
# Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
proc LoadMaterialDefault*(): Material
# Check if material is valid (shader assigned, map textures loaded in GPU)
proc IsMaterialValid*(material: Material): bool
# Unload material from GPU memory (VRAM)
proc UnloadMaterial*(material: Material)
# Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
proc SetMaterialTexture*(material: ptr Material, mapType: int32, texture: Texture2D)
# Set material for a mesh
proc SetModelMeshMaterial*(model: ptr Model, meshId: int32, materialId: int32)
# Load model animations from file
proc LoadModelAnimations*(fileName: cstring, animCount: ptr int32): ptr ModelAnimation
# Update model animation pose (vertex buffers and bone matrices)
proc UpdateModelAnimation*(model: Model, anim: ModelAnimation, frame: float32)
# Update model animation pose, blending two animations
proc UpdateModelAnimationEx*(model: Model, animA: ModelAnimation, frameA: float32, animB: ModelAnimation, frameB: float32, blend: float32)
# Unload animation array data
proc UnloadModelAnimations*(animations: ptr ModelAnimation, animCount: int32)
# Check model animation skeleton match
proc IsModelAnimationValid*(model: Model, anim: ModelAnimation): bool
# Check collision between two spheres
proc CheckCollisionSpheres*(center1: Vector3, radius1: float32, center2: Vector3, radius2: float32): bool
# Check collision between two bounding boxes
proc CheckCollisionBoxes*(box1: BoundingBox, box2: BoundingBox): bool
# Check collision between box and sphere
proc CheckCollisionBoxSphere*(box: BoundingBox, center: Vector3, radius: float32): bool
# Get collision info between ray and sphere
proc GetRayCollisionSphere*(ray: Ray, center: Vector3, radius: float32): RayCollision
# Get collision info between ray and box
proc GetRayCollisionBox*(ray: Ray, box: BoundingBox): RayCollision
# Get collision info between ray and mesh
proc GetRayCollisionMesh*(ray: Ray, mesh: Mesh, transform: Matrix): RayCollision
# Get collision info between ray and triangle
proc GetRayCollisionTriangle*(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3): RayCollision
# Get collision info between ray and quad
proc GetRayCollisionQuad*(ray: Ray, p1: Vector3, p2: Vector3, p3: Vector3, p4: Vector3): RayCollision
# Initialize audio device and context
proc InitAudioDevice*()
# Close the audio device and context
proc CloseAudioDevice*()
# Check if audio device has been initialized successfully
proc IsAudioDeviceReady*(): bool
# Set master volume (listener)
proc SetMasterVolume*(volume: float32)
# Get master volume (listener)
proc GetMasterVolume*(): float32
# Load wave data from file
proc LoadWave*(fileName: cstring): Wave
# Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
proc LoadWaveFromMemory*(fileType: cstring, fileData: ptr uint8, dataSize: int32): Wave
# Check if wave data is valid (data loaded and parameters)
proc IsWaveValid*(wave: Wave): bool
# Load sound from file
proc LoadSound*(fileName: cstring): Sound
# Load sound from wave data
proc LoadSoundFromWave*(wave: Wave): Sound
# Load sound alias, new sound that shares the same sample data as the source sound, does not own the sound data
proc LoadSoundAlias*(source: Sound): Sound
# Check if sound is valid (data loaded and buffers initialized)
proc IsSoundValid*(sound: Sound): bool
# Update sound buffer with new data (default data format: 32 bit float, stereo)
proc UpdateSound*(sound: Sound, data: pointer, frameCount: int32)
# Unload wave data
proc UnloadWave*(wave: Wave)
# Unload sound
proc UnloadSound*(sound: Sound)
# Unload sound alias (does not deallocate sample data)
proc UnloadSoundAlias*(alias: Sound)
# Export wave data to file, returns true on success
proc ExportWave*(wave: Wave, fileName: cstring): bool
# Export wave sample data to code (.h), returns true on success
proc ExportWaveAsCode*(wave: Wave, fileName: cstring): bool
# Play a sound
proc PlaySound*(sound: Sound)
# Stop playing a sound
proc StopSound*(sound: Sound)
# Pause a sound
proc PauseSound*(sound: Sound)
# Resume a paused sound
proc ResumeSound*(sound: Sound)
# Check if sound is currently playing
proc IsSoundPlaying*(sound: Sound): bool
# Set volume for a sound (1.0 is max level)
proc SetSoundVolume*(sound: Sound, volume: float32)
# Set pitch for a sound (1.0 is base level)
proc SetSoundPitch*(sound: Sound, pitch: float32)
# Set pan for a sound (-1.0 left, 0.0 center, 1.0 right)
proc SetSoundPan*(sound: Sound, pan: float32)
# Copy a wave to a new wave
proc WaveCopy*(wave: Wave): Wave
# Crop a wave to defined frames range
proc WaveCrop*(wave: ptr Wave, initFrame: int32, finalFrame: int32)
# Convert wave data to desired format
proc WaveFormat*(wave: ptr Wave, sampleRate: int32, sampleSize: int32, channels: int32)
# Load samples data from wave as a 32bit float data array
proc LoadWaveSamples*(wave: Wave): ptr float32
# Unload samples data loaded with LoadWaveSamples()
proc UnloadWaveSamples*(samples: ptr float32)
# Load music stream from file
proc LoadMusicStream*(fileName: cstring): Music
# Load music stream from data
proc LoadMusicStreamFromMemory*(fileType: cstring, data: ptr uint8, dataSize: int32): Music
# Check if music stream is valid (context and buffers initialized)
proc IsMusicValid*(music: Music): bool
# Unload music stream
proc UnloadMusicStream*(music: Music)
# Start music playing
proc PlayMusicStream*(music: Music)
# Check if music is playing
proc IsMusicStreamPlaying*(music: Music): bool
# Update buffers for music streaming
proc UpdateMusicStream*(music: Music)
# Stop music playing
proc StopMusicStream*(music: Music)
# Pause music playing
proc PauseMusicStream*(music: Music)
# Resume playing paused music
proc ResumeMusicStream*(music: Music)
# Seek music to a position (in seconds)
proc SeekMusicStream*(music: Music, position: float32)
# Set volume for music (1.0 is max level)
proc SetMusicVolume*(music: Music, volume: float32)
# Set pitch for music (1.0 is base level)
proc SetMusicPitch*(music: Music, pitch: float32)
# Set pan for music (-1.0 left, 0.0 center, 1.0 right)
proc SetMusicPan*(music: Music, pan: float32)
# Get music time length (in seconds)
proc GetMusicTimeLength*(music: Music): float32
# Get current music time played (in seconds)
proc GetMusicTimePlayed*(music: Music): float32
# Load audio stream (to stream raw audio pcm data)
proc LoadAudioStream*(sampleRate: uint32, sampleSize: uint32, channels: uint32): AudioStream
# Check if an audio stream is valid (buffers initialized)
proc IsAudioStreamValid*(stream: AudioStream): bool
# Unload audio stream and free memory
proc UnloadAudioStream*(stream: AudioStream)
# Update audio stream buffers with data
proc UpdateAudioStream*(stream: AudioStream, data: pointer, frameCount: int32)
# Check if any audio stream buffers requires refill
proc IsAudioStreamProcessed*(stream: AudioStream): bool
# Play audio stream
proc PlayAudioStream*(stream: AudioStream)
# Pause audio stream
proc PauseAudioStream*(stream: AudioStream)
# Resume audio stream
proc ResumeAudioStream*(stream: AudioStream)
# Check if audio stream is playing
proc IsAudioStreamPlaying*(stream: AudioStream): bool
# Stop audio stream
proc StopAudioStream*(stream: AudioStream)
# Set volume for audio stream (1.0 is max level)
proc SetAudioStreamVolume*(stream: AudioStream, volume: float32)
# Set pitch for audio stream (1.0 is base level)
proc SetAudioStreamPitch*(stream: AudioStream, pitch: float32)
# Set pan for audio stream (-1.0 left, 0.0 center, 1.0 right)
proc SetAudioStreamPan*(stream: AudioStream, pan: float32)
# Default size for new audio streams
proc SetAudioStreamBufferSizeDefault*(size: int32)
# Audio thread callback to request new data
proc SetAudioStreamCallback*(stream: AudioStream, callback: AudioCallback)
# Attach audio stream processor to stream, receives frames x 2 samples as 'float' (stereo)
proc AttachAudioStreamProcessor*(stream: AudioStream, processor: AudioCallback)
# Detach audio stream processor from stream
proc DetachAudioStreamProcessor*(stream: AudioStream, processor: AudioCallback)
# Attach audio stream processor to the entire audio pipeline, receives frames x 2 samples as 'float' (stereo)
proc AttachAudioMixedProcessor*(processor: AudioCallback)
# Detach audio stream processor from the entire audio pipeline
proc DetachAudioMixedProcessor*(processor: AudioCallback)


# Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
proc TraceLog*(logLevel: TraceLogLevel, text: cstring) {.varargs.}
# Text formatting with variables (sprintf() style)
proc TextFormat*(text: cstring): cstring {.varargs.}

{.pop.}
