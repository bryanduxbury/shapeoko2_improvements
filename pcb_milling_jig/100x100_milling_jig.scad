// todo:
// two origin alignment points to the bottom right / bottom left to represent precise distance away from selected edge. allows repositioning of toolhead after flip so that same initial corner is being referenced.

insert_spacing_v = 75;
insert_spacing_h = 500 - 2 * (60 + insert_spacing_v);

insert_bore = 10;

hold_down_bore = 6.5;

gutter = 10;

corner_relief_r = 5;

w = insert_spacing_h + 2 * gutter;
h = insert_spacing_v * 3 + 2 * gutter;


module jig_base() {
  difference() {
    hull() {
      for (x = [-1,1], y=[-1,1]) {
        translate([x * (w / 2 - gutter/2), y * (h / 2 - gutter/2), 0]) 
          circle(r=gutter/2, $fn=36);
      }
    }

    union() {
      square(size=[103, 103], center=true);
      for (a=[0:3]) {
        rotate([0, 0, a * 90]) translate([50, 50, 0]) circle(r=corner_relief_r, $fn=36);
      }
    }

    for (x = [-1,1], y=[-1,1]) {
      translate([x * insert_spacing_h / 2, y * (insert_spacing_v * 3 / 2), 0]) 
        circle(r=hold_down_bore/2, $fn=36);
    }

    for (x = [-1:1], y=[-1:1]) {
      if (! (x==0 && y==0)) {
        translate([x * (100 / 2 + 5 + insert_bore/2), y * (100 / 2 + 5 + insert_bore/2), 0]) 
        circle(r=insert_bore/2, $fn=36);
      }
    }

    translate([-103/2 - 25, -103/2 - 25, 0]) 
      circle(r=0.125 / 2 * 25.4, $fn=36);
    translate([103/2 + 25, -103/2 - 25, 0]) 
      circle(r=0.125 / 2 * 25.4, $fn=36);

    translate([-w/2 + 25, -h/2 + 25 + 5, 0]) square(size=[0.5, 10], center=true);
    translate([-w/2 + 25 + 5, -h/2 + 25, 0]) square(size=[10, 0.5], center=true);
  }
}

module clamp_frame() {
  difference() {
    hull() {
      for (x = [-1,1], y=[-1,1]) {
        translate([x * (103 / 2 + 5 + insert_bore), y * (103 / 2 + 5 + insert_bore)]) 
          circle(r=gutter/2, $fn=36);
      }
    }
    hull() for (x = [-1,1], y=[-1,1]) {
      translate([x * (100 / 2 - gutter/2), y * (100/2 - gutter/2)]) 
        circle(r=gutter/2, $fn=36);
    }

    for (x = [-1:1], y=[-1:1]) {
      if (! (x==0 && y==0)) {
        translate([x * (100 / 2 + 5 + insert_bore/2), y * (100 / 2 + 5 + insert_bore/2), 0]) 
        circle(r=7/2, $fn=36);
      }
    }
  }
}

// difference() {
  // square(size=[11.6 * 25.4, 11.6 * 25.4], center=true);
  color("pink") linear_extrude(height=19) jig_base();
// }

translate([0, 0, 19]) linear_extrude(height=5) !clamp_frame();
