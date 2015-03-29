// TODOs
// fix issue with top endplate anchoring holes overshooting endplate

use <../shapeoko2_parts_models/endplate.scad>
use <../shapeoko2_parts_models/arduino.scad>
use <../shapeoko2_parts_models/spindle_speed_controller.scad>
use <../shapeoko2_parts_models/enclosure_connectors_board.scad>
use <../shapeoko2_parts_models/fan.scad>
use <../shapeoko2_parts_models/spindle_speed_control_pot.scad>
use <../shapeoko2_parts_models/estop.scad>
use <../shapeoko2_parts_models/short_bracket.scad>

t = 5;

w = 240;
h = 200;

module _cable_guide(cable_width=6, hole_w=3.5, ziptipe_w=3) {
  d = max(hole_w, ziptipe_w);
  for (side=[-1,1]) {
    hull()
    for (x=[-1,1]) {
      translate([x * (d/2), side * (cable_width/2 + hole_w/2), 0]) circle(r=hole_w/2, $fn=36);
    }
  }
}

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
      circle(r=6.75/2, center=true, $fn=36);
    }
  }

  // hull-out for the endplate-to-extrusion screws
  hull() {
    for (x=[10:50]) {
      translate([x, 10, 0]) circle(r=6.5);
    }
  }
}

module _24v_breakout() {
  color("green")
  difference() {
    translate([0, -25.4/2 + 4.5, 0]) 
      cube(size=[25.4, 25.4, 1.6], center=true);
    cylinder(r=3/2, h=25, center=true, $fn=36);
  }
}

module mounting_plate_2d() {
  difference() {
    translate([w/2, h/2, 0]) 
    hull() {
      for (x=[-1,1],y=[-1,1]) {
        translate([x * (w/2 - 3), y * (h/2 - 3), 0]) circle(r=3, $fn=12);
      }
    }

    _endplate_cutouts();

    // mounting holes for enclosure connectors board
    translate([60 + 25 + 70/2, 35 + 30/2, 0]) {
      for (x=[-1,1],y=[-1,1]) {
        translate([x * (70/2 - 3.25), y * (30/2 - 3.25), 0]) circle(r=5.2/2, $fn=24);
      }

      // cable guides for stepper bundles near connector board
      for (x=[-20, -10, 0, 10, 20]) {
        translate([x, 40, 0]) rotate([0, 0, 90]) _cable_guide();
      }
    }

    // mounting holes for spindle speed controller
    translate([60 + 5 + 20 + 16 + 50/2, h - 5 - 22.5, 0]) {
      for (x=[-1,1]) {
        translate([x * (44/2), 0, 0])
        hull()
        for (x2=[-1,1]) {
          translate([x2*1.5, 0, 0]) 
            circle(r=3.25 / 2, $fn=36);
        }
      }
    }

    // mounting holes for arduino
    translate([w - 10 - 50, h - 115, 0])
    rotate([180, 0, 90]) 
    scale(25.4 / 1000)
    for (xy=[[550, 100], [600, 2000], [2600, 300], [2600, 1400]]) {
      translate(xy)
        circle(r=135/2, $fn=36);
    }

    // cable guide for USB cable
    translate([w-21.5, h - 115 - 30, 0]) rotate([0, 0, 90]) _cable_guide();
    translate([w-10, h - 115 - 50, 0]) _cable_guide();

    // cutout for e-stop
    translate([60 / 2, h - 35, 0]) {
      circle(r=24/2, $fn=72);

      translate([25, 0, 0]) _cable_guide();
    }

    // vertical cable guides alongside endplate
    for (y=[h-50, h-100, h-170]) {
      translate([70, y, 0]) rotate([0, 0, 90]) _cable_guide();
    }

    // horizontal cable guides along the bottom
    for (x=[85, 135, 185]) {
      translate([x, 15, 0]) _cable_guide();
    }

    // spindle speed controller pot
    translate([60 + 5 + 20, h - 35, 0]) {
      circle(r=7.5/2, $fn=36);
    }

    // mounting holes for fan brackets
    translate([w - 10 - 25, h - 25 - 21 + 4.3 + 6.35/2, 0]) {
      for (x=[-1,1]) {
        translate([x * 25, 0, 0])
          circle(r=5.1/2, $fn=36);
      }
    }

    // mounting hole for 24v breakount board
    translate([w - 60, h - 115 - 20, 0]) circle(r=3.2/2, $fn=36);

    // cable guides for stepper bundles near shield
    for (y=[h-60, h-70, h-80, h-90, h-100]) {
      translate([w - 75, y, 0]) _cable_guide();
    }

    // screw slot for far corner bracket
    hull()
    for (y=[-1,1]) {
      translate([w-10, 12.5 + y * (5/2), 0]) circle(r=5.1/2, $fn=36);
    }
  }
}

module assembly() {
  rotate([90, 0, 0]) endplate();

  translate([w - 10 - 25, 60/2 + 5, h - 25/2])
    rotate([0, 0, 0])
      fan(60, 25, 50, 4.3/2);

  translate([w - 10 - 25, -6, h - 25 - 21/2]) {
    for (x=[-1,1]) {
      translate([x * 25, 0, 0])
        rotate([-90, 180, 0])
          short_bracket();
    }
  }

  translate([w - 10 - 50, 0, h - 115])
    rotate([90, -90, 180])
      translate([0.6 * 25.4, 2.0 * 25.4, 0])
        Arduino();

  translate([0, -6 - t/2, 0]) 
  rotate([90, 0, 0]) 
    linear_extrude(height=t, center=true) 
      !mounting_plate_2d();


  translate([60 + 25 + 70/2, 0, 40/2 + 35])
    rotate([90, 0, 180]) 
      enclosure_connectors_board();

  translate([60 + 5 + 20 + 16 + 50/2, -6, h - 75/2 - 5])
    rotate([-90, -90, 0])
      spindle_speed_controller();

  translate([60 + 5 + 20, -6, h - 35]) 
    rotate([90, 0, 0]) 
      spindle_speed_control_pot();

  translate([60/2, -6, h - 35])
    rotate([90, 90, 0])
      estop();

  translate([w - 60, 0, h - 115 - 20])
    rotate([90, 0, 0])
      _24v_breakout();

  translate([w - 10, 0, 10])
    rotate([-90, 0, 0])
      short_bracket();
}


assembly();