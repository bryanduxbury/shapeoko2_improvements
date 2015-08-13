slot_len = 75;
slot_w = 0.265 * 25.4;
gutter_w = 7.5;

insert_d = 10.4;

sep = 8;
tile_h = 2;

overall_w = gutter_w + insert_d + gutter_w + slot_len + gutter_w;
overall_h = slot_w + gutter_w * 2;

module clamp2d() {
  difference() {
    square(size=[overall_w, overall_h], center=true);

    translate([-overall_w / 2 + gutter_w + insert_d/2, 0, 0]) {
      circle(r=insert_d/2, $fn = $36);
    }

    hull()
    for (x=[-1,1]) {
      translate([overall_w / 2 - slot_len / 2 - gutter_w - x * (slot_len / 2 - slot_w / 2), 0, 0]) {
        circle(r=slot_w/2, $fn=36);
      }
    }
  }
}


for (y=[0:tile_h-1]) {
  translate([overall_w / 2, (y+0.5) * (overall_h + sep) - sep / 2, 0]) 
    clamp2d();
}

