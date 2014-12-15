module enclosure_connectors_board() {
  color("green")
  translate([0, 0, -1.5/2]) 
  difference() {
    cube(size=[70, 40, 1.5], center=true);

    // m5 mounting holes
    for (x=[-1,1], y=[-1,1]) {
      translate([x * (70/2 - 3.25), -40/2 + 15 + y * (30/2 - 3.25), 0]) circle(r=5/2, $fn=12);
    }
  }

  color("gray")
  translate([-70/2, -40/2, 0]) 
  for (xy=[[5,15,0], [17.5,15,0], [30,15,0], [42.5,15,0], [55,15,0]]) {
    translate(xy) 
    translate([2.5*3/2, 0, 15/2]) 
    cube(size=[11, 6, 15], center=true);
  }
}