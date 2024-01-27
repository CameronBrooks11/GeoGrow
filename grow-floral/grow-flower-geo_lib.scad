// grow-flower-geo_lib.scad

// Flower Geometry Library

// Flower module
module flower(n, c, E, P, petalColor = "red", centerColor = "yellow", stemColor = "green", leafColor = "darkgreen") {
    echo("n=", n);
    echo("c=", c);
    echo("E=", E);
    echo("P=", P);

    color(petalColor) petal(n, c, E, P);
    color(centerColor) center(n, c, E, P);
    color(stemColor) stem(n, c, E, P);
    color(leafColor) leaf(n, c, E, P);
    mirror([0, 1, 0]) color(leafColor) leaf(n, c, E, P);
}

// petal module
module petal(n, c, E, P) {
    difference() {
        for (i = [1:n]) {
            rotate([0, -2*E, i*(360/n)]) {
                resize([0, (P/2), E], auto = [false, false, false]) {
                    translate([c/2 + P/3, 0, 0]) sphere(r = P/2);
                }
            }
            echo("petal number ", i, "/", n);
        }
        translate([0, 0, -(4*P + 4*c)/2]) cube((4*P) + (4*c), center = true);
    }
    echo("petals done");
}

// center module
module center(n, c, E, P) {
    resize([0, 0, E/2]) {
        difference() {
            sphere(r = c/2);
            translate([0, 0, -c/2]) cube(c, center = true);
        }
    }
    echo("center done");
}

// stem module
module stem(n, c, E, P) {
    translate([(P + c), 0, 0]) {
        rotate([90, 180, 90]) {
            linear_extrude(height = (P + c)*1.5, center = true, convexity = 10, scale = 2) {
                difference() {
                    circle(r = E/2);
                    translate([-E, 0, 0]) square([2*E, 2*E]);
                }
            }
        }
    }
}

// leaf module
module leaf(n, c, E, P) {
    translate([P + c*2, 0, 0]) {
        rotate([0, -2*E, 180 - P - c]) {
            scale([2, 0.5, 1]) {
                difference() {
                    minkowski() {
                        cylinder(r = P - n, h = E/2);
                        translate([P - n, 0, 0]) sphere(r = E/2);
                    }
                    translate([P - n, 0, -E]) cylinder(r = 3*E, h = E);
                }
            }
        }
    }
}
