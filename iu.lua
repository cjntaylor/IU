local m={gm=getmetatable,sm=setmetatable,rg=rawget,rs=rawset,upk=unpack,ti=table.insert,pc=pcall,sf=string.format};
m.nul=function(o)return o==nil;end;m.non=function(o)return o~=nil;end
m.def=function(n,r)local d={_id=0,_nm=n,_rt=(m.nul(r)and{m.obj}or{r})[1]};m.sm(d,m.obj._mt);return d;end
m.obj={
    init = function(...)end,call = function(...)end,new  = function(s,...)return{},arg;end,
    spr  = function(s,k,...)if m.nul(s._cl)then return;end;m.ti(arg,1,s);return s._su[k](m.upk(arg));end,
    udc  = function(s,k,...)if m.nul(s._ud)then return;end;m.ti(arg,1,s._ud);return s._ud[k](m.upk(arg));end,
    str  = function(s) return '['..(m.non(s._cl)and{s._nm..' inst'}or{'class '..s._nm})[1]..(m.non(s._cl)and{' id: '..s._id}or{''})[1]..']';end,
    get  = function(s,k)local r=m.rg(s,k)
        if m.nul(r) and m.non(m.rg(s,'_ud'))then r=m.rg(s,'_ud')[k]end
        if m.nul(r) and m.non(m.rg(s,'_cl'))then r=m.rg(s,'_cl')[k]end
        if m.nul(r) and m.non(m.rg(s,'_rt'))then r=m.rg(s,'_rt')[k]end;return r
    end,
    set = function(s,k,v)if m.non(m.rg(s,'_bs'))and m.non(m.rg(s,'_bs')[k])then m.rg(s,'_bs')[k]=v;else m.rs(s,k,v)end;end,
    add = function(s,o)end, sub = function(s,o)end, mul = function(s,o)end, 
    div = function(s,o)end,pow = function(s,o)end,
    _nm  = 'Object', _mt  = {
        __add=function(l,r)return l:add(r);end,__sub=function(l,r)return l:sub(r);end,
        __mul=function(l,r)return l:mul(r);end,__div=function(l,r)return l:div(r);end,
        __pow=function(l,r)return l:pow(r);end,
        __call = function(c,...)
            if m.non(c._cl) then return c:call(m.upk(arg)) end
            local t,a=c:new(m.upk(arg));if not m.pc(function()t.f=nil;end)then local u=t;t={};t._ud=u;end
            t._id=m.sf('0x%04x',c._id);c._id=c._id+1;t._su={};m.sm(t._su,{__index=function(s,k)
            if m.non(t._bs)and m.non(t._bs[k])then return t._bs[k];end;return c._rt[k]end})
            t._bs=m.gm(t);t._cl=c;m.sm(t,m.obj._mt);t:init(m.upk(a));return t
        end,
        __index = function(s,k)
            local f=m.rg(s,'get')
            if m.nul(f)and m.non(m.rg(s,'_cl'))then f=m.rg(s,'_cl')['get'] end
            if m.nul(f)and m.non(m.rg(s,'_rt'))then f=m.rg(s,'_rt')['get'] end
            return f(s,k)
        end,
        __newindex = function(s,k,v)s:set(k,v)end,__tostring = function(s)return s:str()end
    },
}
m.sm(m.obj,m.obj._mt);m.id=function(o)return(m.pc(function()return m.rg(o,'_id')end)and{m.rg(o,'_id')}or{m.sf('0x%x',65535)})[1]end
m.slice = function(v,s,e)
    local r={};local n=#v;local k=1;s=s or 1;e=e or n;
    if e<0 then e=n+e+1 elseif e>n then e=n;end;if s<1 or s>n then return{}end
    for i=s,e do r[k]=v[i];k=k+1;end;return r
end
m.isCls = function(o)return (m.pc(function()return m.rg(o,'_rt')end)and{m.non(m.rg(o,'_rt'))}or{false})[1]end
m.isIns = function(o)return (m.pc(function()return m.rg(o,'_cl')end)and{m.non(m.rg(o,'_cl'))}or{false})[1]end
return m
