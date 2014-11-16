hole_spacing = 75;
counterbore = 12.5;
bore = 7.7;

num_holes_x = 2;
num_holes_y = 4;

difference() {
  square(size=[250, 500]);
  translate([60, 20, 0]) {
    for (x=[0:num_holes_x - 1], y=[0:num_holes_y - 1]) {
      translate([x * hole_spacing, y * hole_spacing, 0]) 
      difference() {
        if (counterbore > bore) {
          circle(r=counterbore/2, $fn=36);
        }
        circle(r=bore/2, $fn=36);
      }
    }
  }
}
