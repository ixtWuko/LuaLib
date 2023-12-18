local table = table

local EMPTY_PER_DEPTH = "    "
local _insert = table.insert
local _insert_empty = function(str, depth)
    for _ = 1, depth do
        _insert(str, EMPTY_PER_DEPTH)
    end
end

local _dump
_dump = function(tbl, str, curDepth)
    if type(tbl) == 'table' then
        _insert(str, "\n")
        _insert_empty(str, curDepth)
        _insert(str, "{\n")
        for k, v in pairs(tbl) do
            _insert_empty(str, curDepth + 1)
            _insert(str, tostring(k))
            _insert(str, " = ")
            _dump(v, str, curDepth + 1)
        end
        _insert_empty(str, curDepth)
        _insert(str, "}\n")
    else
        _insert(str, tostring(tbl))
        _insert(str, ",\n")
    end
end

function table.dump(tbl)
    local strTable = {}
    _dump(tbl, strTable, 0)
    return table.concat(strTable)
end


function table.isempty(tbl)
    return not next(tbl)
end

function table.copy(tbl)
    assert(type(tbl) == 'table', "parameter must be a table!")
    local ret = {}
    for k, v in pairs(tbl) do
        ret[k] = v
    end
    setmetatable(ret, getmetatable(tbl))
    return ret
end

function table.merge(ta, tb)
    local ret = {}
    for k, v in pairs(tb) do
        ret[k] = v
    end
    for k, v in pairs(ta) do
        ret[k] = v
    end
    return ret
end

function table.makemap(array)
    local ret = {}
    for i, v in ipairs(array) do
        ret[v] = i
    end
    return ret
end
