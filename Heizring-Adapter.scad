
// Render-Optionen
$fn = 500;
nothing = 0.01;

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

// Schale
plate_height = wall_height;
plate_d_outer = 33.2;
plate_thickness = 1.4;
plate_d_inner = plate_d_outer - plate_thickness;

// Adapterring
adapter_thickness = 2;
adapter_height = wall_height - con_height + adapter_thickness;

// Finger
finger_width = 6;
hole_d = 2;
// Uber die Innenkante hinaus verlaengern
finger_extend = 10;
// In den aeusseren Ring integrieren
finger_merge = adapter_thickness/2;
finger_length = wall_d_outer/2 - wall_d_inner/2 + finger_extend;


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
                r = wall_d_outer/2 + adapter_thickness,
                h = adapter_height,
                center = false
            );
            translate([0, 0, -nothing]) {
                 // Aussparung
                cylinder(
                    r = wall_d_outer/2,
                    h = adapter_height + 2*nothing,
                    center = false
                );
            }
        }

        // Finger
        translate([
            -wall_d_outer/2 + finger_length/2,
            0,
            adapter_height
            ])
        difference() {
            translate([
                - finger_length/2 - finger_merge,
                - finger_width/2,
                - adapter_thickness + nothing
                ])
            cube([
                finger_length + finger_merge,
                finger_width,
                adapter_thickness
                ]);
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
    }
}


Heizring();
translate([0, 0, base_height+2*nothing])
Schaale();
translate([0, 0, base_height + con_height])
Adapter();
