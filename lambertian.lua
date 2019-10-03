Lambertian = Material:extend()

function Lambertian:new(albedo)
    self.albedo = albedo
end

function Lambertian:scatter(ray, hitInfo)
    local target = hitInfo.position + hitInfo.normal + randomInUnitSphere()
    local newRay = Ray(hitInfo.position, (target - hitInfo.position):normalize())
    return {attenuation = self.albedo, scattered = newRay}
end