cls = require('iu')
    
A = cls.def('A')
function A:init(n)
    self.n = n
end
function A:str()
    return self._id..': '..self.n
end
function A:add(o)
    return A(self.n+o.n)
end

local a1 = A(2)
local a2 = A(2)
local a3 = a1 + a2
print(a1, a2, a3)
