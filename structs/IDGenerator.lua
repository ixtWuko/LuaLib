local IDGenerator = class("IDGenerator")

function IDGenerator:init()
    self.last = 0
end

function IDGenerator:Gen()
    local id = self.last + 1
    self.last = id
    return id
end

return IDGenerator
