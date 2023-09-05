---@class Dequeue
local Dequeue = class('Dequeue')

function Dequeue:init(initial_elements)
    self._data = initial_elements or {}
    self._head = 1
    self._tail = #self._data + 1
end

function Dequeue:IsEmpty()
    return self._tail == self._head
end

function Dequeue:Length()
    return self._tail - self._head
end

function Dequeue:PutLeft(element)
    self._head = self._head - 1
    self._data[self._head] = element
end

function Dequeue:PutRight(element)
    self._data[self._tail] = element
    self._tail = self._tail + 1
end

function Dequeue:GetLeft()
    if self._tail == self._head then
        return nil
    end
    local ret = self._data[self._head]
    self._data[self._head] = nil
    self._head = self._head + 1
    return ret
end

function Dequeue:GetRight()
    if self._tail == self._head then
        return nil
    end
    self._tail = self._tail - 1
    local ret = self._data[self._tail]
    self._data[self._tail] = nil
    return ret
end

function Dequeue:Clear()
    self:init()
end

return Dequeue
