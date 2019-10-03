Vec3 = Object:extend()

function Vec3:new(x, y, z)
    self.x = x
    self.y = y
    self.z = z
end

function Vec3.__add(lhs, rhs)
    return Vec3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
end

function Vec3.__sub(lhs, rhs)
    return Vec3(lhs.x - rhs.x, lhs.y - rhs.y, lhs.z - rhs.z)
end

function Vec3:multiply(c)
    return Vec3(self.x * c, self.y * c, self.z * c)
end

function Vec3:divide(c)
    return Vec3(self.x / c, self.y / c, self.z / c)
end

function Vec3.dot(v1, v2)
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end

function Vec3.cross(v1, v2)
    return Vec3(v1.y * v2.z - v1.z * v2.y, v1.z * v2.x - v1.x * v2.z, v1.x * v2.y - v1.y * v2.x)
end

function Vec3.modulate(v1, v2)
    return Vec3(v1.x * v2.x, v1.y * v2.y, v1.z * v2.z)
end

function Vec3:length()
    return math.sqrt(Vec3.dot(self, self))
end

function Vec3:normalize()
    return self:divide(self:length())
end