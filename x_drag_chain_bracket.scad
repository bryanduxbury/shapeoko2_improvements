module _rounded_rect(w, h, r) {
  hull() {
    for (x=[-1,1], y=[-1,1]) {
      translate([x * (w/2 - r), y * (h/2 - r), 0]) {
        circle(r=r, $fn=144);
      }
    }
  }
}

module _circular_slot(r,l) {
  hull() {
    for (x=[-1,1]) {
      translate([x * (l / 2 - r), 0, 0]) circle(r=r, $fn=12);
    }
  }
}

module x_drag_chain_bracket2d() {
  difference() {
    union() {
      _rounded_rect(30, 150, 5);
      translate([0, -75 + 10, 0]) 
        _rounded_rect(50, 20, 5);
    }
    
    for (x=[-1,1]) {
      translate([x * 15, -75 + 10, 0])
        circle(r=5.25/2, $fn=36);
    }

    translate([0, 7.5, 0]) 
    rotate([0, 0, 90]) _circular_slot(5.25/2, 110);
  }
  
}

x_drag_chain_bracket2d();