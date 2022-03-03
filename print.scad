
include <config.scad>;
use <Heizring-Adapter.scad>;

translate([0, 0, adapter_height])
rotate([180, 0, 0])
Adapter();
