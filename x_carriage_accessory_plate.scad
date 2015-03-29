use <shapeoko2_parts_models/carriage_plate.scad>

module _rounded_rect(w, h, r) {
  hull() {
    for (x=[-1,1], y=[-1,1]) {
      translate([x * (w/2 - r), y * (h/2 - r), 0]) {
        circle(r=r, $fn=144);
      }
    }
  }
}

translate([0, 3.42/2, 0]) rotate([90, 0, 0]) carriage_plate();

module accessory_plate_2d() {
  difference() {
    translate([160/2, 100/2, 0])
      _rounded_rect(160,100, 25);
      // square(size=[160, 100], center=true);

    // vert zipties
    for (x=[-1,1], y=[0, 10]) {
      translate([80 + x * 20, 80 + y, 0]) 
        circle(r=4/2, $fn=36);
    }

    // horz zipties
    for (x1=[-1,1], x2=[0,10], y=[-1,1]) {
      translate([80 + x1 * 30 + x1 * x2, 60 + y * 20, 0]) 
        circle(r=4/2, $fn=36);
    }

    // mounting holes
    for (x1=[-1,1], y=[6.5, 26.5]) {
      translate([80 + x1 * 40/2, y, 0]) circle(r=5.25/2, $fn=72);
    }

    //clearance for frame screwheads
    for (x=[-1,1]) {
      translate([80 + x * 30, 16.5, 0]) circle(r=10/2, $fn=36);
    }

    for (x=[-1,1]) {
      translate([80 + x * 60, 50, 0]) {
        rotate([0, 0, 90]) _circular_slot(4/2, 40);
      }
    }
  }
}

translate([0, 0, 115]) 
  rotate([90, 0, 0]) 
  linear_extrude(height=5)
    !accessory_plate_2d();
    

translate([80, 1.5 * 25.4 / 2, 175]) 
color("white") {
  translate([0, 0, 85/2]) 
    cylinder(r=33.3 / 2, h=85, center=true);
  rotate([0, 90, 0])
    cylinder(r=33.3 / 2, h=92, center=true);
}
