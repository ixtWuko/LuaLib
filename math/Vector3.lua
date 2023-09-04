local setmetatable, getmetatable = setmetatable, getmetatable
local type = type
local assert = assert
local sqrt = math.sqrt


---@class Vector3
local Vector3 = {}
Vector3.__index = Vector3

function Vector3.new(x, y, z)
    return setmetatable({ x = x or 0, y = y or 0, z = z or 0 }, Vector3)
end

function Vector3.IsVector3(v)
    return getmetatable(v) == Vector3
end

local new = Vector3.new
local IsVector3 = Vector3.IsVector3

function Vector3.Length(v)
    return sqrt(v.x * v.x + v.y * v.y + v.z * v.z)
end

function Vector3.Normalize(v)
    local len = v:length()
    if len ~= 0 then
        return new(v.x / len, v.y / len, v.z / len)
    end
end

function Vector3.__unm(v)
    return new(-v.x, -v.y, -v.z)
end

function Vector3.__add(lhs, rhs)
    return new(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
end

function Vector3.__sub(lhs, rhs)
    return new(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
end

function Vector3.__mul(lhs, rhs)
    if type(lhs) == 'number' then
        return new(lhs * rhs.x, lhs * rhs.y, lhs * rhs.z)
    elseif type(rhs) == 'number' then
        return new(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
    else
        assert(IsVector3(lhs) and IsVector3(rhs), "Vector3.__mul: arguments must be Vector3 or number.")
        return new(lhs.x * rhs.x, lhs.y * rhs.y, lhs.z * rhs.z)
    end
end

function Vector3.__div(lhs, rhs)
    assert(IsVector3(lhs) and type(rhs) == 'number', "Vector3.__div: arguments must be Vector3 and number.")
    return new(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
end

function Vector3.__eq(lhs, rhs)
    return lhs.x == rhs.x and lhs.y == rhs.y and lhs.z == rhs.z
end

function Vector3.Dot(lhs, rhs)
    return lhs.x * rhs.x + lhs.y * rhs.y + lhs.z * rhs.z
end

function Vector3.Cross(lhs, rhs)
    return new(
            lhs.y * rhs.z - lhs.z * rhs.y,
            lhs.z * rhs.x - lhs.x * rhs.z,
            lhs.x * rhs.y - lhs.y * rhs.x
    )
end

function Vector3.Distance(lhs, rhs)
    local dx, dy, dz = lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z
    return sqrt(dx * dx + dy * dy + dz * dz)
end

return Vector3
