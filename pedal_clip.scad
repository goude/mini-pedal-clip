// Super-basic first version, learning openscad...
echo(version=version());

pedal_width = 38.0;

base_thickness = 1.0;
wall_thickness = 2.0;

base_width = pedal_width;
base_depth = 31.0;

wall_height = 15;

side_width = 9.0;
hole_width = 5.0;
hole_depth = 2.0;

hole_trim_x = (side_width - hole_width) / 2;

module logo() {
  translate([base_width/2, 0.5, 7.5]) {
    rotate([90, 0, 0]) {
      linear_extrude(1) {
        scale(0.6) {
          import("audiolegend.svg", center=true);
        }
      }
    }
  }
}

module pill() {
  pill_height = wall_height - 5.0;
  pill_width = 1;
  translate([0, pill_width * 3, pill_height/2 + pill_width * 3]) {
    rotate(90, [0, 0, 1]) {
      rotate(90, [1, 0, 0]) {
        linear_extrude(wall_thickness) {
          translate([0, pill_height/2, 0]) circle(d=pill_width, $fn=10);
          square([pill_width, pill_height], center=true);
          translate([0, -pill_height/2, 0]) circle(d=pill_width, $fn=10);
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
        translate([0, -hole_depth * 2, 0]) {
          cube([side_width, base_depth + hole_depth * 4, base_thickness]);
        }
        translate([hole_trim_x, -hole_depth, 0]) {
          hole();
        }
        translate([hole_trim_x, base_depth, ,0]) {
          hole();
        }
        circle_factor = 0.4;
        translate([base_depth * circle_factor + 2, base_depth / 2, 0]) {
          linear_extrude(base_thickness) {
            circle(r=base_depth * circle_factor, $fa=1, $fs=1);
          }
        }
      }
    }
    difference() {

      cube([wall_thickness, base_depth, wall_height], center=false);
      for (i = [0:8]) {
        translate([0, i*3, 0]) {
          pill();
        }
      }
    }
  }
}

translate([base_width/2, 0, 0]) {
  side();
  mirror([1, 0, 0]) side();
}
