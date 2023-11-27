local table = table

local EMPTY_PER_DEPTH = "    "
local _insert = table.insert
local _insert_empty = function(str, depth)
    for _ = 1, depth do
        _insert(str, EMPTY_PER_DEPTH)
    end
end

local _dump
_dump = function(tb, str, curDepth)
    if type(tb) == 'table' then
        _insert(str, "\n")
        _insert_empty(str, curDepth)
        _insert(str, "{\n")
        for k, v in pairs(tb) do
            _insert_empty(str, curDepth + 1)
            _insert(str, tostring(k))
            _insert(str, " = ")
            _dump(v, str, curDepth + 1)
        end
        _insert_empty(str, curDepth)
        _insert(str, "}\n")
    else
        _insert(str, tostring(tb))
        _insert(str, ",\n")
    end
end

table.dump = function(tb)
    local strTable = {}
    _dump(tb, strTable, 0)
    return table.concat(strTable)
end


table.isempty = function(tb)
    return not next(tb)
end

table.copy = function(tb)
    assert(type(tb) == 'table', "parameter must be a table!")
    local ret = {}
    for k, v in pairs(tb) do
        ret[k] = v
    end
    setmetatable(ret, getmetatable(tb))
    return ret
end

table.merge = function(ta, tb)
    local ret = {}
    for k, v in pairs(tb) do
        ret[k] = v
    end
    for k, v in pairs(ta) do
        ret[k] = v
    end
    return ret
end

table.makemap = function(list)
    local ret = {}
    for i, v in ipairs(list) do
        ret[v] = i
    end
    return ret
end
