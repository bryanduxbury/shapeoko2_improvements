use <arduino.scad>

module _endplate() {
  translate([0, 0, -3.42/2]) 
  color("black")
  difference() {
    hull() {
      for (x=[2.5,60-2.5],y=[2.5,140-2.5]) {
        translate([x, y, 0]) cylinder(r=2.5, h=3.42, center=true);
      }
    }

    for (x=[10,50], y=[10,30]) {
      translate([x, y, 0]) {
        cylinder(r=5.25/2, h=10, center=true);
      }
    }
    
    for (x=[10,30,50]) {
      translate([x, 65, 0]) {
        cylinder(r=2.625, h=10, center=true);
        translate([0, 12.5, 0]) 
          cube(size=[2 * 2.625, 25, 10], center=true);
        translate([0, 25, 0])
          cylinder(r=2.625, h=10, center=true);
      }
    }
    
    translate([30, 101.5, 0]) 
      cube(size=[14, 3, 10], center=true);
      
    translate([30, 116, 0]) 
      cylinder(r=5.25/2, h=10, center=true);
      
    for (x=[10, 50-5.25]) {
      translate([x, 127.38 + 5.25/2, 0]) {
        hull() {
          cylinder(r=5.25/2, h=10, center=true);
          translate([5.25, 0, 0]) 
            cylinder(r=5.25/2, h=10, center=true);
        }
      }
    }
  }
}

module mounting_plate_2d() {
  difference() {
    square(size=[150, 140], center=true);
    translate([15, -70, 0]) {
      // cutout for endplate bottom mounting screws
      translate([60, 0, 0]) square(size=[120, 40], center=true);

      // these are the m5 mounting holes we'll use to actually connect 
      // to the endplate (bottom)
      for (x=[10,50], y=[30]) {
        translate([x, y, 0]) {
          circle(r=5.25/2, center=true);
        }
      }

      // big hull-out for access to the makerslide slots and other 
      // mounting holes
      hull() {
        for (x=[10,30,50]) {
          translate([x, 65, 0]) {
            hull() {
              for (y=[0:1]) {
                translate([0, y * 25, 0])
                  circle(r=2.625*2.5, center=true);
              }
            }
          }
        }

        translate([30, 116, 0]) 
          circle(r=5.25, center=true);
      }

      // these are the m5 mounting holes we'll use to actually connect 
      // to the endplate (top)
      for (x=[10, 50]) {
        translate([x, 127.38 + 5.25/2, 0]) {
          circle(r=5.25/2, center=true);
        }
      }
    }

    // cut out for stepper cables / spindle cables
    hull() {
      for (x=[-45, -25]) {
        translate([x, -45, 0]) circle(r=6.5);
      }
    }

    // ziptie holes for individual stepper cables
    for (x1=[-55, -35, -15]) {
      for (x2=[-1,1]) {
        translate([x1 + x2 * 3, -30, 0]) circle(r=1.75, $fn=12);
      }
    }

    // ziptie holes for motor power connector/cord
    for (x=[0, 12], y=[-1,1]) {
      translate([-75 + 10 + x, 60 + y * 3, 0]) circle(r=1.75, $fn=12);
    }

    // mounting holes for arduino
    translate([-70, 0, 0]) 
    scale(25.4 / 1000)
    for (xy=[[550, 0], [600, 1900], [2600, 200], [2600, 1325]]) {
      translate(xy) 
      circle(r=125/2, $fn=12);
    }
    
  }
}

rotate([90, 0, 0]) {
  _endplate();

  translate([-85, 55, 15]) 
    rotate([0, 0, 0]) 
      translate([0.60 * 25.4, 2.5 * 25.4, 0]) 
        Arduino();

  translate([-15, 70, 7.5]) 
    linear_extrude(height=3, center=true) 
      mounting_plate_2d();
  }

