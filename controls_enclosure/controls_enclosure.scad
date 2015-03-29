// TODO:
// - measure hinges
// - mounting holes for control panel hinges
// - cut-out and mounting holes for usb bulkhead
// - connection point for anchor
// - measure all control panel items and cutouts
// - cutouts for all control panel items
// - hanging tabs with captive nuts for control panel screw-down
// - corner relief on all tenons
// - corner relief on all mortises
// - spacer "ring" for external connectors board
// - measure led holders
// - adjust spindle speed controller mounting holes (they were too far apart in the single-panel design)

use <external_parts.scad>
use <arduino.scad>
use <../shapeoko2_parts_models/endplate.scad>
use <../shapeoko2_parts_models/arduino.scad>
use <../shapeoko2_parts_models/spindle_speed_controller.scad>
use <../shapeoko2_parts_models/enclosure_connectors_board.scad>
use <../shapeoko2_parts_models/fan.scad>
use <../shapeoko2_parts_models/spindle_speed_control_pot.scad>
use <../shapeoko2_parts_models/estop.scad>
use <../shapeoko2_parts_models/short_bracket.scad>

t = 5.2;

// min cutting tool diameter
k = 0.125 * 25.4;

// tab/slot size
s = 10;

w = 250;
h = 200;
d = 250;

// margin size
m = 60;

fan_mount_hole_d = 50;

module _e() {
  linear_extrude(height=t, center=true) {
    children(0);
  }
}

// module _tenon(depth, width, corner_relief_r) {
//   union()
// }

module control_panel_assembly() {
  assign(a = d - m - t/2)
  assign(b = h - m - t/2)
  assign(c = sqrt(a * a + b * b))
  assign(wp = w - 2*t)
  assign(hp = c) {
    color("white")
    _e() control_panel_2d();

    translate([w/2 - 40, hp / 2 - 60, 0]) estop();


    translate([-wp/2 + 20, hp/2 - 60, 0]) spindle_speed_control_pot();

    // spindle enabled
    translate([-wp/2 + 20 + 20, hp/2 - 60 + 20, 0]) led_holder();
    // spindle engaged
    translate([-wp/2 + 20 + 40, hp/2 - 60 + 20, 0]) led_holder();
    // spindle enable
    translate([-wp/2 + 20 + 30, hp/2 - 60, 7 - t]) toggle_switch();

    // manual spindle speed control mode
    translate([-wp/2 + 15, hp/2 - 80, 7 - t]) led_holder();
    // auto spindle speed control mode
    translate([-wp/2 + 45, hp/2 - 80, 7 - t]) led_holder();
    // spindle speed mode selector toggle
    translate([-wp/2 + 20 + 10, hp/2 - 80, 7 - t]) rotate([0, 0, 90]) 
      toggle_switch();

    // motors engaged indicator
    translate([0, hp/2 - 60 + 20, 0]) led_holder();
    // motor enable/disable switch
    translate([0, hp/2 - 60, 7 - t]) toggle_switch();

    // jog d-pad
    translate([wp/2 - 75, -hp/2 + 30 + 40, 0]) {
      for (i=[[0, 1], [-1, 0], [0, -1], [1, 0]]) {
        translate([i[0] * 20, i[1] * 20, 0]) square_momentary();
      }

      translate([45, 0, 0]) {
        for (y=[-1,1]) {
          translate([0, y * 15, 0]) square_momentary();
        }
      }
    }

    // leftmost control buttons
    translate([-wp/2 + 20, -hp/2 + 30, 0]) {
      for (y=[0:3]) {
        translate([0, y * 20, 0]) square_momentary();
      }
    }

    // right control buttons
    translate([-wp/2 + 75, -hp/2 + 30 + 20, 0]) {
      for (y=[0:2]) {
        translate([0, y * 20, 0]) square_momentary();
      }
    }
  }
}

module control_panel_2d() {
  assign(a = d - m - t/2)
  assign(b = h - m - t/2)
  assign(c = sqrt(a * a + b * b))
  square(size=[w - 2 * t, c], center=true);
}

module electronics_assembly() {
  rotate([0, -90, 90])
  translate([600/1000 * 25.4, -100/1000 * 25.4, 0])
  Arduino(false, false, false);

  // connector board
  color("green", 0.5)
  translate([2.1 * 25.4 - 50, -15, 2.7 * 25.4 - 40])
  cube(size=[100, 1.6, 80], center=true);

  // stepper board
  color("green", 0.5)
  translate([2.1 * 25.4 - 30, -30, 2.7 * 25.4 - 40 + 10])
  cube(size=[60, 1.6, 80], center=true);
}



module back_2d() {
  assign(bw = w - 2 * t)
  difference() {
    union() {
      translate([0, -t * 3/4, 0]) 
      square(size=[bw, h - t - t/2], center=true);

      for (x=[-1,1], y=[-1:1]) {
        translate([x * (bw / 2), y * (h / 3), 0]) 
        square(size=[2*t, s], center=true);
      }

      for (x=[-1:1]) {
        translate([x * (bw / 3), h/2 - t - t/2, 0]) 
        square(size=[2*t, s], center=true);
      }
    }

    // arduino hole pattern
    translate([0, h/2 - t - 10 - 10 - 2.7*25.4, 0]) 
    scale(25.4 / 1000)
    for (xy=[[100, 600], [2000, 550], [700, 2600], [1800, 2600]]) {
      translate(xy) 
      circle(r=125/2, $fn=36);
    }

    // bottom tabs
    translate([0, -h/2 + t, 0]) 
    for (x=[-1:1]) {
      translate([x * bw / 3, 0, 0]) 
      square(size=[s, t], center=true);
    }

    // cutout for ac connector
    translate([w/2 - 2 * t - 31.25/2, -h/2 + 1.5*t + 24/2 + t, 0]) 
      square(size=[26.75, 19.95], center=true);

    // spindle speed controller mounting and venting
    translate([-w/2 + t + t/2 + 50/2 + 5, h/2 - 75/2 - t - 5, 0]) {
      translate([0, 0.5 * 25.4 + 1.5, 0]) 
      for (x=[-1,1]) {
        translate([x * (44/2), 0, 0]) circle(r=1.5, $fn=12);
      }

      for (x=[-3:3]) {
        hull() {
          for (y=[-1,1]) {
            translate([x * 2 * (45 / 15), y * 70/2, 0]) 
            circle(r=k/2 + 0.1, $fn=12);
          }
        }
      }
    }

    // motors, limits, and spindle connector board
    translate([-w/2 + t + 5 + 70/2, -h/2 + t / 2 + t + 5 + 40/2 - 40/2 + 30/2,0]) {
      translate([1.5, 0, 0]) 
      square(size=[65, 10], center=true);

      for (x=[-1,1], y=[-1,1]) {
        translate([x * (70/2 - 3.25), y * (30 / 2 - 3.25), 0]) 
          circle(r=5/2+0.2, $fn=36);
      }
    }

    // fan bracket holes
    translate([25, -25 - 25/2, 0]) {
      for (x=[-1,1]) {
        translate([x * 25, -21 + 4.5, 0]) 
        circle(r=5.2/2, $fn=36);
      }
    }
  }
}

module _side_base() {
  assign(bh = h - t - t / 2)
  assign(bd = d - 2 * t - t)
  difference() {
    union() {
      polygon(points=[
        [-d/2, -h/2],
        [d/2, -h/2],
        [d/2, h/2],
        [d/2 - m, h/2],
        [-d/2, -h/2 + m],
        [-d/2, -h/2]
      ]);
    }

    // back and base mortises
    for (a=[-1:1]) {
      translate([a * bd / 3, -h/2 + t, 0]) square(size=[s, t], center=true);

      translate([d/2 - t, a * h / 3, 0]) square(size=[t, s], center=true);
    }

    // front and back margin mortises
    for (a=[-1,1]) {
      translate([-d / 2 + t, - h/2 + m / 2 + a * m / 3, 0]) square(size=[t, s], center=true);

      translate([d / 2 - m / 2 + a * m / 3 , h/2  - t, 0]) square(size=[s, t], center=true);
    }
  }
}

module leftside_2d() {
  _side_base();
}

module rightside_2d() {
  difference() {
    _side_base();
  }
}

module base_2d() {
  assign(bw = w - 2 * t)
  assign(bh = d - 2 * t - t)
  difference() {
     union() {
      square(size=[bw, bh], center=true);
      for (x=[-1:1], y=[-1,1]) {
        translate([x * bw / 3, y * bh/2, 0]) 
        square(size=[s, 2*t], center=true);
      }

      for (x=[-1,1], y=[-1:1]) {
        translate([x * bw / 2, y * bh/3, 0]) 
          square(size=[2*t, s], center=true);
      }
    }
    translate([-w/2 + t + 5 + 215/2, d/2 - t - 35 - 115/2, 0]) 
    for (x=[-1,1], y=[-1,1]) {
      translate([x * 150/2, y * 50/2, 0]) 
        circle(r=4/2, $fn=12);
    }

    for (x=[-1:1], y=[-1,1]) {
      translate([x * 50, -d/2 + 5 + 15 + 60/2 + y * (60 / 2 + 3/2), 0]) square(size=[5, 3], center=true);
    }
  }
}

module top_margin_2d() {
  assign(bw = w - 2 * t)
  difference() {
    union() {
      square(size=[bw, m], center=true);
      for (x=[-1,1], y=[-1,1]) {
        translate([x * bw / 2, y * m / 3, 0]) 
        square(size=[2 * t, s], center=true);
      }
    }

    for (x=[-1:1]) {
      translate([x * bw / 3, m/2 - t, 0]) 
      square(size=[s, t], center=true);
    }
  }
}

module tabslot_with_relief() {
  // TODO: put the corner relief in!
  square(size=[t, s], center=true);
}

module front_margin_2d() {
  assign(bw = w - 2 * t)
  difference() {
    union() {
      square(size=[bw, m], center=true);
      for (a=[-1,1], b=[-1,1]) {
        translate([a * bw / 2, b * (m / 3), 0]) 
        square(size=[t * 2, s], center=true);
      }
    }

    for (x=[-1:1]) {
      translate([x * bw / 3, -m/2 + t, 0]) 
      square(size=[s, t], center=true);
    }
  }
}

module full_assembly() {
  translate([-w/2+215/2 + t + 5, d/2 - 115/2 - t - 35, -h/2 + 1.5*t + 50/2]) 
  spindle_power_supply();

  translate([-w/2 + t + t/2 + 50/2 + 5, d/2 - t, h/2 - 75/2 - t - 5]) 
  rotate([0, -90, 90]) 
  spindle_speed_controller();

  translate([0, -d/2 + t + 15 + 60/2, -h/2 + 1.5*t + 33/2]) 
  motor_power_supply();

  translate([0, d/2 - t - 6, h/2 - t - 10 - 10 - 2.7*25.4]) 
  electronics_assembly();

  translate([25, d/2 - 60/2 - t - t/2 - 10, -25])
    fan(60, 25, fan_mount_hole_d, 4.3/2);

  translate([25, d/2 - t - t/2 - 10, -25 - 25/2]) {
    for (x=[-1,1]) {
      translate([x * 25, 0, 0]) 
      rotate([0, 180, 0]) short_bracket();
    }
  }

  translate([w/2 - 2 * t - 31.25 / 2, d/2 - t/2, -h/2 + 2.5 * t + 24 / 2]) 
  rotate([0, 0, 180]) 
  mains_plug_connector();

  assign(a = d - m - t/2)
  assign(b = h - m - t/2)
  assign(c = sqrt(a * a + b * b))
  translate([0, -d/2 + t/2, -h/2 + m])
  rotate([90-asin(a/c), 0, 0])
  translate([0, c/2, t/2]) control_panel_assembly();

  translate([-w/2 + t + 5 + 70/2, d/2 - t / 2 - t - t, -h/2 + t / 2 + t + 5 + 40/2]) 
  rotate([90, 0, 180]) enclosure_connectors_board();

  translate([0, 0, -h/2 + t]) 
  _e() base_2d();

  color("teal")
  translate([0, d/2 - t, 0]) 
  rotate([90, 0, 0]) 
  _e() back_2d();
  
  color("tan")
  translate([-w/2 + t / 2, 0, 0]) 
  rotate([90, 0, 90]) 
  _e() leftside_2d();

  color("tan")
  translate([w/2 - t / 2, 0, 0])
  rotate([90, 0, 90])
  _e() rightside_2d();
  
  color("pink")
  translate([0, -d/2 + t, -h/2 + m/2]) 
  rotate([90, 0, 0]) 
  _e() front_margin_2d();

  color("pink")
  translate([0, d/2 - m/2, h/2 - t])
  _e() top_margin_2d();
}

full_assembly();