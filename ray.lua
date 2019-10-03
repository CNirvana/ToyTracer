Ray = Object:extend()

function Ray:new(ro, rd)
    self.origin = ro
    self.direction = rd
end

function Ray:getPoint(t)
    return self.origin + self.direction:multiply(t)
end