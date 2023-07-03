---@class Queue.lua
local Queue = class('Queue.lua')

function Queue:init(initial_elements)
    self._data = initial_elements or {}
    self._head = 1
    self._tail = #self._data + 1
end

function Queue:isEmpty()
    return self._tail == self._head
end

function Queue:length()
    return self._tail - self._head
end

function Queue:put(element)
    self._data[self._tail] = element
    self._tail = self._tail + 1
end

function Queue:get()
    if self._tail == self._head then
        return nil
    end
    local ret = self._data[self._head]
    self._data[self._head] = nil
    self._head = self._head + 1
    return ret
end

function Queue:clear()
    self:init()
end

return Queue
