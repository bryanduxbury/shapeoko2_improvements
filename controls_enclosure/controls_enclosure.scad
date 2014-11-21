// TODO:
// - mounting holes for motor supply zip ties
// - mounting holes for control panel hinges
// - add screw-down fins to control panel
// - cut-out and mounting holes for usb bulkhead
// - connection point for anchor
// - connector panel board???

use <external_parts.scad>
use <arduino.scad>

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

spindle_supply_hole_x = 150;
spindle_supply_hole_y = 50;


module _e() {
  linear_extrude(height=t, center=true) {
    children(0);
  }
}

module control_panel_assembly() {
  color("white")
  _e() control_panel_2d();
  
  translate([w/2 - 40, d / 2 - 70, 0]) estop();
  
  spindle_speed_pot();
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
    translate([d/2 - 60/2 - t - 5, h/2 - 60 / 2 - t - 15, 0]) {
      for (a=[0:3]) {
        rotate([0, 0, a*90]) 
        translate([fan_mount_hole_d/2, fan_mount_hole_d/2, 0]) 
        circle(r=2, $fn=36);
      }

      assign(slits = 5)
      assign(f = fan_mount_hole_d / 4 - 1.5)
      for (a=[0:3]) {
        rotate([0, 0, a*90]) 
        translate([f, f + k/2, 0]) 
        for (x=[-floor(slits/2):floor(slits/2)]) {
          translate([x * 2 * f * 2 / (slits * 2 - 1), 0, 0])
          hull() {
            for (y=[-1,1]) {
              translate([0, y * (f - k/2 - k/2), 0]) 
                circle(r=k/2, $fn=12);
            }
          }
        }
      }
    }
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

  translate([w/2 - 25/2 - t/2 - t, d/2 - 60/2- t - 5, h/2 - 60/2 - t - 15]) 
  rotate([90, 0, 90]) 
  fan(60, 25, fan_mount_hole_d, 4.3/2);

  translate([0, -d/2 + t + 15 + 60/2, -h/2 + 1.5*t + 33/2]) 
  motor_power_supply();

  translate([0, d/2 - t - 6, h/2 - t - 10 - 10 - 2.7*25.4]) 
  electronics_assembly();

  translate([w/2 - 2 * t - 31.25 / 2, d/2 - t/2, -h/2 + 2.5 * t + 24 / 2]) 
  rotate([0, 0, 180]) 
  mains_plug_connector();

  assign(a = d - m - t/2)
  assign(b = h - m - t/2)
  assign(c = sqrt(a * a + b * b))
  translate([0, -d/2 + t/2, -h/2 + m])
  rotate([90-asin(a/c), 0, 0])
  translate([0, c/2, t/2]) control_panel_assembly();

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

  // color("tan")
  // translate([w/2 - t / 2, 0, 0])
  // rotate([90, 0, 90])
  // _e() rightside_2d();
  
  color("pink")
  translate([0, -d/2 + t, -h/2 + m/2]) 
  rotate([90, 0, 0]) 
  _e() front_margin_2d();

  color("pink")
  translate([0, d/2 - m/2, h/2 - t])
  _e() top_margin_2d();
}

full_assembly();
