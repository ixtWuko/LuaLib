local DoubleLinkedList = require("src.common.Algo.DoubleLinkedList")

---@class LRU
---@field cache table @<key, node>
---@field order table @<key, value>
local LRU = class("LRU")

---@param capacity number
function LRU:init(capacity)
    self.capacity = capacity
    self.cache = {}
    self.order = DoubleLinkedList.new()
end

function LRU:put(key, value)
    if self.capacity == 0 then
        local removeNode = self.order:remove_tail().value
        self.cache[removeNode.key] = nil
        self.capacity = self.capacity + 1
    end
    self.capacity = self.capacity - 1
    local addedNode = DoubleLinkedList.new_node({ key = key, value = value })
    self.order:insert_head(addedNode)
    self.cache[key] = addedNode
end

function LRU:get(key)
    local node = self.cache[key]
    if node then
        self.order:remove(node)
        self.order:insert_head(node)
        return node.value.value
    end
end

return LRU
