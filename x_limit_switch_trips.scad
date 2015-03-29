module _rounded_rect(w, h, r) {
  hull() {
    for (x=[-1,1], y=[-1,1]) {
      translate([x * (w/2 - r), y * (h/2 - r), 0]) {
        circle(r=r, $fn=144);
      }
    }
  }
}

difference() {
  union() {
    _rounded_rect(15, 65, 3);
    translate([7.5, -65/2 + 10, 0]) 
    _rounded_rect(30, 20, 3);
  }
  for (x=[-1,1]) {
    translate([7.5 + x * 7.5, -65/2 + 10, 0]) circle(r=5.25/2, $fn=36);
  }
}
