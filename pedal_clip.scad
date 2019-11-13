// Super-basic first version, learning openscad...
echo(version=version());

pedal_width = 38.0;

base_thickness = 1;
wall_thickness = 2;

base_width = pedal_width;
base_depth = 50;

wall_height = 15;

side_width = 8;
hole_width = 5;
hole_depth = 2;

hole_trim_x = (side_width - hole_width) / 2;

module logo() {
  translate([base_width/2, 0.5, 8]) {
    rotate([90, 0, 0]) {
      linear_extrude(1) {
        scale(0.6) {
          import("audiolegend.svg", center=true);
        }
      }
    }
  }
}

module hex() {
  scale(0.75) {
    rotate(a=90, v=[0, 0, 1]) {
      linear_extrude(2) {
        polygon(points=[[2,0], [1, 1.732], [-1,1.732], [-2,0], [-1,-1.732], [1,-1.732]]);
      }

    }
  }
}
// Bottom plate
difference() {
  cube([base_width, base_depth, base_thickness], center=false);

  hex_spacing = 4;
  for (i = [0:10]) {
    translate([i * hex_spacing, 0, 0])
      for (j = [0:15]) {
        translate([j % 2 * (hex_spacing / 2), j * hex_spacing, 0]) {
          hex();
        }
      }
  }

}

// Front plate
difference() {
  cube([base_width, wall_thickness, wall_height], center=false);
  logo();
}

module hole() {
  cube([hole_width, hole_depth, base_thickness]);
}

module side(){
  translate([base_width / 2, 0, 0]){
    translate([wall_thickness, 0, 0]) {
      difference() {
        cube([side_width, base_depth, base_thickness]);
        translate([hole_trim_x, hole_depth, ,0]) {
          hole();
        }
        translate([hole_trim_x, base_depth - hole_depth * 2, ,0]) {
          hole();
        }
        translate([42, base_depth / 2, 0]) {
          cylinder(base_thickness, 40, 40);
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
