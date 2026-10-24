from raylib import
  PixelFormat, TextureFilter, BlendMode, ShaderLocationIndex, ShaderUniformDataType,
  ShaderAttributeDataType, Matrix, Vector2, Vector3, Color
export
  PixelFormat, TextureFilter, BlendMode, ShaderLocationIndex, ShaderUniformDataType,
  ShaderAttributeDataType, Matrix, Vector2, Vector3, Color

const RLGL_VERSION* = "6.0"

const RL_DEFAULT_BATCH_BUFFER_ELEMENTS* = 8192
const RL_DEFAULT_BATCH_BUFFERS* = 1# Default number of batch buffers (multi-buffering)
const RL_DEFAULT_BATCH_DRAWCALLS* = 256# Default number of batch draw calls (by state changes: mode, texture)
const RL_DEFAULT_BATCH_MAX_TEXTURE_UNITS* = 4# Maximum number of textures units that can be activated on batch drawing (SetShaderValueTexture())
const RL_MAX_MATRIX_STACK_SIZE* = 32# Maximum size of Matrix stack
const RL_MAX_SHADER_LOCATIONS* = 32# Maximum number of shader locations supported
const RL_CULL_DISTANCE_NEAR* = 0.05# Default near cull distance
const RL_CULL_DISTANCE_FAR* = 4000.0# Default far cull distance
const RL_TEXTURE_WRAP_S* = 10242# GL_TEXTURE_WRAP_S
const RL_TEXTURE_WRAP_T* = 10243# GL_TEXTURE_WRAP_T
const RL_TEXTURE_MAG_FILTER* = 10240# GL_TEXTURE_MAG_FILTER
const RL_TEXTURE_MIN_FILTER* = 10241# GL_TEXTURE_MIN_FILTER
const RL_TEXTURE_FILTER_NEAREST* = 9728# GL_NEAREST
const RL_TEXTURE_FILTER_LINEAR* = 9729# GL_LINEAR
const RL_TEXTURE_FILTER_MIP_NEAREST* = 9984# GL_NEAREST_MIPMAP_NEAREST
const RL_TEXTURE_FILTER_NEAREST_MIP_LINEAR* = 9986# GL_NEAREST_MIPMAP_LINEAR
const RL_TEXTURE_FILTER_LINEAR_MIP_NEAREST* = 9985# GL_LINEAR_MIPMAP_NEAREST
const RL_TEXTURE_FILTER_MIP_LINEAR* = 9987# GL_LINEAR_MIPMAP_LINEAR
const RL_TEXTURE_FILTER_ANISOTROPIC* = 12288# Anisotropic filter (custom identifier)
const RL_TEXTURE_MIPMAP_BIAS_RATIO* = 16384# Texture mipmap bias, percentage ratio (custom identifier)
const RL_TEXTURE_WRAP_REPEAT* = 10497# GL_REPEAT
const RL_TEXTURE_WRAP_CLAMP* = 33071# GL_CLAMP_TO_EDGE
const RL_TEXTURE_WRAP_MIRROR_REPEAT* = 33648# GL_MIRRORED_REPEAT
const RL_TEXTURE_WRAP_MIRROR_CLAMP* = 34626# GL_MIRROR_CLAMP_EXT
const RL_MODELVIEW* = 5888# GL_MODELVIEW
const RL_PROJECTION* = 5889# GL_PROJECTION
const RL_TEXTURE* = 5890# GL_TEXTURE
const RL_LINES* = 1# GL_LINES
const RL_TRIANGLES* = 4# GL_TRIANGLES
const RL_QUADS* = 7# GL_QUADS
const RL_UNSIGNED_BYTE* = 5121# GL_UNSIGNED_BYTE
const RL_FLOAT* = 5126# GL_FLOAT
const RL_STREAM_DRAW* = 35040# GL_STREAM_DRAW
const RL_STREAM_READ* = 35041# GL_STREAM_READ
const RL_STREAM_COPY* = 35042# GL_STREAM_COPY
const RL_STATIC_DRAW* = 35044# GL_STATIC_DRAW
const RL_STATIC_READ* = 35045# GL_STATIC_READ
const RL_STATIC_COPY* = 35046# GL_STATIC_COPY
const RL_DYNAMIC_DRAW* = 35048# GL_DYNAMIC_DRAW
const RL_DYNAMIC_READ* = 35049# GL_DYNAMIC_READ
const RL_DYNAMIC_COPY* = 35050# GL_DYNAMIC_COPY
const RL_FRAGMENT_SHADER* = 35632# GL_FRAGMENT_SHADER
const RL_VERTEX_SHADER* = 35633# GL_VERTEX_SHADER
const RL_COMPUTE_SHADER* = 37305# GL_COMPUTE_SHADER
const RL_ZERO* = 0# GL_ZERO
const RL_ONE* = 1# GL_ONE
const RL_SRC_COLOR* = 768# GL_SRC_COLOR
const RL_ONE_MINUS_SRC_COLOR* = 769# GL_ONE_MINUS_SRC_COLOR
const RL_SRC_ALPHA* = 770# GL_SRC_ALPHA
const RL_ONE_MINUS_SRC_ALPHA* = 771# GL_ONE_MINUS_SRC_ALPHA
const RL_DST_ALPHA* = 772# GL_DST_ALPHA
const RL_ONE_MINUS_DST_ALPHA* = 773# GL_ONE_MINUS_DST_ALPHA
const RL_DST_COLOR* = 774# GL_DST_COLOR
const RL_ONE_MINUS_DST_COLOR* = 775# GL_ONE_MINUS_DST_COLOR
const RL_SRC_ALPHA_SATURATE* = 776# GL_SRC_ALPHA_SATURATE
const RL_CONSTANT_COLOR* = 32769# GL_CONSTANT_COLOR
const RL_ONE_MINUS_CONSTANT_COLOR* = 32770# GL_ONE_MINUS_CONSTANT_COLOR
const RL_CONSTANT_ALPHA* = 32771# GL_CONSTANT_ALPHA
const RL_ONE_MINUS_CONSTANT_ALPHA* = 32772# GL_ONE_MINUS_CONSTANT_ALPHA
const RL_FUNC_ADD* = 32774# GL_FUNC_ADD
const RL_MIN* = 32775# GL_MIN
const RL_MAX* = 32776# GL_MAX
const RL_FUNC_SUBTRACT* = 32778# GL_FUNC_SUBTRACT
const RL_FUNC_REVERSE_SUBTRACT* = 32779# GL_FUNC_REVERSE_SUBTRACT
const RL_BLEND_EQUATION* = 32777# GL_BLEND_EQUATION
const RL_BLEND_EQUATION_RGB* = 32777# GL_BLEND_EQUATION_RGB   // (Same as BLEND_EQUATION)
const RL_BLEND_EQUATION_ALPHA* = 34877# GL_BLEND_EQUATION_ALPHA
const RL_BLEND_DST_RGB* = 32968# GL_BLEND_DST_RGB
const RL_BLEND_SRC_RGB* = 32969# GL_BLEND_SRC_RGB
const RL_BLEND_DST_ALPHA* = 32970# GL_BLEND_DST_ALPHA
const RL_BLEND_SRC_ALPHA* = 32971# GL_BLEND_SRC_ALPHA
const RL_BLEND_COLOR* = 32773# GL_BLEND_COLOR
const RL_READ_FRAMEBUFFER* = 36008# GL_READ_FRAMEBUFFER
const RL_DRAW_FRAMEBUFFER* = 36009# GL_DRAW_FRAMEBUFFER
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_POSITION* = 0
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD* = 1
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_NORMAL* = 2
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_COLOR* = 3
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TANGENT* = 4
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_TEXCOORD2* = 5
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_INDICES* = 6
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_BONEINDICES* = 7
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_BONEWEIGHTS* = 8
const RL_DEFAULT_SHADER_ATTRIB_LOCATION_INSTANCETRANSFORM* = 9

type
# Dynamic vertex buffers (position + texcoords + colors + indices arrays)
  rlVertexBuffer* {.completeStruct, bycopy, importc, header: "rlgl.h".} = object
    elementCount*: int32 # Number of elements in the buffer (QUADS)
    vertices*: ptr float32 # Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    texcoords*: ptr float32 # Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    normals*: ptr float32 # Vertex normal (XYZ - 3 components per vertex) (shader-location = 2)
    colors*: ptr uint8 # Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    indices*: ptr uint32 # Vertex indices (in case vertex data comes indexed) (6 indices per quad)
    vaoId*: uint32 # OpenGL Vertex Array Object id
    vboId*: array[5, uint32] # OpenGL Vertex Buffer Objects id (5 types of vertex data)

# of those state-change happens (this is done in core module)
  rlDrawCall* {.completeStruct, bycopy, importc, header: "rlgl.h".} = object
    mode*: int32 # Drawing mode: LINES, TRIANGLES, QUADS
    vertexCount*: int32 # Number of vertex of the draw
    vertexAlignment*: int32 # Number of vertex required for index alignment (LINES, TRIANGLES)
    textureId*: uint32 # Texture id to be used on the draw -> Use to create new draw call if changes

# rlRenderBatch type
  rlRenderBatch* {.completeStruct, bycopy, importc, header: "rlgl.h".} = object
    bufferCount*: int32 # Number of vertex buffers (multi-buffering support)
    currentBuffer*: int32 # Current buffer tracking in case of multi-buffering
    vertexBuffer*: ptr rlVertexBuffer # Dynamic buffer(s) for vertex data
    draws*: ptr rlDrawCall # Draw calls array, depends on textureId
    drawCounter*: int32 # Draw calls counter
    currentDepth*: float32 # Current depth value for next draw


# OpenGL version
  rlGlVersion* {.size: sizeof(int32).} = enum
    RL_OPENGL_SOFTWARE = 0 # Software rendering
    RL_OPENGL_11 = 1 # OpenGL 1.1
    RL_OPENGL_21 = 2 # OpenGL 2.1 (GLSL 120)
    RL_OPENGL_33 = 3 # OpenGL 3.3 (GLSL 330)
    RL_OPENGL_43 = 4 # OpenGL 4.3 (using GLSL 330)
    RL_OPENGL_ES_20 = 5 # OpenGL ES 2.0 (GLSL 100)
    RL_OPENGL_ES_30 = 6 # OpenGL ES 3.0 (GLSL 300 es)

# Texture pixel formats
  rlPixelFormat* {.size: sizeof(int32).} = enum
    RL_PIXELFORMAT_UNCOMPRESSED_GRAYSCALE = 1 # 8 bit per pixel (no alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_GRAY_ALPHA = 2 # 8*2 bpp (2 channels)
    RL_PIXELFORMAT_UNCOMPRESSED_R5G6B5 = 3 # 16 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8 = 4 # 24 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R5G5B5A1 = 5 # 16 bpp (1 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R4G4B4A4 = 6 # 16 bpp (4 bit alpha)
    RL_PIXELFORMAT_UNCOMPRESSED_R8G8B8A8 = 7 # 32 bpp
    RL_PIXELFORMAT_UNCOMPRESSED_R32 = 8 # 32 bpp (1 channel - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32 = 9 # 32*3 bpp (3 channels - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R32G32B32A32 = 10 # 32*4 bpp (4 channels - float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16 = 11 # 16 bpp (1 channel - half float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16 = 12 # 16*3 bpp (3 channels - half float)
    RL_PIXELFORMAT_UNCOMPRESSED_R16G16B16A16 = 13 # 16*4 bpp (4 channels - half float)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGB = 14 # 4 bpp (no alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT1_RGBA = 15 # 4 bpp (1 bit alpha)
    RL_PIXELFORMAT_COMPRESSED_DXT3_RGBA = 16 # 8 bpp
    RL_PIXELFORMAT_COMPRESSED_DXT5_RGBA = 17 # 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC1_RGB = 18 # 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_RGB = 19 # 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ETC2_EAC_RGBA = 20 # 8 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGB = 21 # 4 bpp
    RL_PIXELFORMAT_COMPRESSED_PVRT_RGBA = 22 # 4 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_4x4_RGBA = 23 # 8 bpp
    RL_PIXELFORMAT_COMPRESSED_ASTC_8x8_RGBA = 24 # 2 bpp

# Texture parameters: filter mode
  rlTextureFilter* {.size: sizeof(int32).} = enum
    RL_TEXTURE_FILTER_POINT = 0 # No filter, pixel approximation
    RL_TEXTURE_FILTER_BILINEAR = 1 # Linear filtering
    RL_TEXTURE_FILTER_TRILINEAR = 2 # Trilinear filtering (linear with mipmaps)
    RL_TEXTURE_FILTER_ANISOTROPIC_4X = 3 # Anisotropic filtering 4x
    RL_TEXTURE_FILTER_ANISOTROPIC_8X = 4 # Anisotropic filtering 8x
    RL_TEXTURE_FILTER_ANISOTROPIC_16X = 5 # Anisotropic filtering 16x

# Color blending modes (pre-defined)
  rlBlendMode* {.size: sizeof(int32).} = enum
    RL_BLEND_ALPHA = 0 # Blend textures considering alpha (default)
    RL_BLEND_ADDITIVE = 1 # Blend textures adding colors
    RL_BLEND_MULTIPLIED = 2 # Blend textures multiplying colors
    RL_BLEND_ADD_COLORS = 3 # Blend textures adding colors (alternative)
    RL_BLEND_SUBTRACT_COLORS = 4 # Blend textures subtracting colors (alternative)
    RL_BLEND_ALPHA_PREMULTIPLY = 5 # Blend premultiplied textures considering alpha
    RL_BLEND_CUSTOM = 6 # Blend textures using custom src/dst factors (use rlSetBlendFactors())
    RL_BLEND_CUSTOM_SEPARATE = 7 # Blend textures using custom src/dst factors (use rlSetBlendFactorsSeparate())

# Shader location point type
  rlShaderLocationIndex* {.size: sizeof(int32).} = enum
    RL_SHADER_LOC_VERTEX_POSITION = 0 # Shader location: vertex attribute: position
    RL_SHADER_LOC_VERTEX_TEXCOORD01 = 1 # Shader location: vertex attribute: texcoord01
    RL_SHADER_LOC_VERTEX_TEXCOORD02 = 2 # Shader location: vertex attribute: texcoord02
    RL_SHADER_LOC_VERTEX_NORMAL = 3 # Shader location: vertex attribute: normal
    RL_SHADER_LOC_VERTEX_TANGENT = 4 # Shader location: vertex attribute: tangent
    RL_SHADER_LOC_VERTEX_COLOR = 5 # Shader location: vertex attribute: color
    RL_SHADER_LOC_MATRIX_MVP = 6 # Shader location: matrix uniform: model-view-projection
    RL_SHADER_LOC_MATRIX_VIEW = 7 # Shader location: matrix uniform: view (camera transform)
    RL_SHADER_LOC_MATRIX_PROJECTION = 8 # Shader location: matrix uniform: projection
    RL_SHADER_LOC_MATRIX_MODEL = 9 # Shader location: matrix uniform: model (transform)
    RL_SHADER_LOC_MATRIX_NORMAL = 10 # Shader location: matrix uniform: normal
    RL_SHADER_LOC_VECTOR_VIEW = 11 # Shader location: vector uniform: view
    RL_SHADER_LOC_COLOR_DIFFUSE = 12 # Shader location: vector uniform: diffuse color
    RL_SHADER_LOC_COLOR_SPECULAR = 13 # Shader location: vector uniform: specular color
    RL_SHADER_LOC_COLOR_AMBIENT = 14 # Shader location: vector uniform: ambient color
    RL_SHADER_LOC_MAP_ALBEDO = 15 # Shader location: sampler2d texture: albedo (same as: RL_SHADER_LOC_MAP_DIFFUSE)
    RL_SHADER_LOC_MAP_METALNESS = 16 # Shader location: sampler2d texture: metalness (same as: RL_SHADER_LOC_MAP_SPECULAR)
    RL_SHADER_LOC_MAP_NORMAL = 17 # Shader location: sampler2d texture: normal
    RL_SHADER_LOC_MAP_ROUGHNESS = 18 # Shader location: sampler2d texture: roughness
    RL_SHADER_LOC_MAP_OCCLUSION = 19 # Shader location: sampler2d texture: occlusion
    RL_SHADER_LOC_MAP_EMISSION = 20 # Shader location: sampler2d texture: emission
    RL_SHADER_LOC_MAP_HEIGHT = 21 # Shader location: sampler2d texture: height
    RL_SHADER_LOC_MAP_CUBEMAP = 22 # Shader location: samplerCube texture: cubemap
    RL_SHADER_LOC_MAP_IRRADIANCE = 23 # Shader location: samplerCube texture: irradiance
    RL_SHADER_LOC_MAP_PREFILTER = 24 # Shader location: samplerCube texture: prefilter
    RL_SHADER_LOC_MAP_BRDF = 25 # Shader location: sampler2d texture: brdf

# Shader uniform data type
  rlShaderUniformDataType* {.size: sizeof(int32).} = enum
    RL_SHADER_UNIFORM_FLOAT = 0 # Shader uniform type: float
    RL_SHADER_UNIFORM_VEC2 = 1 # Shader uniform type: vec2 (2 float)
    RL_SHADER_UNIFORM_VEC3 = 2 # Shader uniform type: vec3 (3 float)
    RL_SHADER_UNIFORM_VEC4 = 3 # Shader uniform type: vec4 (4 float)
    RL_SHADER_UNIFORM_INT = 4 # Shader uniform type: int
    RL_SHADER_UNIFORM_IVEC2 = 5 # Shader uniform type: ivec2 (2 int)
    RL_SHADER_UNIFORM_IVEC3 = 6 # Shader uniform type: ivec3 (3 int)
    RL_SHADER_UNIFORM_IVEC4 = 7 # Shader uniform type: ivec4 (4 int)
    RL_SHADER_UNIFORM_UINT = 8 # Shader uniform type: unsigned int
    RL_SHADER_UNIFORM_UIVEC2 = 9 # Shader uniform type: uivec2 (2 unsigned int)
    RL_SHADER_UNIFORM_UIVEC3 = 10 # Shader uniform type: uivec3 (3 unsigned int)
    RL_SHADER_UNIFORM_UIVEC4 = 11 # Shader uniform type: uivec4 (4 unsigned int)
    RL_SHADER_UNIFORM_SAMPLER2D = 12 # Shader uniform type: sampler2d

# Shader attribute data types
  rlShaderAttributeDataType* {.size: sizeof(int32).} = enum
    RL_SHADER_ATTRIB_FLOAT = 0 # Shader attribute type: float
    RL_SHADER_ATTRIB_VEC2 = 1 # Shader attribute type: vec2 (2 float)
    RL_SHADER_ATTRIB_VEC3 = 2 # Shader attribute type: vec3 (3 float)
    RL_SHADER_ATTRIB_VEC4 = 3 # Shader attribute type: vec4 (4 float)

# Framebuffer attachment type
  rlFramebufferAttachType* {.size: sizeof(int32).} = enum
    RL_ATTACHMENT_COLOR_CHANNEL0 = 0 # Framebuffer attachment type: color 0
    RL_ATTACHMENT_COLOR_CHANNEL1 = 1 # Framebuffer attachment type: color 1
    RL_ATTACHMENT_COLOR_CHANNEL2 = 2 # Framebuffer attachment type: color 2
    RL_ATTACHMENT_COLOR_CHANNEL3 = 3 # Framebuffer attachment type: color 3
    RL_ATTACHMENT_COLOR_CHANNEL4 = 4 # Framebuffer attachment type: color 4
    RL_ATTACHMENT_COLOR_CHANNEL5 = 5 # Framebuffer attachment type: color 5
    RL_ATTACHMENT_COLOR_CHANNEL6 = 6 # Framebuffer attachment type: color 6
    RL_ATTACHMENT_COLOR_CHANNEL7 = 7 # Framebuffer attachment type: color 7
    RL_ATTACHMENT_DEPTH = 100 # Framebuffer attachment type: depth
    RL_ATTACHMENT_STENCIL = 200 # Framebuffer attachment type: stencil

# Framebuffer texture attachment type
  rlFramebufferAttachTextureType* {.size: sizeof(int32).} = enum
    RL_ATTACHMENT_CUBEMAP_POSITIVE_X = 0 # Framebuffer texture attachment type: cubemap, +X side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_X = 1 # Framebuffer texture attachment type: cubemap, -X side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Y = 2 # Framebuffer texture attachment type: cubemap, +Y side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Y = 3 # Framebuffer texture attachment type: cubemap, -Y side
    RL_ATTACHMENT_CUBEMAP_POSITIVE_Z = 4 # Framebuffer texture attachment type: cubemap, +Z side
    RL_ATTACHMENT_CUBEMAP_NEGATIVE_Z = 5 # Framebuffer texture attachment type: cubemap, -Z side
    RL_ATTACHMENT_TEXTURE2D = 100 # Framebuffer texture attachment type: texture2d
    RL_ATTACHMENT_RENDERBUFFER = 200 # Framebuffer texture attachment type: renderbuffer

# Face culling mode
  rlCullMode* {.size: sizeof(int32).} = enum
    RL_CULL_FACE_FRONT = 0 # 
    RL_CULL_FACE_BACK = 1 # 

{.push callconv: cdecl, header: "rlgl.h".}

proc rlMatrixMode*(mode: int32)
proc rlPushMatrix*()
proc rlPopMatrix*()
proc rlLoadIdentity*()
proc rlTranslatef*(x: float32, y: float32, z: float32)
proc rlRotatef*(angle: float32, x: float32, y: float32, z: float32)
proc rlScalef*(x: float32, y: float32, z: float32)
proc rlMultMatrixf*(matf: ptr float32)
proc rlFrustum*(left: float64, right: float64, bottom: float64, top: float64, znear: float64, zfar: float64)
proc rlOrtho*(left: float64, right: float64, bottom: float64, top: float64, znear: float64, zfar: float64)
proc rlViewport*(x: int32, y: int32, width: int32, height: int32)
proc rlSetClipPlanes*(nearPlane: float64, farPlane: float64)
proc rlGetCullDistanceNear*(): float64
proc rlGetCullDistanceFar*(): float64
proc rlBegin*(mode: int32)
proc rlEnd*()
proc rlVertex2i*(x: int32, y: int32)
proc rlVertex2f*(x: float32, y: float32)
proc rlVertex3f*(x: float32, y: float32, z: float32)
proc rlTexCoord2f*(x: float32, y: float32)
proc rlNormal3f*(x: float32, y: float32, z: float32)
proc rlColor4ub*(r: uint8, g: uint8, b: uint8, a: uint8)
proc rlColor3f*(x: float32, y: float32, z: float32)
proc rlColor4f*(x: float32, y: float32, z: float32, w: float32)
proc rlEnableVertexArray*(vaoId: uint32): bool
proc rlDisableVertexArray*()
proc rlEnableVertexBuffer*(id: uint32)
proc rlDisableVertexBuffer*()
proc rlEnableVertexBufferElement*(id: uint32)
proc rlDisableVertexBufferElement*()
proc rlEnableVertexAttribute*(index: uint32)
proc rlDisableVertexAttribute*(index: uint32)
proc rlEnableStatePointer*(vertexAttribType: int32, buffer: pointer)
proc rlDisableStatePointer*(vertexAttribType: int32)
proc rlActiveTextureSlot*(slot: int32)
proc rlEnableTexture*(id: uint32)
proc rlDisableTexture*()
proc rlEnableTextureCubemap*(id: uint32)
proc rlDisableTextureCubemap*()
proc rlTextureParameters*(id: uint32, param: int32, value: int32)
proc rlCubemapParameters*(id: uint32, param: int32, value: int32)
proc rlEnableShader*(id: uint32)
proc rlDisableShader*()
proc rlEnableFramebuffer*(id: uint32)
proc rlDisableFramebuffer*()
proc rlGetActiveFramebuffer*(): uint32
proc rlActiveDrawBuffers*(count: int32)
proc rlBlitFramebuffer*(srcX: int32, srcY: int32, srcWidth: int32, srcHeight: int32, dstX: int32, dstY: int32, dstWidth: int32, dstHeight: int32, bufferMask: int32)
proc rlBindFramebuffer*(target: uint32, framebuffer: uint32)
proc rlEnableColorBlend*()
proc rlDisableColorBlend*()
proc rlEnableDepthTest*()
proc rlDisableDepthTest*()
proc rlEnableDepthMask*()
proc rlDisableDepthMask*()
proc rlEnableBackfaceCulling*()
proc rlDisableBackfaceCulling*()
proc rlColorMask*(r: bool, g: bool, b: bool, a: bool)
proc rlSetCullFace*(mode: int32)
proc rlEnableScissorTest*()
proc rlDisableScissorTest*()
proc rlScissor*(x: int32, y: int32, width: int32, height: int32)
proc rlEnablePointMode*()
proc rlDisablePointMode*()
proc rlSetPointSize*(size: float32)
proc rlGetPointSize*(): float32
proc rlEnableWireMode*()
proc rlDisableWireMode*()
proc rlSetLineWidth*(width: float32)
proc rlGetLineWidth*(): float32
proc rlEnableSmoothLines*()
proc rlDisableSmoothLines*()
proc rlEnableStereoRender*()
proc rlDisableStereoRender*()
proc rlIsStereoRenderEnabled*(): bool
proc rlClearColor*(r: uint8, g: uint8, b: uint8, a: uint8)
proc rlClearScreenBuffers*()
proc rlCheckErrors*()
proc rlSetBlendMode*(mode: int32)
proc rlSetBlendFactors*(glSrcFactor: int32, glDstFactor: int32, glEquation: int32)
proc rlSetBlendFactorsSeparate*(glSrcRGB: int32, glDstRGB: int32, glSrcAlpha: int32, glDstAlpha: int32, glEqRGB: int32, glEqAlpha: int32)
proc rlglInit*(width: int32, height: int32)
proc rlglClose*()
proc rlLoadExtensions*(loader: pointer)
proc rlGetProcAddress*(procName: cstring): pointer
proc rlGetVersion*(): int32
proc rlSetFramebufferWidth*(width: int32)
proc rlGetFramebufferWidth*(): int32
proc rlSetFramebufferHeight*(height: int32)
proc rlGetFramebufferHeight*(): int32
proc rlGetTextureIdDefault*(): uint32
proc rlGetShaderIdDefault*(): uint32
proc rlGetShaderLocsDefault*(): ptr int32
proc rlLoadRenderBatch*(numBuffers: int32, bufferElements: int32): rlRenderBatch
proc rlUnloadRenderBatch*(batch: rlRenderBatch)
proc rlDrawRenderBatch*(batch: ptr rlRenderBatch)
proc rlSetRenderBatchActive*(batch: ptr rlRenderBatch)
proc rlDrawRenderBatchActive*()
proc rlCheckRenderBatchLimit*(vCount: int32): bool
proc rlSetTexture*(id: uint32)
proc rlLoadVertexArray*(): uint32
proc rlLoadVertexBuffer*(buffer: pointer, size: int32, dynamic: bool): uint32
proc rlLoadVertexBufferElement*(buffer: pointer, size: int32, dynamic: bool): uint32
proc rlUpdateVertexBuffer*(bufferId: uint32, data: pointer, dataSize: int32, offset: int32)
proc rlUpdateVertexBufferElements*(id: uint32, data: pointer, dataSize: int32, offset: int32)
proc rlUnloadVertexArray*(vaoId: uint32)
proc rlUnloadVertexBuffer*(vboId: uint32)
proc rlSetVertexAttribute*(index: uint32, compSize: int32, `type`: int32, normalized: bool, stride: int32, offset: int32)
proc rlSetVertexAttributeDivisor*(index: uint32, divisor: int32)
proc rlSetVertexAttributeDefault*(locIndex: int32, value: pointer, attribType: int32, count: int32)
proc rlDrawVertexArray*(offset: int32, count: int32)
proc rlDrawVertexArrayElements*(offset: int32, count: int32, buffer: pointer)
proc rlDrawVertexArrayInstanced*(offset: int32, count: int32, instances: int32)
proc rlDrawVertexArrayElementsInstanced*(offset: int32, count: int32, buffer: pointer, instances: int32)
proc rlLoadTexture*(data: pointer, width: int32, height: int32, format: int32, mipmapCount: int32): uint32
proc rlLoadTextureDepth*(width: int32, height: int32, useRenderBuffer: bool): uint32
proc rlLoadTextureCubemap*(data: pointer, size: int32, format: int32, mipmapCount: int32): uint32
proc rlUpdateTexture*(id: uint32, offsetX: int32, offsetY: int32, width: int32, height: int32, format: int32, data: pointer)
proc rlGetGlTextureFormats*(format: int32, glInternalFormat: ptr uint32, glFormat: ptr uint32, glType: ptr uint32)
proc rlGetPixelFormatName*(format: uint32): cstring
proc rlUnloadTexture*(id: uint32)
proc rlGenTextureMipmaps*(id: uint32, width: int32, height: int32, format: int32, mipmaps: ptr int32)
proc rlReadTexturePixels*(id: uint32, width: int32, height: int32, format: int32): pointer
proc rlReadScreenPixels*(width: int32, height: int32): ptr uint8
proc rlLoadFramebuffer*(): uint32
proc rlFramebufferAttach*(id: uint32, texId: uint32, attachType: int32, texType: int32, mipLevel: int32)
proc rlFramebufferComplete*(id: uint32): bool
proc rlUnloadFramebuffer*(id: uint32)
proc rlCopyFramebuffer*(x: int32, y: int32, width: int32, height: int32, format: int32, pixels: pointer)
proc rlResizeFramebuffer*(width: int32, height: int32)
proc rlLoadShader*(code: cstring, `type`: int32): uint32
proc rlLoadShaderProgram*(vsCode: cstring, fsCode: cstring): uint32
proc rlLoadShaderProgramEx*(vsId: uint32, fsId: uint32): uint32
proc rlLoadShaderProgramCompute*(csId: uint32): uint32
proc rlUnloadShader*(id: uint32)
proc rlUnloadShaderProgram*(id: uint32)
proc rlGetLocationUniform*(id: uint32, uniformName: cstring): int32
proc rlGetLocationAttrib*(id: uint32, attribName: cstring): int32
proc rlSetUniform*(locIndex: int32, value: pointer, uniformType: int32, count: int32)
proc rlSetUniformMatrix*(locIndex: int32, mat: Matrix)
proc rlSetUniformMatrices*(locIndex: int32, mat: ptr Matrix, count: int32)
proc rlSetUniformSampler*(locIndex: int32, textureId: uint32)
proc rlSetShader*(id: uint32, locs: ptr int32)
proc rlComputeShaderDispatch*(groupX: uint32, groupY: uint32, groupZ: uint32)
proc rlLoadShaderBuffer*(size: uint32, data: pointer, usageHint: int32): uint32
proc rlUnloadShaderBuffer*(ssboId: uint32)
proc rlUpdateShaderBuffer*(id: uint32, data: pointer, dataSize: uint32, offset: uint32)
proc rlBindShaderBuffer*(id: uint32, index: uint32)
proc rlReadShaderBuffer*(id: uint32, dest: pointer, count: uint32, offset: uint32)
proc rlCopyShaderBuffer*(destId: uint32, srcId: uint32, destOffset: uint32, srcOffset: uint32, count: uint32)
proc rlGetShaderBufferSize*(id: uint32): uint32
proc rlBindImageTexture*(id: uint32, index: uint32, format: int32, readonly: bool)
proc rlGetMatrixModelview*(): Matrix
proc rlGetMatrixProjection*(): Matrix
proc rlGetMatrixTransform*(): Matrix
proc rlGetMatrixProjectionStereo*(eye: int32): Matrix
proc rlGetMatrixViewOffsetStereo*(eye: int32): Matrix
proc rlSetMatrixProjection*(proj: Matrix)
proc rlSetMatrixModelview*(view: Matrix)
proc rlSetMatrixProjectionStereo*(right: Matrix, left: Matrix)
proc rlSetMatrixViewOffsetStereo*(right: Matrix, left: Matrix)
proc rlLoadDrawCube*()
proc rlLoadDrawQuad*()

{.pop.}
