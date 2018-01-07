#include "colors.inc"
#include "math.inc"

#declare cam = array[3]{
    camera {
        location <15,10,-70>
        look_at <-2,7,0>
    },
    camera {
        location <-10,7,40>
        look_at <4,7,0>
    },
    camera {
        location <60,15,-10>
        look_at <0,5,0>
    }
}

global_settings { ambient_light <1,1,1> }

/*
    kamery
    0 - front
    1 - tyl
    2 - z prawej
*/
camera {cam[1]}

//kolorki/tekstury
#declare c_wall = texture {
    pigment {rgb <1.000, 0.871, 0.678>}
    normal {pigment_pattern{wrinkles turbulence 0.2 scale 0.5},0.06}
}
#declare c_wall_alt = texture {pigment {rgb <1, 1, 1>}}
#declare c_roof = texture {
    pigment{
        gradient y
        color_map {
            [0.1 color rgb <0.1,0,0>]
            [0.9 color rgb <0.45,0,0>]
            //[0.9 color rgb <0.1,0,0>]
        }
        scallop_wave
        scale 0.2
    }
}
texture {
    pigment{
        gradient z
        color_map {
            [0.0 color rgbt <0,0,0,1>]
            [0.99 color rgbt <0,0,0,1>]
            [0.995 color rgbt <0,0,0,0>]
            //[0.9 color rgb <0.1,0,0>]
        }
        scallop_wave
        scale 0.4
    }
}

#declare c_roof_cone = texture {
    pigment{
        gradient y
        color_map {
            [0.1 color rgb <0.1,0,0>]
            [0.9 color rgb <0.45,0,0>]
            //[0.9 color rgb <0.1,0,0>]
        }
        scallop_wave
        scale 0.2
    }
}
/* texture {
    pigment{
        gradient z
        color_map {
            [0.0 color rgbt <0,0,0,1>]
            [0.99 color rgbt <0,0,0,1>]
            [0.995 color rgbt <0,0,0,0>]
            //[0.9 color rgb <0.1,0,0>]
        }
        scallop_wave
        scale 0.4
    }
} */

#declare c_metal = texture {
  pigment {rgb <0.1, 0.1, 0.1>}
  normal {
    dents 1.2
    scale 0.2
  }
  finish {
    reflection {
      0.1 metallic
    }
  }
}
#declare c_grass = texture {pigment {rgb <0.1, 0.1, 0.1>}}
#declare c_window = texture {
    pigment {
        rgb <0.15, 0.3, 0.4>
    }
    finish {
        diffuse 1
        reflection 0.15
    }
}
#declare c_window_alt = texture {pigment {rgb <0.09, 0.02, 0.>}}


sphere {<0,0,0>,10000 pigment {color Blue}}
light_source {
    <100,1250,-250>,
    White
}

plane {
    y, 0
    pigment {color Gray}
}

#declare window_slot_small = box {
    <0,0,0>,<1.5,1.75,-0.5>
}
#declare window_slot_big = box {
    <0,0,0>,<1.5,2.25,-0.5>
}

#declare window_fill_small = union {
    difference {
        box {
            <0,0,0>,<1.5,1.75,-0.25>
            texture {c_wall_alt}
        }
        box {
            <0.08,0.08,0.1>,<1.42,1.67,-0.35>
            texture {c_wall_alt}
        }
    }
    box {
        <0.08,0.08,0>,<1.42,2.17,-0.20>
        texture {c_window}
    }
    #for (i,0,5,1)
        box {
            <0.08,0.06+i/5*1.59,0>,<1.42,0.10+i/5*1.59,-0.24>
            texture {c_window_alt}
        }
    #end
    #for (i,0,4,1)
        box {
            #if (i=2)
                <0.02+i/4*1.34,0.08,0>,<0.14+i/4*1.34,1.67,-0.24>
            #else
                <0.06+i/4*1.34,0.08,0>,<0.1+i/4*1.34,1.67,-0.24>
            #end
            texture {c_window_alt}
        }
    #end
}
#declare window_fill_big = union {
    difference {
        box {
            <0,0,0>,<1.5,2.25,-0.25>
            texture {c_wall_alt}
        }
        box {
            <0.08,0.08,0.1>,<1.42,2.17,-0.35>
            texture {c_window_alt}
        }
    }
    box {
        <0.08,0.08,0>,<1.42,2.17,-0.23>
        texture {c_window}
    }
    #for (i,0,6,1)
        box {
            #if (i=3)
                <0.08,0.02+i/6*2.09,0>,<1.42,0.14+i/6*2.09,-0.24>
            #else
                <0.08,0.06+i/6*2.09,0>,<1.42,0.10+i/6*2.09,-0.24>
            #end
            texture {c_window_alt}
        }
    #end
    #for (i,0,4,1)
        box {
            #if (i=2)
                <0.02+i/4*1.34,0.08,0>,<0.14+i/4*1.34,2.17,-0.24>
            #else
                <0.06+i/4*1.34,0.08,0>,<0.1+i/4*1.34,2.17,-0.24>
            #end
            texture {c_window_alt}
        }
    #end
}

union {
    union {
        //random stuff behind
        difference {
            box {
                <0,0,0>,<5,10,-5>
                texture {c_wall}
            }
            object {
                window_slot_small
                translate <-2.5,7.25,0.25>
                rotate y*180
            }
            object {
                window_slot_big
                translate <-2.5,4.25,0.25>
                rotate y*180
            }
            object {
                window_slot_small
                translate <-4.5,7.25,0.25>
                rotate y*180
            }
            object {
                window_slot_big
                translate <-4.5,4.25,0.25>
                rotate y*180
            }
        }

        object {
            window_fill_small
            translate <-2.5,7.25,0.25>
            rotate y*180
        }
        object {
            window_fill_big
            translate <-2.5,4.25,0.25>
            rotate y*180
        }
        object {
            window_fill_small
            translate <-4.5,7.25,0.25>
            rotate y*180
        }
        object {
            window_fill_big
            translate <-4.5,4.25,0.25>
            rotate y*180
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
            texture {c_roof_cone}
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
            object {
                window_slot_small
                translate y*7.75
            }
            object {
                window_slot_big
                translate y*4.25
            }
            object {
                window_slot_small
                translate y*1.25
            }

        }
        #declare window_fills = union {
            object {
                window_fill_small
                translate y*7.75
            }
            object {
                window_fill_big
                translate y*4.25
            }
            object {
                window_fill_small
                translate y*1.25
            }
        }
        //end of definition hell
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
                    translate <5.5,0,-4.75>
                }
                object {
                    window_slots
                    translate <8,0,-4.75>
                }
                object {
                    window_slot_small
                    translate <-6,7.75,0.25>
                    rotate y*180
                }
                object {
                    window_slot_big
                    translate <-6,4.25,0.25>
                    rotate y*180
                }
                object {
                    window_slot_small
                    translate <-9,7.75,0.25>
                    rotate y*180
                }
                object {
                    window_slot_big
                    translate <-9,4.25,0.25>
                    rotate y*180
                }
            }
            object {
                window_fills
                translate <5.5,0,-4.75>
            }
            object {
                window_fills
                translate <8,0,-4.75>
            }
            object {
                window_fill_small
                translate <-6,7.75,0.25>
                rotate y*180
            }
            object {
                window_fill_big
                translate <-6,4.25,0.25>
                rotate y*180
            }
            object {
                window_fill_small
                translate <-9,7.75,0.25>
                rotate y*180
            }
            object {
                window_fill_big
                translate <-9,4.25,0.25>
                rotate y*180
            }
        }
        union {
            difference {
                box {
                    <0,0,1>,<5,10,-6>
                    texture {c_wall}
                }
                object {
                    window_slots
                    translate <0.5,0,-5.75>
                }
                object {
                    window_slots
                    translate <3,0,-5.75>
                }
                object {
                    window_slot_small
                    translate <-4,7.75,-0.75>
                    rotate y*180
                }
                object {
                    window_slot_big
                    translate <-4,4.25,-0.75>
                    rotate y*180
                }
            }
            object {
                window_fills
                translate <0.5,0,-5.75>
            }
            object {
                window_fills
                translate <3,0,-5.75>
            }
            object {
                window_fill_small
                translate <-4,7.75,-0.75>
                rotate y*180
            }
            object {
                window_fill_big
                translate <-4,4.25,-0.75>
                rotate y*180
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
            difference {
                box {
                    <0,0,1>,<15,10,-5.5>
                    texture {c_wall}
                }
                #for (i,0,4,1)
                    object {
                        window_slots
                        translate <0.5+3.1*i,0,-5.25>
                    }
                #end
                #for (i,0,3,1)
                    object {
                        window_slot_small
                        translate <-3-i*3.5,7.75,-0.75>
                        rotate y*180
                    }
                    #if (i!=3)
                        object {
                            window_slot_big
                            translate <-3-i*3.5,4.25,-0.75>
                            rotate y*180
                        }
                    #end
                #end
            }
            #for (i,0,4,1)
                object {
                    window_fills
                    translate <0.5+3.1*i,0,-5.25>
                }
            #end
            #for (i,0,3,1)
                object {
                    window_fill_small
                    translate <-3-i*3.5,7.75,-0.75>
                    rotate y*180
                }
                #if (i!=3)
                    object {
                        window_fill_big
                        translate <-3-i*3.5,4.25,-0.75>
                        rotate y*180
                    }
                #end
            #end
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
            difference {
                box {
                    <0,0,1>,<5,10,-6>
                    texture {c_wall}
                }
                object {
                    window_slot_small
                    translate <0.5,7.75,-5.75>
                }
                object {
                    window_slot_big
                    translate <0.5,4.25,-5.75>
                }
                object {
                    window_slot_small
                    translate <3,1.25,-5.75>
                }
                object {
                    window_slot_small
                    translate <-4.5,7.75,-4.75>
                    rotate y*270
                }
                object {
                    window_slot_big
                    translate <-4.5,4.25,-4.75>
                    rotate y*270
                }
                object {
                    window_slot_small
                    translate <-3.5,7.75,-0.75>
                    rotate y*180
                }
                object {
                    window_slot_big
                    translate <-3.5,4.25,-0.75>
                    rotate y*180
                }
            }
            object {
                window_fill_small
                translate <0.5,7.75,-5.75>
            }
            object {
                window_fill_big
                translate <0.5,4.25,-5.75>
            }
            object {
                window_fill_small
                translate <3,1.25,-5.75>
            }
            object {
                window_fill_small
                translate <-4.5,7.75,-4.75>
                rotate y*270
            }
            object {
                window_fill_big
                translate <-4.5,4.25,-4.75>
                rotate y*270
            }
            object {
                window_fill_small
                translate <-3.5,7.75,-0.75>
                rotate y*180
            }
            object {
                window_fill_big
                translate <-3.5,4.25,-0.75>
                rotate y*180
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
        #declare window_slots = union {
            object {
                window_slot_big
                translate y*4.25
            }
            object {
                window_slot_small
                translate y*1.25
            }

        }
        #declare window_fills = union {
            object {
                window_fill_big
                translate y*4.25
            }
            object {
                window_fill_small
                translate y*1.25
            }
        }
        //unaligned walls
        union {
            difference {
                box {
                    <0.35,0,0>,<15,8,5>
                    texture {c_wall}
                }
                #for (i,0,2,1)
                    object {
                        window_slots
                        rotate y*180
                        translate <7.5+i*1.75,0,4.75>
                    }
                #end
                object {
                    window_slots
                    rotate y*180
                    translate <13.75,0,4.75>
                }
            }
            prism {
                0,-15,4
                <0,0>,<0,5>,<2,2.5>,<0,0>
                texture {c_roof}
                rotate z*90
                translate y*8
            }
            #for (i,0,2,1)
                object {
                    window_fills
                    rotate y*180
                    translate <7.5+i*1.75,0,4.75>
                }
            #end
            object {
                window_fills
                rotate y*180
                translate <13.75,0,4.75>
            }
            rotate y*135
            translate <0,0,0>
        }
        union {
            difference {
                box {
                    <0,0,0>,<10,8,5.5>
                    texture {c_wall}
                }
                object {
                    window_slot_big
                    rotate y*180
                    translate <4.125,4.25,5.25>
                }
                object {
                    window_slot_big
                    rotate y*180
                    translate <1.74,4.25,5.25>
                }
                #for (i,0,2,1)
                    object {
                        window_slots
                        rotate y*180
                        translate <6.5+i*1.75,0,5.25>
                    }
                #end
            }
            object {
                window_fill_big
                rotate y*180
                translate <4.125,4.25,5.25>
            }
            object {
                window_fill_big
                rotate y*180
                translate <1.74,4.25,5.25>
            }
            #for (i,0,2,1)
                object {
                    window_fills
                    rotate y*180
                    translate <6.5+i*1.75,0,5.25>
                }
            #end
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
            difference {
                box {
                    <0,0,0.5>,<6,8,5>
                    texture {c_wall}
                }
                object {
                    window_slots
                    rotate y*180
                    translate <2.25,0,4.75>
                }
                object {
                    window_slot_big
                    rotate y*180
                    translate <4.5,4.25,4.75>
                }
            }
            object {
                window_fills
                rotate y*180
                translate <2.25,0,4.75>
            }
            object {
                window_fill_big
                rotate y*180
                translate <4.5,4.25,4.75>
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
            difference {
                box {
                    <0,0,-0.5>,<8,8,6>
                    texture {c_wall}
                }
                #for (i,0,2,1)
                    object {
                        window_slots
                        rotate y*180
                        translate <2.75+i*2,0,5.75>
                    }
                #end
            }
            #for (i,0,2,1)
                object {
                    window_fills
                    rotate y*180
                    translate <2.75+i*2,0,5.75>
                }
            #end
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
