Shape = Object:extend()

function Shape:new(position, material)
    self.position = position
    self.material = material
end

function Shape:intersect(ray, tmin, tmax)
end