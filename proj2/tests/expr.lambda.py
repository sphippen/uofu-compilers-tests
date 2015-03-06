lambda: 1
lambda x: x
lambda x,: x
lambda x=1: x
lambda x,y,z: x+y/z
lambda x,y,z=10: x+y/z

lambda x,*z,a=10: x
lambda x=1,*z,a: a
lambda x=1,*z,a=3: a
lambda x=1,*z,a,b: a
lambda x=1,*z,a=3,b: a
lambda x=1,*z,a,b=3: a
lambda x=1,*z,a=10,b=3: a
lambda x,*z,a,b=3: a
lambda x,y,z=1,*foo,a=18: a
lambda x,y=(2+3),z=1,*foo,a: a
lambda x,y=(2+3),z=10,*foo,a,**rest: rest
lambda x,y=(2+3),z=10,*foo,a=20,**rest: rest

lambda x,*,a=10: x
lambda x=1,*,a: a
lambda x=1,*,a=3: a
lambda x=1,*,a,b: a
lambda x=1,*,a=3,b: a
lambda x=1,*,a,b=3: a
lambda x=1,*,a=10,b=3: a
lambda x,*,a,b=3: a
lambda x,y,z=1,*,a=18: a
lambda x,y=(2+3),z=1,*,a: a
lambda x,y=(2+3),z=10,*,a,**rest: rest
lambda x,y=(2+3),z=10,*,a=20,**rest: rest

lambda *z,a: a
lambda *z,a=10: a
lambda *z,a,b: a
lambda *z,a=10,b: a
lambda *z,a,b=20: a
lambda *z,a=10,b=10: a
lambda *z,a,b=4,**rest: 2
lambda *z,a,b,**rest: 2
lambda *z,a=10,**rest: 2

lambda *,a: a
lambda *,a=10: a
lambda *,a,b: a
lambda *,a=10,b: a
lambda *,a,b=20: a
lambda *,a=10,b=10: a
lambda *,a,b=4,**rest: 2
lambda *,a,b,**rest: 2
lambda *,a=10,**rest: 2

lambda **rest: 3

# This one revelead a bug in pyparse once upon a time
lambda x=3, y=4, *z: 0
