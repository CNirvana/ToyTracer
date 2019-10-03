Metal = Material:extend()

function Metal:new(albedo, fuzz)
    self.albedo = albedo
    self.fuzz = clamp(fuzz, 0.0, 1.0)
end

function Metal:scatter(ray, hitInfo)
    local refl = reflect(ray.direction:normalize(), hitInfo.normal)
    refl = refl + randomInUnitSphere():multiply(self.fuzz)
    local newRay = Ray(hitInfo.position, refl:normalize())
    if Vec3.dot(newRay.direction, hitInfo.normal) > 0 then
        return {attenuation = self.albedo, scattered = newRay}
    else
        return nil
    end
end