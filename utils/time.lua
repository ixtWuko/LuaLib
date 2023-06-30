local socket = require("socket")

local time = {}

function time.GetTimestampInSecond()
    return math.floor(socket.gettime())
end

function time.GetTimestampInMillisecond()
    return math.floor(socket.gettime() * 1000)
end

return time
