use <../shapeoko2_parts_models/endplate.scad>
use <../shapeoko2_parts_models/arduino.scad>
use <../shapeoko2_parts_models/spindle_speed_controller.scad>
use <../shapeoko2_parts_models/enclosure_connectors_board.scad>
use <../shapeoko2_parts_models/fan.scad>
use <../shapeoko2_parts_models/spindle_speed_control_pot.scad>
use <../shapeoko2_parts_models/estop.scad>
use <../shapeoko2_parts_models/short_bracket.scad>

t = 5;

module _endplate_cutouts() {
  // these are the m5 mounting holes we'll use to actually connect 
  // to the endplate (bottom)
  for (x=[10,50], y=[30]) {
    translate([x, y, 0]) {
      circle(r=5.25/2 + 0.1, center=true, $fn=36);
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
      circle(r=6.25/2, center=true, $fn=36);
    }
  }

  // hull-out for the endplate-to-extrusion screws
  hull() {
    for (x=[10:50]) {
      translate([x, 10, 0]) circle(r=6.5);
    }
  }
}

module mounting_plate_2d() {
  difference() {
    translate([220/2, 140/2, 0]) 
    hull() {
      for (x=[-1,1],y=[-1,1]) {
        translate([x * (220/2 - 3), y * (140/2 - 3), 0]) circle(r=3, $fn=12);
      }
    }

    _endplate_cutouts();

    // mounting holes for enclosure connectors board
    translate([60 + 5 + 70/2, 5 + 30/2, 0]) {
      for (x=[-1,1],y=[-1,1]) {
        translate([x * (70/2 - 3.25), y * (30/2 - 3.25), 0]) circle(r=5.2/2, $fn=24);
      }
    }

    // mounting holes for spindle speed controller
    translate([60 + 5 + 50/2, 140 - 5 - 22.5, 0]) {
      for (x=[-1,1]) {
        translate([x * (44/2), 0, 0]) circle(r=3.25 / 2, $fn=36);
      }
    }

    // mounting holes for arduino
    translate([220 - 10 - 50, 140 - 115, 0])
    rotate([180, 0, 90]) 
    scale(25.4 / 1000)
    for (xy=[[550, 100], [600, 2000], [2600, 300], [2600, 1400]]) {
      translate(xy)
        circle(r=135/2, $fn=36);
    }

    // cutout for e-stop
    translate([60 + 5 + 50 + 20, 140 - 15 - 45, 0]) {
      circle(r=24/2, $fn=72);
    }

    // spindle speed controller pot
    translate([60 + 5 + 50 + 20, 140 - 15, 0]) {
      circle(r=7.5/2, $fn=36);
    }

    // mounting holes for fan brackets
    translate([220 - 10 - 25, 140 - 25 - 21 + 4.3 + 6.35/2, 0]) {
      for (x=[-1,1]) {
        translate([x * 25, 0, 0])
          rotate([-90, 180, 0])
            circle(r=5.1/2, $fn=36);
      }
    }
  }
}

module assembly() {
  rotate([90, 0, 0]) endplate();

  translate([220 - 10 - 25, 60/2 + 5, 140 - 25/2])
    rotate([0, 0, 0])
      fan(60, 25, 50, 4.3/2);

  translate([220 - 10 - 25, -6, 140 - 25 - 21/2]) {
    for (x=[-1,1]) {
      translate([x * 25, 0, 0])
        rotate([-90, 180, 0])
          short_bracket();
    }
  }

  translate([220 - 10 - 50, 0, 140 - 115])
    rotate([90, -90, 180])
      translate([0.6 * 25.4, 2.0 * 25.4, 0])
        Arduino();

  translate([0, -6 - t/2, 0]) 
  rotate([90, 0, 0]) 
    linear_extrude(height=t, center=true) 
      !mounting_plate_2d();

  translate([60 + 5 + 50/2, -6, 140 - 75/2 - 5]) 
    rotate([-90, -90, 0]) 
      spindle_speed_controller();

  translate([60 + 5 + 70/2, 0, 40/2 + 5])
    rotate([90, 0, 180]) 
      enclosure_connectors_board();

  translate([60 + 5 + 50 + 20, -6, 140 - 15]) 
    rotate([90, 0, 0]) 
      spindle_speed_control_pot();

  translate([60 + 5 + 50 + 20, -6, 140 - 15 - 45])
    rotate([90, 90, 0])
      estop();
}


assembly();