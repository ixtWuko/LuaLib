local type = type
local getmetatable = getmetatable
local ipairs, pairs = iparis, pairs
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

function functional.contain(table, value)
    for _, v in ipairs(table) do
        if v == value then return true end
    end
end

function functional.where(table, value)
    for i, v in ipairs(table) do
        if v == value then return i end
    end
end

function functional.all(array)
    for _, v in ipairs(array) do
        if not v then return false end
    end
    return true
end

function functional.any(array)
    for _, v in ipairs(array) do
        if v then return true end
    end
    return false
end

function functional.none(array)
    for _, v in ipairs(array) do
        if v then return false end
    end
    return true
end

function functional.mininum(array)
    local len = #array
    if len > 1 then
        local min = array[1]
        for i = 2, len do
            if array[i] < min then
                min = array[i]
            end
        end
        return min
    elseif len == 1 then
        return array[1]
    end
end

function functional.maxinum(array)
    local len = #array
    if len > 1 then
        local max = array[1]
        for i = 2, len do
            if array[i] > max then
                max = array[i]
            end
        end
        return max
    elseif len == 1 then
        return array[1]
    end
end

function functional.sum(array)
    local ret = 0
    for _, v in ipairs(array) do
        ret = ret + v
    end
    return ret
end

function functional.product(array)
    local ret = #array > 0 and 1 or 0
    for _, v in ipairs(array) do
        ret = ret * v
    end
    return ret
end

function functional.merge(tab, addon)
    for _, v in ipairs(addon) do
        tinsert(tab, v)
    end
end

function functional.repeats(count, value)
    local ret = {}
    for _ = 1, count do
        tinsert(ret, value)
    end
    return ret
end

function functional.cycles(count, array)
    local ret = {}
    for _ = 1, count do
        functional.merge(ret, array)
    end
    return ret
end

function functional.map(array, func)
    local ret = {}
    for i, v in ipairs(array) do
        ret[i] = func(v)
    end
    return ret
end

function functional.filter(array, func)
    local ret = {}
    for _, v in ipairs(array) do
        if func(v) then
            tinsert(ret, v)
        end
    end
    return ret
end

function functional.reduce(array, func, state)
    for _, v in ipairs(array) do
        state = func(state, v)
    end
    return state
end

function functional.reverse_ipairs(array)
    local iter = function(array, index)
        index = index - 1
        local value = array[index]
        if value then
            return index, value
        end
    end

    local cnt = #array + 1
    return iter, array, cnt
end

return functional
