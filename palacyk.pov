#include "colors.inc"
#include "math.inc"

#declare cam = array[1]{
    camera {
        location <0,8,-80>
        look_at <0,8,0>
    }
}

global_settings { ambient_light <1,1,1> }

/*
    kamery
    0 - whatever
*/
camera {cam[0]}

//kolorki/tekstury
#declare c_wall = texture {pigment {rgb <1.000, 0.871, 0.678>}}
#declare c_wall_alt = texture {pigment {rgb <1, 1, 1>}}
#declare c_roof = texture {pigment {rgb <0.8, 0, 0>}} //todo
#declare c_metal = texture {pigment {rgb <1, 1, 1>}} //todo


light_source {
    <100,1250,-250>,
    White
}

plane {
    y, 0
    pigment {color Gray}
}

union {
    box {
        //random stuff behind
        <0,0,0>,<5,10,-5>
        texture {c_wall}
        translate <-2,0,1>
    }
    union {
        //tower 
        cylinder {
            <0,0,0>, <0,9.5,0>, 3 
            texture {c_wall}
        }
        cylinder {
            <0,9.5,0>, <0,10,0>, 3.03 
            texture {c_wall_alt}
        }
        cylinder {
            <0,10,0>, <0,13,0>, 3 
            texture {c_wall}
        }
        cylinder {
            <0,13,0>, <0,13.25,0>, 3.03 
            texture {c_wall_alt}
        }
        cone {
            <0,13.25,0>, 3.03
            <0,14,0>, 3.08
            texture {c_wall_alt}
        }
        translate <2,0,-5>
    }
    union {
        //x-aligned walls
        box {
            <0,0,0>,<10,10,-5>
            texture {c_wall}
        }
        box {
            <0,0,1>,<5,10,-6>
            texture {c_wall}
            translate x*10
        }
        box {
            <0,0,1>,<15,10,-5.5>
            texture {c_wall}
            translate x*15
        }
        box {
            <0,0,1>,<5,10,-6>
            texture {c_wall}
            translate x*30
        }
    }
    union {
        //unaligned walls
        box {
            <0,0,0>,<15,8,5>
            texture {c_wall}
            rotate y*135
            translate <0,0,0>
        }
        box {
            <0,0,0>,<10,8,5.5>
            texture {c_wall}
            rotate y*125
            translate <15*cosd(-135),0,15*sind(-135)>
        }
        box {
            <0,0,0.5>,<6,8,5>
            texture {c_wall}
            rotate y*125
            translate <15*cosd(-135)+10*cosd(-125),0,15*sind(-135)+10*sind(-125)>
        }                            
        box {
            <0,0,-0.5>,<8,8,6>
            texture {c_wall}
            rotate y*125
            translate <15*cosd(-135)+16*cosd(-125),0,15*sind(-135)+16*sind(-125)>
        }
        translate <0,0,1>
    }
}