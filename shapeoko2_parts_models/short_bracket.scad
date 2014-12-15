
d = 21;
t = 1.8;
w = 13;
r = 6.35/2;

module short_bracket() {
  color("gray")
  union() {
    translate([0, 0, t/2]) 
    difference(){
      cube(size=[w, d, t], center=true);
      translate([0, -d/2 + 4.3 + r, 0]) 
      circle(r=r);
    }
      

    translate([0, d/2 - t/2, d/2]) 
      cube(size=[w, t, d], center=true);
  }
}