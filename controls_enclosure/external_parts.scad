module spindle_power_supply() {
  color("gray")
  difference() {
    cube(size=[215, 115, 50], center=true);
    translate([215/2, 0, 25]) cube(size=[40, 111, 60], center=true);
  }
  
}

module spindle_speed_controller() {
  scale(25.4)
  translate([0, 0, 1.5]) {
    color("gray")
    translate([0, 0, -0.75]) 
    difference() {
      cube(size=[3, 2, 1.5], center=true);
      for (x=[-3:3]) {
        translate([x * 3 / 7, 0, -0.75]) {
          cube(size=[3/2/7 - 0.125, 2.5, 2.5], center=true);
        }
      }
      
    }
    
    
    color("green")
    translate([0, 0, 0.125]) 
    cube(size=[3, 2, 0.0625], center=true);

    color("black")
    translate([0.25, 0.5, 0.125 + 0.75]) 
    cylinder(r=0.5, h=1.5, center=true, $fn=36);
  }

}

module estop() {
  translate([0, 0, 37/2]) 
  color("red")
  cylinder(r=39/2, h=5, center=true);

  translate([0, 0, 34/2]) 
  color("red")
  cylinder(r=23/2, h=5, center=true);

  // TODO: -5 is a guess. get the real measurement of inside nut
  color("gray")
  translate([0, 0, -5]) {
    translate([0, 0, 20/2]) 
    cylinder(r=27.5/2, h=20, center=true);

    translate([0, 0, -32.35/2]) 
    cube(size=[37.5, 30, 32.25], center=true);
  }
}

module spindle_speed_pot() {
  color("black")
  translate([0, 0, 9 + 15.2/2]) 
  cylinder(r1=15/2, r2=10/2, h=15.2, center=true);
  
  color("gray") {
    translate([0, 0, 4.5]) 
    cylinder(r=6.7/2, h=9, center=true);

    translate([0, 0, -1.3/2]) 
    hull() {
      cylinder(r=16.25/2, h=1.3, center=true);
      translate([0, -21 + 16.25, 0]) cylinder(r=16.25/2, h=1.3, center=true);
    }

    assign(pot_body_height = 31.5 - 9 - 1.3 - 15.2)
    translate([0, 0, -pot_body_height/2 - 1.3]) 
    cylinder(r=16.25/2, h=pot_body_height, center=true);
  }
}

module fan(l, d, s, rad) {
  color("black")
  difference() {
    cube(size=[l, l, d], center=true);
    for (a=[0:4]) {
      rotate([0, 0, a * 90]) 
      translate([s/2, s/2, 0]) 
      #cylinder(r=rad, h=d*2, center=true);
    }
  }
}

module motor_power_supply() {
  color("black")
  cube(size=[150, 60, 33], center=true);
}

motor_power_supply();