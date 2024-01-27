// grow-flower-tests.scad
// Test script for Flower Geometry Library

use <../grow-flower-geo_lib.scad>;

// Set the global variables for quality
$fa = 0.5;
$fs = 0.5;

// Define parameters for the flower
petalCount = 8;
centerDiameter = 20;
thickness = 2;
petalSpread = 55;

// Define colors for the flower parts
petalColor = "pink";
centerColor = "orange";
stemColor = "green";
leafColor = "lightgreen";

// Showcase example with custom colors
flower(petalCount, centerDiameter, thickness, petalSpread, petalColor, centerColor, stemColor, leafColor);
