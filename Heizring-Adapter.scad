
include <config.scad>;

module Heizring() {
    color([0.2, 0.2, 0.2, 0.8]) {
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
    color([0.3, 0.8, 1, 0.8])
    for (rot_angle = [0:180:180]) {
        rotate(rot_angle)
        translate([
            0,
            con_depth/2 + wall_d_outer/2 - con_wall_merge,
            con_height/2+base_height - nothing
        ])
        cube([con_width, con_depth, con_height], center=true);
        }
}

module Schaale() {
    color([1, 1, 1, 0.4])
    difference() {
        cylinder(
            r = plate_d_outer/2,
            h = plate_height,
            center = false
        );
        translate([0, 0, plate_thickness+nothing])
        cylinder(
            r = plate_d_inner/2,
            h = plate_height - plate_thickness,
            center = false
        );
    }
}

module Adapter() {
    color([0.9, 0.9, 0.1, 0.8]) {
        difference() {
            // Kappe
            cylinder(
                r = adapter_d_outer/2,
                h = adapter_height,
                center = false
            );

            // Aussparung
            translate([0, 0, -nothing])
            cylinder(
                r = adapter_d_inner/2,
                h = adapter_height + 2*nothing,
                center = false
            );

            // Rand vertiefen
            angle_opening = 30;
            for (a = [angle_opening/2:1:180-angle_opening/2]) {
                rotate([
                    0,
                    0,
                    a
                    ])
                translate([
                    - adapter_d_outer/2 - nothing,
                    -1.5,
                    adapter_height - adapter_thickness
                    ])
                cube([
                    adapter_d_outer + 2*nothing,
                    3,
                    adapter_height
                    ]);
            }

            // Oeffnung auf der anderen Seite auch wegschneiden
            translate([
                0,
                - adapter_d_outer/2 - nothing,
                adapter_height - adapter_thickness
                ])
            cube([
                adapter_d_outer/2 + nothing,
                adapter_d_outer + 2*nothing,
                adapter_height
                ]);
        }

        // Finger
        translate([
            -wall_d_outer/2 + finger_length/2,
            0,
            adapter_height
            ])
        union() {
            // Basis
            difference() {
                union() {
                    // Block
                    translate([
                        - finger_length/2 - finger_merge,
                        - finger_width/2,
                        - adapter_thickness + nothing
                        ])
                    cube([
                        finger_length + finger_merge - finger_width/2 + nothing,
                        finger_width,
                        adapter_thickness
                        ]);

                    // Abgerundetes Ende
                    translate([
                        finger_length/2 - adapter_thickness - hole_d/2,
                        0,
                        - adapter_thickness
                        ])
                    cylinder(
                        r = finger_width/2,
                        h = adapter_thickness,
                        center = false
                        );
                }

                // Loch
                translate([
                    finger_length/2 - adapter_thickness - hole_d/2,
                    0,
                    - adapter_thickness - nothing
                    ])
                cylinder(
                    r = hole_d/2,
                    h = adapter_thickness + 4*nothing,
                    center = false
                    );
            }

            // Kabelfuehrung
            // TODO
        }
    }
}


Heizring();
translate([0, 0, base_height+2*nothing])
Schaale();
translate([0, 0, base_height + con_height])
Adapter();
