cls = require('mc')

-- Construct a class
A = cls.def('A')

-- Static property
A.foo = 'foo'

-- Base table constructor
function A:new(...)
    print('Constructing an A base')
    return {red = 'truck', b = arg[1]},cls.slice(arg,2)
end
-- Initializer
function A:init(bar)
    print('Initializing A instance: '..self._id..', '..bar)
    self.bar = bar
end
-- toString method
function A:str()
    return 'Custom '..self.bar..' for the object A '..self._id
end
-- Operator functions
function A:add(o)
    return A(self.b+o.b,'add')
end

-- Single class inheritance
B = cls.def('B',A)

-- Super class method call
function B:init(bar,bat)
    self:spr('init',bar)
    self.bat = bat
end

-- Run tests
print('---------- class A ----------')
local a = A(10,'bar')
local b = A(20,'baz')
assert(a.foo == A.foo)
assert(a.red ~= nil)
local c = a+b
assert(c.b == 30)
print('---------- class A ----------')
print('')
print('---------- class B ----------')
local d = B(30,'one','two')
assert(d.foo == A.foo)
assert(d.red ~= nil)
assert(d.bar == 'one')
assert(d.bat ~= nil)
local e = c+d
assert(e.b == 60)
print('---------- class B ----------')
