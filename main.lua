Object = require "classic"
require "vec3"
require "helper"
require "ray"
require "hitinfo"
require "material"
require "lambertian"
require "metal"
require "shape"
require "sphere"
require "scene"
require "camera"

function love.load()
    local width, height, flags = love.window.getMode()
    screenWidth = width
    screenHeight = height
    maxDepth = 32
    ns = 8

    scene = Scene()
    scene:add(Sphere(Vec3(0.0, 0.0, -1.0), Lambertian(Vec3(0.8, 0.3, 0.3)), 0.5))
    scene:add(Sphere(Vec3(0.0, -100.5, -1.0), Lambertian(Vec3(0.8, 0.8, 0.0)), 100.0))
    scene:add(Sphere(Vec3(1.0, 0.0, -1.0), Metal(Vec3(0.8, 0.6, 0.2), 0.3), 0.5))
    scene:add(Sphere(Vec3(-1.0, 0.0, -1.0), Metal(Vec3(0.8, 0.8, 0.8), 1.0), 0.5))

    camera = Camera(screenWidth, screenHeight, Vec3(0.0, 0.0, 0.0))

    data = love.image.newImageData(screenWidth, screenHeight)
    for y = 0, screenHeight - 1 do
        for x = 0, screenWidth - 1 do
            local finalColor = Vec3(0.0, 0.0, 0.0)
            for s = 0, ns - 1 do
                local u = (x + love.math.random()) / screenWidth
                local v = 1 - (y + love.math.random()) / screenHeight
                local ray = camera:getRay(u, v)
                local color = getColor(ray, 0)
                finalColor = finalColor + color
            end
            finalColor = finalColor:divide(ns)

            -- Gamma Corrected
            finalColor.x = math.sqrt(finalColor.x)
            finalColor.y = math.sqrt(finalColor.y)
            finalColor.z = math.sqrt(finalColor.z)

            data:setPixel(x, y, finalColor.x, finalColor.y, finalColor.z, 1)
        end
    end
    fb = love.graphics.newImage(data)
end

function getColor(ray, depth)
    local hit = scene:intersect(ray, 0.001, 1000.0)
    if hit ~= nil then
        local material = hit.material
        local scatter = material:scatter(ray, hit)
        if (depth < maxDepth) and (scatter ~= nil) then
            return Vec3.modulate(getColor(scatter.scattered, depth + 1), scatter.attenuation)
        else
            return Vec3(0.0, 0.0, 0.0)
        end
    end

    local dir = ray.direction:normalize()
    local t = 0.5 * (dir.y + 1.0)
    return Vec3(1.0, 1.0, 1.0):multiply(1.0 - t) + Vec3(0.5, 0.7, 1.0):multiply(t)
end

function love.update(dt)
end

function love.draw()
    love.graphics.draw(fb)
end