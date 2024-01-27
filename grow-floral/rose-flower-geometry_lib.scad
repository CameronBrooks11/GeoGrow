// Rose Flower Geometry Library for OpenSCAD
// This library generates rose curve patterns which can be used to create flower-like geometries.
// Parameters:
//   k: Number of petals. Should be a positive integer.
//   n: Symmetry factor. Should be a positive integer.
//   radius: Radius of the rose curve. Should be a positive number.
//   step: Step size for theta. Smaller values result in smoother curves.
// Inspired by: https://eribuijs.blogspot.com/2017/03/creating-mathematical-rose-in-openscad.html


// Default values for parameters
step = 1;

// Function to generate rose curve points
function rose_points(k = 5, n = 7, radius = 100, step = 1) = 
    assert(k > 0 && n > 0 && radius > 0 && step > 0, "Parameters must be positive")
    k % 2 == 0 && n % 2 == 1 
        ? [for (theta = [0 : step : 360 * n]) [radius * cos(k/n*theta) * sin(theta), radius * cos(k/n*theta) * cos(theta)]] 
        : [for (theta = [0 : step : 180 * n]) [radius * cos(k/n*theta) * sin(theta), radius * cos(k/n*theta) * cos(theta)]];

// Module to create a rose curve polygon
module rose_polygon(k, n, radius, color = "red") {
    points = rose_points(k, n, radius);
    color(color) polygon(points);
}

// Example usage:
rose_polygon(5, 7, 100);
