module cylinder_carousel(rotz=0, transz=0, radius_carousel, cylinders, radius_cylinder, hight_cylinder) {
    for (i=[1:cylinders])  {
        rotate([0,0,rotz]) translate([radius_carousel*cos(i*(360/cylinders)),radius_carousel*sin(i*(360/cylinders)),transz]) cylinder(r=radius_cylinder,h=hight_cylinder, $fn=res);
    }
}      

module compartments(hight=35.1) {
    difference() {
        cylinder_carousel(radius_carousel=66, cylinders=35, radius_cylinder=6.5, hight_cylinder=hight);
        cylinder_carousel(transz=-1, radius_carousel=66, cylinders=35, radius_cylinder=5.6, hight_cylinder=hight+2);
    }
}

module compartments_floor(hight=35.1) {
    difference() {
        union() {
            cylinder_carousel(radius_carousel=66, cylinders=35, radius_cylinder=6.5, hight_cylinder=hight);
            cylinder(r=66, h = 1.8, $fn=res);
        }
        cylinder_carousel(transz=-1, radius_carousel=66, cylinders=35, radius_cylinder=5.6, hight_cylinder=hight+2);
    }
}

module motor_mount() {
    translate([0,0,-1]) cylinder(r=5, h=4, $fn=res);
    translate([-8,-17.5,-1]) cylinder(r=1.5, h=4, $fn=res);
    translate([-8,17.5,-1]) cylinder(r=1.5, h=4, $fn=res);
}

module middle_part() {
    difference() {
        cylinder(r=73.8, h=5, $fn=res);
        translate([0,0,3]) cylinder(r=72.8, h=7, $fn=res);
        translate([0,0,-1]) cylinder(r=71.8, h=10, $fn=res);
    }
    difference() {
        compartments_floor(hight=1.8); // clearing=1.2
        translate([0,0,-1]) cylinder(r=5.5, h=4, $fn=res);
        cylinder_carousel(transz=-1, radius_carousel=13, cylinders = 7, radius_cylinder=4, hight_cylinder=4);
        cylinder_carousel(transz=-1, radius_carousel=35, cylinders = 5, radius_cylinder=15, hight_cylinder=4);
        cylinder_carousel(rotz=37.5, transz=-1, radius_carousel=47, cylinders = 5, radius_cylinder=8, hight_cylinder=4);
    }
}

module lower_part() {
    difference() {
        cylinder(r=75, h=15, $fn=res);
        translate([0,0,13]) cylinder(r=74.5, h=7, $fn=res);
        translate([0,0,-1]) cylinder(r=73.1, h=17, $fn=res);
    }
    difference() {
        cylinder(r=75, h=2, $fn=res);
        motor_mount();
        cylinder_carousel(transz=-1, radius_carousel=35, cylinders=5, radius_cylinder=15, hight_cylinder=4);
        cylinder_carousel(rotz=37.5, transz=-1, radius_carousel=55, cylinders=5, radius_cylinder=12, hight_cylinder=4);
        cylinder_carousel(rotz=12, transz=-1, radius_carousel=60, cylinders=5, radius_cylinder=8, hight_cylinder=4);
        cylinder_carousel(rotz=-12, transz=-1, radius_carousel=60, cylinders=5, radius_cylinder=8, hight_cylinder=4);
    }
}

res=360;

//  ASSEMBLED
//translate([0,0, 3]) compartments();  // 72.5
//middle_part();                                     // 73.8
//translate([0,0,-13]) lower_part();        // 76.5

// EXPLODED
translate([0,0, 30]) compartments();  // 72.5
middle_part();                                     // 73.8
translate([0,0,-30]) lower_part();        // 76.5