Scene = Object:extend()

function Scene:new()
    self.objects = {}
end

function Scene:add(object)
    table.insert(self.objects, object)
end

function Scene:intersect(ray, tmin, tmax)
    local ret = nil
    local closest = tmax

    for i, object in ipairs(self.objects) do
        local hit = object:intersect(ray, tmin, closest)
        if hit ~= nil then
            closest = hit.t
            ret = hit
        end
    end

    return ret
end