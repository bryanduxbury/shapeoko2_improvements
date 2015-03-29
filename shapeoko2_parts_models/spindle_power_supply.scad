module spindle_power_supply() {
  color("gray")
  difference() {
    cube(size=[215, 115, 50], center=true);
    translate([215/2, 0, 25]) cube(size=[40, 111, 60], center=true);
    
    for (x=[-1,1],y=[-1,1]) {
      // TODO: was it 53 or 43 hole to hole?
      translate([x * (150 / 2), y * (50 / 2), -25]) 
        #cylinder(r=2, h=15, center=true);
    }
  }
}