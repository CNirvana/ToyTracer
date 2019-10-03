Sphere = Shape:extend()

function Sphere:new(position, material, radius)
    Sphere.super.new(self, position, material)
    self.radius = radius
end

function Sphere:intersect(ray, tmin, tmax)
    local oc = ray.origin - self.position
    local a = Vec3.dot(ray.direction, ray.direction)
    local b = 2.0 * Vec3.dot(oc, ray.direction)
    local c = Vec3.dot(oc, oc) - self.radius * self.radius
    local discriminant = b * b - 4 * a * c
    if discriminant > 0 then
        local temp = (-b - math.sqrt(discriminant)) / (2 * a)
        if (temp < tmax) and (temp > tmin) then
            local position = ray:getPoint(temp)
            local normal = (position - self.position):divide(self.radius)
            return HitInfo(ray:getPoint(temp), normal, temp, self.material)
        end
        temp = (-b + math.sqrt(discriminant)) / (2 * a)
        if (temp < tmax) and (temp > tmin) then
            local position = ray:getPoint(temp)
            local normal = (position - self.position):divide(self.radius)
            return HitInfo(ray:getPoint(temp), normal, temp, self.material)
        end
    else
        return nil
    end
end