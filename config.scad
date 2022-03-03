
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
adapter_d_inner = wall_d_outer + 0.5;
adapter_d_outer = adapter_d_inner + 2*adapter_thickness;
adapter_height = wall_height - con_height + adapter_thickness;

// Finger
hole_d = 2.5;
finger_width = 2*adapter_thickness + hole_d;
// Uber die Innenkante hinaus verlaengern
finger_extend = 10;
// In den aeusseren Ring integrieren
finger_merge = adapter_thickness/2;
finger_length = wall_d_outer/2 - wall_d_inner/2 + finger_extend;
