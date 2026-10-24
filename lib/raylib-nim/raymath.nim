from raylib import
  Vector2, Vector3, Vector4, Quaternion, Matrix
export
  Vector2, Vector3, Vector4, Quaternion, Matrix

type
  float3* {.completeStruct, bycopy, header: "raymath.h".} = object
    v*: array[3, float32]
  float16* {.completeStruct, bycopy, header: "raymath.h".} = object
    v*: array[16, float32]

template MatrixToFloat*(mat: Matrix): array[16, float32] =
  MatrixToFloatV(mat).v

template Vector3ToFloat*(vec: Vector3): array[16, float32] =
  Vector3ToFloatV(vec).v

{.push callconv: cdecl, header: "raymath.h".}

proc Clamp*(value: float32, min: float32, max: float32): float32
proc Lerp*(start: float32, `end`: float32, amount: float32): float32
proc Normalize*(value: float32, start: float32, `end`: float32): float32
proc Remap*(value: float32, inputStart: float32, inputEnd: float32, outputStart: float32, outputEnd: float32): float32
proc Wrap*(value: float32, min: float32, max: float32): float32
proc FloatEquals*(x: float32, y: float32): int32
proc Vector2Zero*(): Vector2
proc Vector2One*(): Vector2
proc Vector2Add*(v1: Vector2, v2: Vector2): Vector2
proc Vector2AddValue*(v: Vector2, add: float32): Vector2
proc Vector2Subtract*(v1: Vector2, v2: Vector2): Vector2
proc Vector2SubtractValue*(v: Vector2, sub: float32): Vector2
proc Vector2Length*(v: Vector2): float32
proc Vector2LengthSqr*(v: Vector2): float32
proc Vector2DotProduct*(v1: Vector2, v2: Vector2): float32
proc Vector2CrossProduct*(v1: Vector2, v2: Vector2): float32
proc Vector2Distance*(v1: Vector2, v2: Vector2): float32
proc Vector2DistanceSqr*(v1: Vector2, v2: Vector2): float32
proc Vector2Angle*(v1: Vector2, v2: Vector2): float32
proc Vector2LineAngle*(start: Vector2, `end`: Vector2): float32
proc Vector2Scale*(v: Vector2, scale: float32): Vector2
proc Vector2Multiply*(v1: Vector2, v2: Vector2): Vector2
proc Vector2Negate*(v: Vector2): Vector2
proc Vector2Divide*(v1: Vector2, v2: Vector2): Vector2
proc Vector2Normalize*(v: Vector2): Vector2
proc Vector2Transform*(v: Vector2, mat: Matrix): Vector2
proc Vector2Lerp*(v1: Vector2, v2: Vector2, amount: float32): Vector2
proc Vector2Reflect*(v: Vector2, normal: Vector2): Vector2
proc Vector2Min*(v1: Vector2, v2: Vector2): Vector2
proc Vector2Max*(v1: Vector2, v2: Vector2): Vector2
proc Vector2Rotate*(v: Vector2, angle: float32): Vector2
proc Vector2MoveTowards*(v: Vector2, target: Vector2, maxDistance: float32): Vector2
proc Vector2Invert*(v: Vector2): Vector2
proc Vector2Clamp*(v: Vector2, min: Vector2, max: Vector2): Vector2
proc Vector2ClampValue*(v: Vector2, min: float32, max: float32): Vector2
proc Vector2Equals*(p: Vector2, q: Vector2): int32
proc Vector2Refract*(v: Vector2, n: Vector2, r: float32): Vector2
proc Vector3Zero*(): Vector3
proc Vector3One*(): Vector3
proc Vector3Add*(v1: Vector3, v2: Vector3): Vector3
proc Vector3AddValue*(v: Vector3, add: float32): Vector3
proc Vector3Subtract*(v1: Vector3, v2: Vector3): Vector3
proc Vector3SubtractValue*(v: Vector3, sub: float32): Vector3
proc Vector3Scale*(v: Vector3, scalar: float32): Vector3
proc Vector3Multiply*(v1: Vector3, v2: Vector3): Vector3
proc Vector3CrossProduct*(v1: Vector3, v2: Vector3): Vector3
proc Vector3Perpendicular*(v: Vector3): Vector3
proc Vector3Length*(v: Vector3): float32
proc Vector3LengthSqr*(v: Vector3): float32
proc Vector3DotProduct*(v1: Vector3, v2: Vector3): float32
proc Vector3Distance*(v1: Vector3, v2: Vector3): float32
proc Vector3DistanceSqr*(v1: Vector3, v2: Vector3): float32
proc Vector3Angle*(v1: Vector3, v2: Vector3): float32
proc Vector3Negate*(v: Vector3): Vector3
proc Vector3Divide*(v1: Vector3, v2: Vector3): Vector3
proc Vector3Normalize*(v: Vector3): Vector3
proc Vector3Project*(v1: Vector3, v2: Vector3): Vector3
proc Vector3Reject*(v1: Vector3, v2: Vector3): Vector3
proc Vector3OrthoNormalize*(v1: ptr Vector3, v2: ptr Vector3)
proc Vector3Transform*(v: Vector3, mat: Matrix): Vector3
proc Vector3RotateByQuaternion*(v: Vector3, q: Quaternion): Vector3
proc Vector3RotateByAxisAngle*(v: Vector3, axis: Vector3, angle: float32): Vector3
proc Vector3MoveTowards*(v: Vector3, target: Vector3, maxDistance: float32): Vector3
proc Vector3Lerp*(v1: Vector3, v2: Vector3, amount: float32): Vector3
proc Vector3CubicHermite*(v1: Vector3, tangent1: Vector3, v2: Vector3, tangent2: Vector3, amount: float32): Vector3
proc Vector3Reflect*(v: Vector3, normal: Vector3): Vector3
proc Vector3Min*(v1: Vector3, v2: Vector3): Vector3
proc Vector3Max*(v1: Vector3, v2: Vector3): Vector3
proc Vector3Barycenter*(p: Vector3, a: Vector3, b: Vector3, c: Vector3): Vector3
proc Vector3Unproject*(source: Vector3, projection: Matrix, view: Matrix): Vector3
proc Vector3ToFloatV*(v: Vector3): float3
proc Vector3Invert*(v: Vector3): Vector3
proc Vector3Clamp*(v: Vector3, min: Vector3, max: Vector3): Vector3
proc Vector3ClampValue*(v: Vector3, min: float32, max: float32): Vector3
proc Vector3Equals*(p: Vector3, q: Vector3): int32
proc Vector3Refract*(v: Vector3, n: Vector3, r: float32): Vector3
proc Vector4Zero*(): Vector4
proc Vector4One*(): Vector4
proc Vector4Add*(v1: Vector4, v2: Vector4): Vector4
proc Vector4AddValue*(v: Vector4, add: float32): Vector4
proc Vector4Subtract*(v1: Vector4, v2: Vector4): Vector4
proc Vector4SubtractValue*(v: Vector4, add: float32): Vector4
proc Vector4Length*(v: Vector4): float32
proc Vector4LengthSqr*(v: Vector4): float32
proc Vector4DotProduct*(v1: Vector4, v2: Vector4): float32
proc Vector4Distance*(v1: Vector4, v2: Vector4): float32
proc Vector4DistanceSqr*(v1: Vector4, v2: Vector4): float32
proc Vector4Scale*(v: Vector4, scale: float32): Vector4
proc Vector4Multiply*(v1: Vector4, v2: Vector4): Vector4
proc Vector4Negate*(v: Vector4): Vector4
proc Vector4Divide*(v1: Vector4, v2: Vector4): Vector4
proc Vector4Normalize*(v: Vector4): Vector4
proc Vector4Min*(v1: Vector4, v2: Vector4): Vector4
proc Vector4Max*(v1: Vector4, v2: Vector4): Vector4
proc Vector4Lerp*(v1: Vector4, v2: Vector4, amount: float32): Vector4
proc Vector4MoveTowards*(v: Vector4, target: Vector4, maxDistance: float32): Vector4
proc Vector4Invert*(v: Vector4): Vector4
proc Vector4Equals*(p: Vector4, q: Vector4): int32
proc MatrixDeterminant*(mat: Matrix): float32
proc MatrixTrace*(mat: Matrix): float32
proc MatrixTranspose*(mat: Matrix): Matrix
proc MatrixInvert*(mat: Matrix): Matrix
proc MatrixIdentity*(): Matrix
proc MatrixAdd*(left: Matrix, right: Matrix): Matrix
proc MatrixSubtract*(left: Matrix, right: Matrix): Matrix
proc MatrixMultiply*(left: Matrix, right: Matrix): Matrix
proc MatrixMultiplyValue*(left: Matrix, value: float32): Matrix
proc MatrixTranslate*(x: float32, y: float32, z: float32): Matrix
proc MatrixRotate*(axis: Vector3, angle: float32): Matrix
proc MatrixRotateX*(angle: float32): Matrix
proc MatrixRotateY*(angle: float32): Matrix
proc MatrixRotateZ*(angle: float32): Matrix
proc MatrixRotateXYZ*(angle: Vector3): Matrix
proc MatrixRotateZYX*(angle: Vector3): Matrix
proc MatrixScale*(x: float32, y: float32, z: float32): Matrix
proc MatrixFrustum*(left: float64, right: float64, bottom: float64, top: float64, nearPlane: float64, farPlane: float64): Matrix
proc MatrixPerspective*(fovY: float64, aspect: float64, nearPlane: float64, farPlane: float64): Matrix
proc MatrixOrtho*(left: float64, right: float64, bottom: float64, top: float64, nearPlane: float64, farPlane: float64): Matrix
proc MatrixLookAt*(eye: Vector3, target: Vector3, up: Vector3): Matrix
proc MatrixToFloatV*(mat: Matrix): float16
proc QuaternionAdd*(q1: Quaternion, q2: Quaternion): Quaternion
proc QuaternionAddValue*(q: Quaternion, add: float32): Quaternion
proc QuaternionSubtract*(q1: Quaternion, q2: Quaternion): Quaternion
proc QuaternionSubtractValue*(q: Quaternion, sub: float32): Quaternion
proc QuaternionIdentity*(): Quaternion
proc QuaternionLength*(q: Quaternion): float32
proc QuaternionNormalize*(q: Quaternion): Quaternion
proc QuaternionInvert*(q: Quaternion): Quaternion
proc QuaternionMultiply*(q1: Quaternion, q2: Quaternion): Quaternion
proc QuaternionScale*(q: Quaternion, mul: float32): Quaternion
proc QuaternionDivide*(q1: Quaternion, q2: Quaternion): Quaternion
proc QuaternionLerp*(q1: Quaternion, q2: Quaternion, amount: float32): Quaternion
proc QuaternionNlerp*(q1: Quaternion, q2: Quaternion, amount: float32): Quaternion
proc QuaternionSlerp*(q1: Quaternion, q2: Quaternion, amount: float32): Quaternion
proc QuaternionCubicHermiteSpline*(q1: Quaternion, outTangent1: Quaternion, q2: Quaternion, inTangent2: Quaternion, t: float32): Quaternion
proc QuaternionFromVector3ToVector3*(`from`: Vector3, to: Vector3): Quaternion
proc QuaternionFromMatrix*(mat: Matrix): Quaternion
proc QuaternionToMatrix*(q: Quaternion): Matrix
proc QuaternionFromAxisAngle*(axis: Vector3, angle: float32): Quaternion
proc QuaternionToAxisAngle*(q: Quaternion, outAxis: ptr Vector3, outAngle: ptr float32)
proc QuaternionFromEuler*(pitch: float32, yaw: float32, roll: float32): Quaternion
proc QuaternionToEuler*(q: Quaternion): Vector3
proc QuaternionTransform*(q: Quaternion, mat: Matrix): Quaternion
proc QuaternionEquals*(p: Quaternion, q: Quaternion): int32
proc MatrixCompose*(translation: Vector3, rotation: Quaternion, scale: Vector3): Matrix
proc MatrixDecompose*(mat: Matrix, translation: ptr Vector3, rotation: ptr Quaternion, scale: ptr Vector3)

{.pop.}
