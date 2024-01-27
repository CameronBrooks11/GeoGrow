// Test script for rose-flower-geometry_v1.scad library

// Import the rose flower geometry library
use <../rose-flower-geometry_lib.scad>;

// Function to position and render a rose example
module showcase_rose(k, n, radius, color, x, y) {
    translate([x, y, 0])
        rose_polygon(k, n, radius, color);
}

// Set the distance between each example
distance = 250;

// Showcase examples
showcase_rose(5, 7, 100, "red", 0, 0);
showcase_rose(4, 6, 90, "blue", distance, 0);
showcase_rose(6, 5, 80, "green", 2 * distance, 0);
showcase_rose(7, 3, 70, "yellow", 3 * distance, 0);
showcase_rose(8, 2, 60, "purple", 0, -distance);
showcase_rose(3, 8, 50, "orange", distance, -distance);
showcase_rose(2, 9, 40, "pink", 2 * distance, -distance);
showcase_rose(1, 10, 30, "cyan", 3 * distance, -distance);
