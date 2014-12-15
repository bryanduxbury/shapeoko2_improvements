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
