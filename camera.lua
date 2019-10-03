Camera = Object:extend()

function Camera:new(width, height, position)
    self.width = width
    self.height = height
    self.aspect = width / height
    self.position = position
end

function Camera:getRay(u, v)
    u = (u * 2 - 1) * self.aspect
    v = (v * 2 - 1)

    return Ray(self.position, Vec3(u, v, -1):normalize())
end