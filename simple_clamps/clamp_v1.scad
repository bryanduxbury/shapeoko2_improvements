slot_len = 75;
slot_w = 0.250 * 25.4 + 0.1;
gutter_w = 7.5;

sep = 8;
tile_h = 1;

module clamp2d() {
  difference() {
    square(size=[slot_len + 2 * gutter_w, slot_w + 2 * gutter_w], center=true);
    hull()
    for (x=[-1,1]) {
      translate([x * (slot_len / 2 - slot_w / 2), 0, 0]) {
        circle(r=slot_w/2, $fn=36);
      }
    }
  }
}


for (y=[0:tile_h-1]) {
  translate([slot_len/2 + gutter_w, (y+0.5) * (slot_w + gutter_w*2 + sep) - sep / 2, 0]) 
    clamp2d();
}

