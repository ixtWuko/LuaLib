---@class Stack
local Stack = class('Stack')

function Stack:init(initial_elements)
    self._data = initial_elements or {}
    self._top = #self._data
end

function Stack:isEmpty()
    return self._top == 0
end

function Stack:length()
    return self._top
end

function Stack:push(element)
    self._top = self._top + 1
    self._data[self._top] = element
end

function Stack:pop()
    if self.top == 0 then
        return nil
    end
    local ret = self._data[self._top]
    self._data[self._top] = nil
    self._top = self._top - 1
    return ret
end

function Stack:clear()
    self:init()
end

return Stack
