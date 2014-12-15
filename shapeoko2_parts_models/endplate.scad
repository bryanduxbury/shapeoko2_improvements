module endplate() {
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
