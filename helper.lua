function randomInUnitSphere()
    local x = 0
    local y = 0
    local z = 0
    local d = 0
    repeat
        x = love.math.random() * 2 - 1
        y = love.math.random() * 2 - 1
        z = love.math.random() * 2 - 1
        d = x * x + y * y + z * z
    until (d < 1)
    return Vec3(x, y, z)
end

function reflect(v, n)
    return v - n:multiply(2 * Vec3.dot(v, n))
end

function clamp(t, min, max)
    if t < min then t = min end
    if t > max then t = max end
    return t
end