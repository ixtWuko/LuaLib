local type = type
local assert = assert
local sin = math.sin
local cos = math.cos
local asin = math.asin
local acos = math.acos
local atan2 = math.atan2
local deg2rad = math.pi / 180
local rad2deg = 180 / math.pi
local sqrt = math.sqrt
local Vector3 = require("LuaLib.math.Vector3")

---@class Quaternion
local Quaternion = {}
Quaternion.__index = Quaternion

function Quaternion.new(x, y, z, w)
    return setmetatable({x = x or 0, y = y or 0, z = z or 0, w = w or 0}, Quaternion)
end

function Quaternion.IsQuaternion(q)
    return getmetatable(q) == Quaternion
end

local new = Quaternion.new
local IsQuaternion = Quaternion.IsQuaternion

function Quaternion.FromEulerAngle(yaw, pitch, roll)
    local half_yaw_rad = yaw * deg2rad * 0.5
    local half_pitch_rad = pitch * deg2rad * 0.5
    local half_roll_rad = roll * deg2rad * 0.5

    local sy = sin(half_yaw_rad)
    local cy = cos(half_yaw_rad)
    local sp = sin(half_pitch_rad)
    local cp = cos(half_pitch_rad)
    local sr = sin(half_roll_rad)
    local cr = cos(half_roll_rad)

    return new(
            cy * cp * sr - sy * sp * cr,
            cy * sp * cr + sy * cp * sr,
            sy * cp * cr - cy * sp * sr,
            cy * cp * cr + sy * sp * sr
    )
end

---@return number yaw, pitch, roll
function Quaternion.ToEulerAngle(q)
    local x, y, z, w = q.x, q.y, q.z, q.w
    local a = atan2(2 * (w * z + x * y), 1 - 2 * (y * y + z * z))
    local b = asin(2 * (w * y - x * z))
    local c = atan2(2 * (w * x + y * z), 1 - 2 * (x * x + y * y))
    return a * rad2deg, b * rad2deg, c * rad2deg
end

---@param axis Vector3
---@param angle number
function Quaternion.FromRotation(axis, angle)
    local half_angle_rad = angle * deg2rad * 0.5
    local s = sin(half_angle_rad)
    local c = cos(half_angle_rad)
    return new(axis.x * s, axis.y * s, axis.z * s, c)
end

---@return Vector3, number
function Quaternion.ToRotation(q)
    local half_angle = acos(q.w)
    local s = sin(half_angle)
    return Vector3.new(q.x / s, q.y / s, q.z / s), 2 * half_angle * rad2deg
end

function Quaternion.__unm(q)
    return new(-q.x, -q.y, -q.z, -q.w)
end

function Quaternion.__add(lhs, rhs)
    return new(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z, lhs.w + rhs.w)
end

function Quaternion.__sub(lhs, rhs)
    return new(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z, lhs.w - rhs.w)
end

function Quaternion.__mul(lhs, rhs)
    if type(lhs) == 'number' then
        return new(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z, lhs * rhs.w)
    elseif type(rhs) == 'number' then
        return new(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs, lhs.w * rhs)
    else
        assert(IsQuaternion(lhs) and IsQuaternion(rhs), "Quaternion.__mul: arguments must be Quaternion or number.")
        local lx, ly, lz, lw = lhs.x, lhs.y, lhs.z, lhs.w
        local rx, ry, rz, rw = rhs.x, rhs.y, rhs.z, rhs.w
        return new(
                lw * rx + lx * rw + ly * rz - lz * ry,
                lw * ry + ly * rw - lx * rz + lz * rx,
                lw * rz + lz * rw + lx * ry - ly * rx,
                lw * rw - lx * rx - ly * ry - lz * rz
        )
    end
end

function Quaternion.__div(lhs, rhs)
    assert(IsQuaternion(lhs) and type(rhs) == 'number', "Quaternion.__div: arguments must be Quaternion and number.")
    return new(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs, lhs.w / rhs)
end

function Quaternion.Conjugate(q)
    return new(-q.x, -q.y, -q.z, q.w)
end

function Quaternion.Length(q)
    return sqrt(q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w)
end

function Quaternion.Inverse(q)
    local s = q.x * q.x + q.y * q.y + q.z * q.z + q.w * q.w
    return new(-q.x / s, -q.y / s, -q.z / s, q.w / s)
end

---@param point Vector3
---@return Vector3
function Quaternion.Rotate(q, point)
    local ori = new(point.x, point.y, point.z, 0)
    local ret = q * ori * Quaternion.Inverse(q)
    return Vector3.new(ret.x, ret.y, ret.z)
end

return Quaternion
