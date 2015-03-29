module _circular_slot(r,l) {
  hull() {
    for (x=[-1,1]) {
      translate([x * (l / 2 - r), 0, 0]) circle(r=r, $fn=12);
    }
  }
}

module carriage_plate_2d() {
  difference() {
    polygon(points=[
      [0,0],
      [160,0],
      [160, 90],
      [110, 150],
      [50, 150],
      [0, 90]
    ]);

    for (x=[10,150]) {
      translate([x, 13, 0]) circle(r=7.14/2);
      translate([x, 77.3, 0]) circle(r=5.25/2);
    }

    for (x=[50,110], y=[75.8,130]) {
      translate([x, y, 0]) circle(r=5.25/2);
    }

    for (y=[10,120,140]) {
      translate([80, y, 0]) 
        _circular_slot(5.25/2, 40 + 5.25);
    }

    for (x=[-1,1]) {
      translate([80 + x * 75, 42.5 + 6, 0]) 
        rotate([0, 0, 90]) 
          _circular_slot(1.56, (54.5 - 42.5));

      for (y=[10+5.25/2,74.2]) {
        translate([80 + x * 50, y, 0]) circle(r=5.25/2);
      }
    }

    // note: lengths of these slots are off
    for (x=[56.43, 103.57], y=[58.73, 105.87]) {
      translate([x, y, 0]) 
        rotate([0, 0, 90]) 
          _circular_slot(2.63, 9);
    }

    // note: no nema17 mounting slots drawn in
    // note: no motor shaft hole drawn in
  }
}

module carriage_plate() {
  color("gray")
  translate([0, 3.42/2, 0]) 
  linear_extrude(height=3.42, center=true)
    carriage_plate_2d();
}

carriage_plate();