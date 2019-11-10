// Super-basic first version, learning openscad...
echo(version=version());

pedal_width = 38.0;

base_thickness = 1;
wall_thickness = 2;

base_width = pedal_width;
base_depth = 50;

wall_height = 30;

side_width = 8;
hole_width = 5;
hole_depth = 2;

cube([base_width, base_depth, base_thickness], center=false);
cube([base_width, base_thickness, wall_height / 2], center=false);

module side(){
    translate([base_width / 2, 0, 0]){
        translate([wall_thickness, 0, 0]) {
            difference() {
                cube([side_width, base_depth, base_thickness]);
                translate([(side_width - hole_width)/2, hole_depth, ,0]) {
                    cube([hole_width, hole_depth, base_thickness]);
                }
                translate([(side_width - hole_width)/2, base_depth - hole_depth * 2, ,0]) {
                    cube([hole_width, hole_depth, base_thickness]);
                }
            }
        }
        cube([wall_thickness, base_depth, wall_height], center=false);
    }
}

translate([base_width/2, 0, 0]) {
    side();
    mirror([1, 0, 0]) side();
}
