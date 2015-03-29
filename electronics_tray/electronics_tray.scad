use <../shapeoko2_parts_models/arduino.scad>
use <../shapeoko2_parts_models/spindle_speed_controller.scad>
use <../shapeoko2_parts_models/enclosure_connectors_board.scad>
use <../shapeoko2_parts_models/fan.scad>
use <../shapeoko2_parts_models/spindle_power_supply.scad>
use <../shapeoko2_parts_models/motor_power_supply.scad>

translate([0, 0, -6]) {
  difference() {
    cube(size=[12 * 25.4, 12 * 25.4, 12], center=true);

    // spindle supply holes
 
    translate([-6 * 25.4 + 115 / 2 + 10, -40, 0]) {
      rotate([0, 0, 90])
      for (x=[-1,1], y=[-1,1]) {
        translate([x * 150/2, y * 50 / 2, -12 + 8/2 - 0.1]) {
          // main hole
          cylinder(r=4/2, h=25, center=true, $fn=36);
          // countersink
          cylinder(r=8/2, h=8, center=true, $fn=36);
        }
      }
    }

    // arduino
    translate([110, -70, 0]) {
      rotate([0, 0, 90]) {
        scale(25.4 / 1000)
        for (xy=[[550, 100], [600, 2000], [2600, 300], [2600, 1400]]) {
          translate(xy)
            #cylinder(r=135/2, h=2000, $fn=36, center=true);
        }
      }
    }
    
  }
}

translate([-6 * 25.4 + 115 / 2 + 10, -40, 50/2])
  rotate([0, 0, 90])
    spindle_power_supply();

// translate([10, 0, 33/2])
//   rotate([0, 0, 90])
//     motor_power_supply();

translate([60, -50, 0])
  rotate([0, 0, 90])
    Arduino();
//
// translate([85, 25, 60/2])
//   rotate([90, 0, 0])
//     fan(60, 25, 50, 4.3/2);