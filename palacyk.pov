#include "colors.inc"
#include "math.inc"

#declare cam = array[1]{
    camera {
        location <50,20,-50>
        look_at <0,0,0>
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


light_source {
    <-150,250,-150>,
    White
}

plane {
    y, 0
    pigment {color Gray}
}

union {
    box {
        <0,0,0>,<5,10,-5>
        texture {c_wall}
        translate <-2,0,1>
    }
    cylinder {
        <0,0,0>, <0,10,0>, 3 
        texture {c_wall}
        translate <2,0,-5>
    }
    union {
        box {
            <0,0,0>,<12,10,-5>
            texture {c_wall}
        }
        box {
            <0,0,1>,<5,10,-6>
            texture {c_wall}
            translate x*12
        }
        box {
            <0,0,1>,<15,10,-5.5>
            texture {c_wall}
            translate x*17
        }
        box {
            <0,0,1>,<5,10,-6>
            texture {c_wall}
            translate x*32
        }
    }
    union {
        box {
            <0,0,0>,<10,10,6>
            texture {c_wall}
            rotate y*135
            translate <0,0,0>
        }
        box {
            <0,0,0>,<20,10,5.5>
            texture {c_wall}
            rotate y*125
            translate <-7.05,0,-7.05>
        }                            
        box {
            <0,0,-0.5>,<8,10,6>
            texture {c_wall}
            rotate y*120
            translate <10*cosd(-135)+20*cosd(-125),0,10*sind(-135)+20*sind(-125)>
        }
        translate <0,0,1>
    }
}