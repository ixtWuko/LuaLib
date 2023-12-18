local type = type
local getmetatable = getmetatable
local ipairs, pairs = iparis, pairs
local tinsert = table.insert
local math = math

local functional = {}


functional.isnil = function(value) return type(value) == 'nil' end
functional.isboolean = function(value) return type(value) == 'boolean' end
functional.isnumber = function(value) return type(value) == 'number' end
functional.isstring = function(value) return type(value) == 'string' end
functional.isfunction = function(value) return type(value) == 'function' end
functional.istable = function(value) return type(value) == 'table' end
functional.isuserdata = function(value) return type(value) == 'userdata' end
functional.isint = function(value) return math.type(value) == 'integer' end
functional.isfloat = function(value) return math.type(value) == 'float' end

functional.callable = function(value)
    if type(value) == 'table' then
        local metatable = getmetatable(value)
        return metatable and type(metatable.__call) == 'function'
    end
    return type(value) == 'function'
end


functional.land = function(va, vb) return va and vb and true or false end
functional.lor = function(va, vb) return (va or vb) and true or false end
functional.lnot = function(value) return not value end
functional.lxor = function(va, vb) return (va and not vb) or (vb and not va) or false end

functional.all = function(array)
    for _, v in ipairs(array) do
        if not v then return false end
    end
    return true
end

functional.any = function(array)
    for _, v in ipairs(array) do
        if v then return true end
    end
    return false
end

functional.none = function(array)
    for _, v in ipairs(array) do
        if v then return false end
    end
    return true
end


functional.head = function(array) return array[1] end
functional.tail = function(array) return array[#array] end

functional.take = function(count, array)
    local ret = {}
    if count > 0 then
        for i = 1, count do
            tinsert(ret, array[i])
        end
    end
    return ret
end

functional.drop = function(count, array)
    local ret = {}
    local len = #array
    count = count + 1
    if count < len then
        for i = count, len do
            tinsert(ret, array[i])
        end
    end
    return ret
end

functional.reverse = function(array)
    local ret = {}
    local len = #array
    if len > 0 then
        for i = len, 1 do
            tinsert(ret, array[i])
        end
    end
    return ret
end

functional.contain = function(array, value)
    for _, v in ipairs(array) do
        if v == value then return true end
    end
end

functional.where = function(array, value)
    for i, v in ipairs(array) do
        if v == value then return i end
    end
end

functional.mininum = function(array)
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

functional.maxinum = function(array)
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

functional.sum = function(array)
    local ret = 0
    for _, v in ipairs(array) do
        ret = ret + v
    end
    return ret
end

functional.product = function(array)
    local ret = 1
    for _, v in ipairs(array) do
        ret = ret * v
    end
    return ret
end

functional.merge = function(array, addon)
    for _, v in ipairs(addon) do
        tinsert(array, v)
    end
end

functional.repeats = function(count, value)
    local ret = {}
    for _ = 1, count do
        tinsert(ret, value)
    end
    return ret
end

functional.cycles = function(count, array)
    local ret = {}
    for _ = 1, count do
        functional.merge(ret, array)
    end
    return ret
end

functional.map = function(array, func)
    local ret = {}
    for i, v in ipairs(array) do
        ret[i] = func(v)
    end
    return ret
end

functional.filter = function(array, func)
    local ret = {}
    for _, v in ipairs(array) do
        if func(v) then
            tinsert(ret, v)
        end
    end
    return ret
end

functional.reduce = function(array, func, state)
    for _, v in ipairs(array) do
        state = func(state, v)
    end
    return state
end

functional.reverse_ipairs = function(array)
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


---@param f function
---@param g function
functional.compose = function(f, g)
    return function(...)
        return f(g(...))
    end
end

---@param f function
functional.curry = function(f, ...)
    local params = { ... }
    local paramsLen = #params
    return function(...)
        local addParams = { ... }
        local addParamsLen = #addParams
        table.move(addParams, 1, addParamsLen, paramsLen + 1, params)
        for i = paramsLen + addParamsLen + 1, #params do
            params[i] = nil
        end
        return f(table.unpack(params))
    end
end

return functional
