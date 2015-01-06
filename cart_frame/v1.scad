use <../shapeoko2_parts_models/gusseted_bracket.scad>

w = 1200;
h = 750;
d = 600;

lower_shelf_h = 50;

bracket_w = 20;

module _yz() {
  color("blue") rotate([90, 0, 0]) children(0);
}

module _xz() {
  color("pink") rotate([0, 90, 0]) children(0);
}

module al_ext(l,x=20,y=20) {
  echo("Segment of x/y of length ", l, x, y);
  cube(size=[x, y, l], center=true);
}

module frame_assembly() {
  // verticals
  for (x=[-1:1],y=[-1,1]) {
    translate([x * (w / 2 - 10), y * (d/2 - 10), (h-60)/2 + 20]) al_ext(h-60);

    // for (z=[lower_shelf_h - 20, h-40]) {
    //   translate([x * (w / 2 - 20), y * (d/2 - 10), z])
    //     rotate([0, 0, x * 90 + 90]) gusseted_bracket();
    // }
  }

  // upper level front-back horizontals
  translate([0, 0, h-20]) {
    for (x=[-1:1]) {
      translate([x * (w/2 - 10), 0, 0]) {
        _yz() al_ext(d - 40, 20, 40);
        for (y=[-1,1]) {
          translate([0, y * (d - 40) / 2, -20])
            rotate([0, 0, y * 90 + 180]) gusseted_bracket();
        }
      }
    }
  }

  // lower level front-back horizontals
  for (x=[-1:1]) {
    translate([x * (w/2 - 10), 0, 10]) {
      _yz() al_ext(d - 40);
      for (y=[-1,1]) {
        if (!(x == 0 && z == lower_shelf_h - 10)) {
          translate([0, y * (d - 40) / 2, 10])
            rotate([0, 180, -y * 90 + 180]) gusseted_bracket();
        }
      }
    }
  }

  // width-wise horizontals
  // upper level
  translate([0, 0, h - 20]) {
    for (y=[-1,1]) {
      translate([0, y * (d/2 - 10), 0]) _xz() al_ext(w, 40, 20);
    }
  }

  // lower level
  translate([0, 0, 10]) {
    for (y=[-1,1]) {
      translate([0, y * (d/2 - 10), 0]) _xz() al_ext(w);
    }
  }
}

body_panel_w = d - 40 + 8;
body_panel_h = h - 60 + 8;
module body_panel() {
  color("tan", 0.5)
  cube(size=[body_panel_w, body_panel_h, 6], center=true);
}

module _torsion_box() {
  // color("brown")
  translate([0, 0, 25]) 
  %cube(size=[1200, 600, 50], center=true);
}

frame_assembly();

translate([0, 0, h]) 
  _torsion_box();


translate([0, 0, (h - 20 - 40) / 2 + 20]) {
  for (x=[-1,1]) {
    translate([x * (w / 2 - 10), 0, 0])
      rotate([90, 0, 90]) body_panel();

    translate([x * (w / 2 - 20 - (w / 2 - 30) / 2), d/2 - 10, 0])
      rotate([90, 0, 0]) body_panel();
  }
}
