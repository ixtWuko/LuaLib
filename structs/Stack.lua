---@class Stack
local Stack = class('Stack')

function Stack:init(initial_elements)
    self._data = initial_elements or {}
    self._top = #self._data
end

function Stack:IsEmpty()
    return self._top == 0
end

function Stack:Length()
    return self._top
end

function Stack:Push(element)
    self._top = self._top + 1
    self._data[self._top] = element
end

function Stack:Pop()
    local top = self.top
    if top == 0 then
        return nil
    end
    local ret = self._data[top]
    self._data[top] = nil
    self._top = top - 1
    return ret
end

function Stack:Clear()
    self:init()
end

return Stack
