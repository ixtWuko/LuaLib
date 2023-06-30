local isinstance
isinstance = function(instance, base)
    local metatable = getmetatable(instance)
    while metatable do
        if metatable == base then
            return true
        end
        metatable = metatable.__super
    end
    return false
end

---@param className string
---@param super Class
---@return Class
local function class(className, super)
    local cls = { __className = className, __super = super }
    if super then
        setmetatable(cls, super)
    end

    cls.__index = cls
    cls.new = function(...)
        local instance = setmetatable({}, cls)
        if cls.init then
            cls.init(instance, ...)
        end
        return instance
    end
    cls.isinstance = isinstance
    return cls
end

return class
