
$fn = 500;
nothing = 0.01;

module Heizring() {
    // Basisplatte
    base_height = 2;
    base_diameter = 80;

    // Guckloch
    hole_diameter = 6;

    // Wand
    wall_height = 12;
    wall_d_inner = 40.4;
    wall_d_outer = 63.5;

    // Kabelanschluesse
    con_width = 5;
    con_depth = 10;
    con_height = 7;
    con_wall_merge = 0.5;

    color("grey") {
        // Basisplatte
        difference() {
            cylinder(
                h=base_height,
                r=base_diameter/2,
                center=false
            );
            // Guckloch
            translate([0, 0, -nothing])
            cylinder(
                r = hole_diameter,
                h = base_height + 2*nothing,
                center = false
            );
        }

        // Wand
        translate([0, 0, base_height-nothing])
        difference() {
            cylinder(
                h=wall_height,
                r=wall_d_outer/2,
                center=false
            );
            translate([0, 0, -nothing])
            cylinder(
                h=wall_height + 2*nothing,
                r=wall_d_inner/2,
                center=false
            );
        }
    }
    
    // Kabelanschluesse
    color("cyan")
    for (rot_angle = [0:180:180]) {
        rotate(rot_angle)
        translate([
            0,
            con_depth/2 + wall_d_outer/2 - con_wall_merge,
            con_height/2+base_height
        ])
        cube([con_width, con_depth, con_height], center=true);
        }
}

Heizring();
