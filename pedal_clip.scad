// Super-basic first version, learning openscad...
echo(version=version());

thickness = 1;

base_width = 38 + thickness;
base_depth = 10;

wall_height = 30;

cube([base_width, base_depth, thickness], center=false);

cube([thickness, base_depth, wall_height], center=false);
translate([base_width, 0, 0]) {
    cube([thickness, base_depth, wall_height], center=false);
}

cube([base_width, thickness, wall_height / 2], center=false);

/*
translate([0,0,0]) {
    union() {
        cube(15, center=true);
    }
}

color("green")
    translate([-30, 0, 0])
        linear_extrude(height = 20, scale = 0.2)
            square([20, 10], center = true);


translate([-24,0,0]) {
    union() {
        cube(15, center=true);
        sphere(10);
    }
}

intersection() {
    cube(15, center=true);
    sphere(10);
}

translate([24,0,0]) {
    difference() {
        cube(15, center=true);
        sphere(10);
    }
}
*/
