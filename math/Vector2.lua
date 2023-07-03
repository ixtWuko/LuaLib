local setmetatable, getmetatable = setmetatable, getmetatable
local type = type
local assert = assert
local sqrt = math.sqrt


---@class Vector2
local Vector2 = {}
Vector2.__index = Vector2

function Vector2.new(x, y)
    return setmetatable({ x = x or 0, y = y or 0 }, Vector2)
end

function Vector2.isVector2(v)
    return getmetatable(v) == Vector2
end

local new = Vector2.new
local isVector2 = Vector2.isVector2

function Vector2.length(v)
    return sqrt(v.x * v.x + v.y * v.y)
end

function Vector2.normalize(v)
    local len = v:length()
    if len ~= 0 then
        return new(v.x / len, v.y / len)
    end
end

function Vector2.__unm(v)
    return new(-v.x, -v.y)
end

function Vector2.__add(lhs, rhs)
    return new(lhs.x + rhs.x, lhs.y + rhs.y)
end

function Vector2.__sub(lhs, rhs)
    return new(lhs.x - rhs.x, lhs.y - rhs.y)
end

function Vector2.__mul(lhs, rhs)
    if type(lhs) == 'number' then
        return new(lhs * rhs.x, lhs * rhs.y)
    elseif type(rhs) == 'number' then
        return new(lhs.x * rhs, lhs.y * rhs)
    else
        assert(isVector2(lhs) and isVector2(rhs), "Vector2.__mul: arguments must be Vector2 or number.")
        return new(lhs.x * rhs.x, lhs.y * rhs.y)
    end
end

function Vector2.__div(lhs, rhs)
    assert(isVector2(lhs) and type(rhs) == 'number', "Vector2.__div: arguments must be Vector2 and number.")
    return new(lhs.x / rhs, lhs.y / rhs)
end

function Vector2.__eq(lhs, rhs)
    return lhs.x == rhs.x and lhs.y == rhs.y
end

function Vector2.dot(lhs, rhs)
    return lhs.x * rhs.x + lhs.y * rhs.y
end

function Vector2.distance(lhs, rhs)
    local dx, dy = lhs.x - rhs.x, lhs.y - rhs.y
    return sqrt(dx * dx + dy * dy)
end

return Vector2
