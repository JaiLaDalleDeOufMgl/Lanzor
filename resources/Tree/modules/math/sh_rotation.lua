Tree.Math.Rotation = {}

function Tree.Math.Rotation.toDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }
    local direction = {
        x = -math.sin(adjustedRotation.z),
        y = math.cos(adjustedRotation.z),
        z = 0 
    }
    return vector3(direction.x, direction.y, direction.z)
end


function Tree.Math.minutesToMS(minutes)
    return minutes * 60000
end