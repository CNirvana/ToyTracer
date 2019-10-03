HitInfo = Object:extend()

function HitInfo:new(position, normal, t, material)
    self.position = position
    self.normal = normal
    self.t = t
    self.material = material
end