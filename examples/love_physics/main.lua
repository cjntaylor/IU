cls = require('iu')

Body = cls.def('Body')
function Body:new(...)
    return love.physics.newBody(unpack(cls.slice(arg,1,5))),cls.slice(arg,6)
end

function love.load()
    local w = love.physics.newWorld(0,0,650,650)
    w:setGravity(0,700)
    w:setMeter(64)

    local ground = Body(w, 650/2, 625, 0, 0)
    print('Body at: ['..ground:udc('getX')..', '..ground:udc('getY')..']')
end
