local component = require("component")
local amtrak = component.ir_remote_control

local stations = {
    ["New Downtown"] = {
        ["Arriving"] = {
            ["Coordinates"] = {{-15500, -15495}, {3355, 3360}},
            ["Throttle"] = 0,
            ["Brake"] = 0.35
        },
        ["Arrived"] = {
            ["Coordinates"] = {{-15675, -15673}, {3355, 3360}},
            ["Throttle"] = nil,
            ["Brake"] = 1,
            ["SleepTime"] = 15,
            ["NextCommand"] = true
        }
    },
    ["Village"] = {
        ["Arriving"] = {
            ["Coordinates"] = {{-15935, -15930}, {4120, 4125}},
            ["Throttle"] = 0,
            ["Brake"] = 0.25
        },
        ["Arrived"] = {
            ["Coordinates"] = {{-15715, -15710}, {4205, 4210}},
            ["Throttle"] = nil,
            ["Brake"] = 1,
            ["SleepTime"] = 15,
            ["NextCommand"] = true
        }
    },
    ["Space Center"] = {
        ["Arriving"] = {
            ["Coordinates"] = {{-15153, -15148}, {4125, 4130}},
            ["Throttle"] = 0,
            ["Brake"] = 0.2
        },
        ["Arrived"] = {
            ["Coordinates"] = {{-15153, -15148}, {3910, 3914}},
            ["Throttle"] = nil,
            ["Brake"] = 1,
            ["SleepTime"] = 15,
            ["NextCommand"] = true
        }
    }
}

local function handleArrival(message, throttle, brake, sleepTime, nextCommand)
    sleepTime = sleepTime or 0
    print(message)
    amtrak.setThrottle(throttle)
    amtrak.setBrake(brake)
    os.sleep(sleepTime)
    if nextCommand then os.execute("RegionalRail") end
end

amtrak.setBrake(0)
amtrak.horn()
os.sleep(1)
amtrak.horn()
amtrak.setThrottle(0.38)
print("Regional Rail Running")

while true do
    local i, _, j = amtrak.getPos()

    for station, phases in pairs(stations) do
        for phase, info in pairs(phases) do
            local coords = info.Coordinates
            if i > coords[1][1] and i < coords[1][2] and j > coords[2][1] and j < coords[2][2] then
                handleArrival(phase .. " at " .. station, info.Throttle, info.Brake, info.SleepTime, info.NextCommand)
            end
        end
    end
end