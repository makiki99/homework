#include "colors.inc"
#include "math.inc"

#declare cam = array[1]{
    camera {
        location <0,10,-50>
        look_at <0,10,0>
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
#declare c_roof = texture {pigment {rgb <0.8, 0, 0>}}
#declare c_metal = texture {pigment {rgb <0.1, 0.1, 0.1>}}
#declare c_grass = texture {pigment {rgb <0.1, 0.1, 0.1>}}


sphere {<0,0,0>,10000 pigment {color Blue}}
light_source {
    <100,1250,-250>,
    White
}

plane {
    y, 0
    pigment {color Gray}
}

union {
    union {
        //random stuff behind
        box {
            <0,0,0>,<5,10,-5>
            texture {c_wall}
        }
        prism {
            conic_sweep
            0,1,5,
            <-2.5,-2.5>,<2.5,-2.5>,<2.5,2.5>,<-2.5,2.5>,<-2.5,-2.5>
            scale <1,2,1>
            rotate x*180 
            translate <2.5,12,-2.5>
            texture {c_roof} 
        }
        translate <-2,0,1>
    }
    union {
        //tower 
        cylinder {
            <0,0,0>, <0,9.75,0>, 3 
            texture {c_wall}
        }
        cylinder {
            <0,9.75,0>, <0,10,0>, 3.01 
            texture {c_wall_alt}
        }
        difference {
            cylinder {
                <0,10,0>, <0,13,0>, 3 
                texture {c_wall}
            }
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
        cone {
            <0,13.75,0>, 3.33
            <0,16,0>, 1.2
            texture {c_roof}
        }
        difference {
            cylinder {
                <0,16,0>,
                <0,18.5,0>, 1.2
                open
                texture {c_metal}
            }
            #for (i,1,4,1)
                box {
                    <-15,16.5,-0.33>,<15,17.4,0.33>
                    rotate y*90*i+y*45
                }
                cylinder {
                    <-15,17.4,0>,<15,17.45,0>,0.33
                    rotate y*90*i+y*45
                }    
            #end
        }
        cone {
            <0,18.5,0>, 1.8
            <0,19.25,0>, 1
            texture {c_metal}
        }
        cone {
            <0,19.25,0>, 1
            <0,19.75,0>, 0.6
            texture {c_metal}
        }
        cone {
            <0,19.75,0>, 0.6
            <0,21,0>, 0
            texture {c_metal}
        }
        translate <2,0,-5>
    }
    union {
        //important definitions
        #declare window_slots = union {
            box {
                <0,9.5,-4.5>,<1.5,7.75,-5>
            }
            box {
                <0,6.5,-4.5>,<1.5,4.25,-5>
            }
            box {
                <0,3,-4.5>,<1.5,1.25,-5>
            }
            
            //texture {c_wall_roof}
        }
        #declare window_fills = union {
            box {
                <0,9.5,-4.5>,<1.5,7.75,-4.75>
            }
            box {
                <0,6.5,-4.5>,<1.5,4.25,-4.75>
            }
            box {
                <0,3,-4.5>,<1.5,1.25,-4.75>
            }
            texture {c_wall_alt}
            //todo: fix dem fills because wtf
        }
        //x-aligned walls
        union {
            difference {
                union {
                    box {
                        <0,0,0>,<10,10,-5>
                        texture {c_wall}
                    }
                    prism {
                        0,10,4
                        <0,0>,<0,5>,<2,2.5>,<0,0>
                        texture {c_roof}
                        rotate z*90
                        rotate y*180
                        translate y*10
                    }
                }
                //wijndow slot prep
                object {
                    window_slots
                    translate x*5.5
                }
            }
            object {
                window_fills
                translate x*5.5
            }
        }
        union {
            box {
                <0,0,1>,<5,10,-6>
                texture {c_wall}
            }
            prism {
                0,25,4
                <0,1>,<0,5.5>,<2,2.75>,<0,-1>
                texture {c_roof}
                rotate z*90
                rotate y*180
                translate y*10
            }
            translate x*10
        }
        union {
            box {
                <0,0,1>,<15,10,-5.5>
                texture {c_wall}
            }
            prism {
                2.75,6,4
                <0,0>,<0,5>,<2,2.5>,<0,0>
                texture {c_roof}
                rotate z*90
                rotate y*270
                translate y*10
            }        
            translate x*15
        }
        union {
            box {
                <0,0,1>,<5,10,-6>
                texture {c_wall}
            }
            prism {
                2.75,6,4
                <0,0>,<0,5>,<2,2.5>,<0,0>
                texture {c_roof}
                rotate z*90
                rotate y*270
                translate y*10
                translate x*5
            }
            translate x*30
        }
    }
    union {
        //unaligned walls
        union {
            box {
                <0,0,0>,<15,8,5>
                texture {c_wall}
            }
            prism {
                0,-15,4
                <0,0>,<0,5>,<2,2.5>,<0,0>
                texture {c_roof}
                rotate z*90
                translate y*8
            }
            rotate y*135
            translate <0,0,0>
        }
        union {
            box {
                <0,0,0>,<10,8,5.5>
                texture {c_wall}
            }
            prism {
                0,-10,4
                <0,0>,<0,5.5>,<2,2.75>,<0,0>
                texture {c_roof}
                rotate z*90
                translate y*8
            }
            rotate y*125
            translate <15*cosd(-135),0,15*sind(-135)>
        }
        union {
            box {
                <0,0,0.5>,<6,8,5>
                texture {c_wall}
            }
            prism {
                0,-6,4
                <0,0.5>,<0,5>,<2,2.75>,<0,0>
                texture {c_roof}
                rotate z*90
                translate y*8
            }
            rotate y*125
            translate <15*cosd(-135)+10*cosd(-125),0,15*sind(-135)+10*sind(-125)>
        }
        union {                            
            box {
                <0,0,-0.5>,<8,8,6>
                texture {c_wall}
            }
            prism {
                0,-8,4
                <0,-0.5>,<0,6>,<2,2.75>,<0,0>
                texture {c_roof}
                rotate z*90
                translate y*8
            }
            rotate y*125
            translate <15*cosd(-135)+16*cosd(-125),0,15*sind(-135)+16*sind(-125)>
        }
        translate <0,0,1>
    }
}