local type = type
local getmetatable = getmetatable
local tinsert = table.insert
local math = math

local functional = {}

--region Type
function functional.isNil(value)
    return type(value) == 'nil'
end

function functional.isBoolean(value)
    return type(value) == 'boolean'
end

function functional.isNumber(value)
    return type(value) == 'number'
end

function functional.isInt(value)
    return math.type(value) == 'integer'
end

function functional.isFloat(value)
    return math.type(value) == 'float'
end

function functional.isString(value)
    return type(value) == 'string'
end

function functional.isFunction(value)
    return type(value) == 'function'
end

function functional.isTable(value)
    return type(value) == 'table'
end

function functional.callable(value)
    if type(value) == "table" then
        local metatable = getmetatable(value)
        return metatable and type(metatable.__call) == "function"
    end
    return type(value) == 'function'
end
--endregion Type


--region Logic
function functional.land(va, vb)
    return va and vb and true or false
end

function functional.lor(va, vb)
    return (va or vb) and true or false
end

function functional.lnot(value)
    return not value
end

function functional.lxor(va, vb)
    return (va and not vb) or (vb and not va) or false
end
--endregion Logic


--region Table
function functional.head(array)
    return array[1]
end

function functional.tail(array)
    return array[#array]
end

function functional.reverse(array)
    local ret = {}
    local len = #array
    if len > 0 then
        for i = #array, 1 do
            tinsert(ret, array[i])
        end
    end
    return ret
end

function functional.take(count, array)
    local ret = {}
    if count > 0 then
        for i = 1, count do
            tinsert(ret, array[i])
        end
    end
    return ret
end

function functional.drop(count, array)
    count = count + 1
    local ret = {}
    local len = #array
    if count < len then
        for i = count, len do
            tinsert(ret, array[i])
        end
    end
    return ret
end
--endregion Table


return functional
