local DoubleBuffer = class("DoubleBuffer")

function DoubleBuffer:init()
    self.frontBuffer = {}
    self.backBuffer = {}
end

function DoubleBuffer:GetFrontBuffer()
    return self.frontBuffer
end

function DoubleBuffer:GetBackBuffer()
    return self.backBuffer
end

function DoubleBuffer:Swap()
    self.frontBuffer, self.backBuffer = self.backBuffer, self.frontBuffer
end

return
