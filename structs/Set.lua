local ipairs = ipairs
local pairs = pairs

---@class Set
local Set = class('Set')

---@param initial_elements table
function Set:init(initial_elements)
    if initial_elements then
        for _, v in ipairs(initial_elements) do
            self[v] = true
        end
    end
end

function Set.Union(sa, sb)
    local ret = Set.new()
    for k, _ in pairs(sa) do
        ret[k] = true
    end
    for k, _ in pairs(sb) do
        ret[k] = true
    end
    return ret
end

function Set.Difference(sa, sb)
    local ret = Set.new()
    for k, _ in pairs(sa) do
        ret[k] = true
    end
    for k, _ in pairs(sb) do
        ret[k] = nil
    end
    return ret
end

function Set.Interaction(sa, sb)
    local diff = Set.Difference(sa, sb)
    return Set.Difference(sa, diff)
end

return Set
