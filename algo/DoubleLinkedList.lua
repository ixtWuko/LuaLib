---@class DoubleLinkedList
local DoubleLinkedList = class("DoubleLinkedList")

function DoubleLinkedList:init()
    self._head = nil
    self._tail = nil
end

---@class DoubleLinkedListNode
---@field value any
---@field next DoubleLinkedListNode
---@field prev DoubleLinkedListNode

---@return DoubleLinkedListNode
function DoubleLinkedList.new_node(value)
    return {
        value = value,
        next = nil,
        prev = nil,
    }
end

---@param pos DoubleLinkedListNode
---@param node DoubleLinkedListNode
function DoubleLinkedList:insert(pos, node)
    if self._head == pos then
        self._head = node
    else
        pos.prev.next = node
    end
    node.prev = pos.prev
    node.next = pos
    pos.prev = node
end

function DoubleLinkedList:insert_head(node)
    if not self._head then
        self._head = node
        self._tail = node
        return
    end
    node.next = self._head
    self._head.prev = node
    self._head = node
end

function DoubleLinkedList:insert_tail(node)
    if not self._tail then
        self._head = node
        self._tail = node
        return
    end
    node.prev = self._tail
    self._tail.next = node
    self._tail = node
end

function DoubleLinkedList:remove(node)
    if self._head == node then
        self._head = node.next
    else
        node.prev.next = node.next
    end
    if self._tail == node then
        self._tail = node.prev
    else
        node.next.prev = node.prev
    end
    return node
end

function DoubleLinkedList:remove_head()
    if self._head then
        local node = self._head
        local next = self._head.next
        if next then next.prev = nil end
        self._head = next
        if self._tail == node then
            self._tail = nil
        end
        return node
    end
end

function DoubleLinkedList:remove_tail()
    if self._tail then
        local node = self._tail
        local prev = self._tail.prev
        if prev then prev.next = nil end
        self._tail = prev
        if self._head == node then
            self._head = nil
        end
        return node
    end
end

function DoubleLinkedList:find(value)
    local cur = self._head
    while cur do
        if cur.value == value then
            return cur
        end
        cur = cur.next
    end
end

function DoubleLinkedList:reverse_find(value)
    local cur = self._tail
    while cur do
        if cur.value == value then
            return cur
        end
        cur = cur.prev
    end
end

function DoubleLinkedList:__tostring()
    local ret = {}
    local idx = 1
    local cur = self._head
    while cur do
        ret[idx] = idx .. ": " .. tostring(cur.value)
        cur = cur.next
        idx = idx + 1
    end
    return table.concat(ret, "\n")
end

return DoubleLinkedList
