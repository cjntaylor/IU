cls = require('iu')
      
A = cls.def('A')
function A:init()
    self.a = 10
end
B = cls.def('B', A)
function B:init()
    self:spr('init')
    self.b = 20
end
local b = B()
print('B a: '..b.a..' b: '..b.b)
