IU
==

IU is a simple Object-Oriented model for Lua scripting. It simplifies the process of writing Lua scripts by allowing the use of standard OO paradigms. This library is designed to be very small; I've worked hard to make sure it remains under ~50 lines so that it is not a big dependency. Also, this model is not comprehensive, but handles most general cases.

Features
--------
* Classes can inherit from one other class
* Classes can be constructed from base tables via the `new` operator
* Superclass functions are available via `self:spr(<,…)`
* Sane defaults for unimplemented classes are provided
* All object instances get a unique identifier available using `self._id` or `<inst>._id`
* A meaningful "toString" method is provided, so print(<inst>) and print(<class>) actually do something useful

Special Functions
-----------------
IU provides a set of special functions for utilizing its OO model, as well as the
nested table structure:

* `def(<name>,[root])`: The entry point into the IU class system. Declares a class object with the given name and parent/base class. The root parameter is optional; unspecified, the class inherits from the root `Object` class.

        A = cls.def('A')    -- Class A
        B = cls.def('B', A) -- Class B, inherits A

* `self:spr(<name>,…)`: Super method helper function. Accesses the superclass table with the given function name, and attempts to call it with the specified
arguments.
* `self:udc(<name>,…)`: Userdata helper function. Accesses methods on the embedded user data, passing a reference to the Userdata object instead of a reference to
self. This is provided for libraries like [Love2d](http://www.love2d.org) (see below), which use functions
that produce Userdata objects when called. The IU class model allows for
IU classes to be based on Userdata objects by defining a `new` function on the
class.

### Other Helpful Functions
* `slice(array,start,[end])`: Produces an array segment from start to end. The end parameter is optional; if unspecified, it will slice up to the end
of the array. Negative end slices can be specified, which slices up to the
-nth index counting from the right end.

        local a = {1, 2, 3, 4, 5}
        slice(a,2)    => {2,3,4,5}
        slice(a,1,3)  => {1,2,3}
        slice(a,1,-1) => {1,2,3,4,5}

* `isCls(o)`: Checks if the given object is a IU class. This function
is guarded, so any Lua type can be checked without causing an Error. This
function returns `false` instead of `nil` when the object is NOT a class.
* `isIns(o)`: Checks if the given object is an instance of a IU class. This function is guarded, so any Lua type can be checked without causing an Error. This function returns `false` instead of `nil` when the object is not a IU instance.
    
Examples
-------------------
See the test_suite.lua file for a comprehensive example of all of the features that this OO model supports. Additional examples are listed below:

### Base Table Construction
IU integrates well with other class / table systems, allowing you
to construct IU classes that are based on non-empty tables. This allows
direct integration with frameworks like [Love2d](http://www.love2d.org) and [CoronaSDK](http://www.anscamobile.com/corona/), which
use their own object models for objects. An example for Love2d is below:

    cls = require('iu')

    Body = cls.def('Body')
    function Body:new(...)
        return love.physics.newBody(unpack(cls.slice(arg,1,5))), cls.slice(arg,6)
    end
    
    function love.load()
        local w = love.physics.newWorld(0,0,650,650)
        w:setGravity(0,700)
        w:setMeter(64)
    
        local ground = Body(w, 650/2, 625, 0, 0)
        print('Body at: ['..ground:udc('getX')..', '..ground:udc('getY')..']')
    end

### Inheritance

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

### Operator Overloading

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

TODO
----
* Fix the `get` and `set` methods in the base class. The IU core object has been written to support overloading these functions so you can manipulate index
read and write. Right now, the functionality is there but it chains infinitely
due to the way the code is structured. In the future, I might fix this; right now I think that its best to keep it simple.
* Explore other means of handling Userdata objects. The `udc` method isn't bad, but its not as streamlined as I would have liked it to be. The problem is that
lua doesn't have an easy way to manipulate the behavior of calling functions via the colon syntax. Self is always passed, where we actually need a reference to the Userdata object (at least in the case of Love2d).