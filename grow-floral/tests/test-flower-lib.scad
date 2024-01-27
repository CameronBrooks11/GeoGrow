// test_flower_lib.scad - Test script for flower-path-FS_lib.scad

// Import the flower library from the parent directory
use <../flower-path-FS_lib.scad>;

// Function to create a grid layout for the flower examples
module layoutFlowerExample(x, y, radius, complexity, waveCount, ampMin, ampMax, hMin, hMax) {
    translate([x, y, 0])
        createFlower(radius, complexity, waveCount, [ampMin, ampMax], [hMin, hMax]);
}

// Layout distance
distanceX = 250;
distanceY = 300;

// Example 1 - Small, simple flower
layoutFlowerExample(0, 0, 40, 50, 2, 0.1, 0.5, 2, 3);

// Example 2 - Larger flower with moderate complexity
layoutFlowerExample(distanceX, 0, 90, 150, 5, 0.3, 0.8, 3, 5);

// Example 3 - Medium flower with high complexity and sharp petals
layoutFlowerExample(2 * distanceX, 0, 70, 250, 10, 0.5, 1.0, 4, 8);

// Example 4 - Large, highly complex flower
layoutFlowerExample(3 * distanceX, 0, 100, 200, 3, 0.2, 0.7, 5, 10);

// Example 5 - Small, dense flower with many petals
layoutFlowerExample(0, distanceY, 50, 180, 15, 0.4, 0.9, 2, 4);

// Example 6 - Medium flower with low complexity
layoutFlowerExample(distanceX, distanceY, 80, 100, 4, 0.6, 1.2, 6, 7);

// Example 7 - Large flower with moderate wave count and high amplitude
layoutFlowerExample(2 * distanceX, distanceY, 110, 220, 7, 0.7, 1.5, 1, 3);

// Example 8 - Very large, intricate flower
layoutFlowerExample(3 * distanceX, distanceY, 130, 300, 20, 0.8, 1.4, 3, 9);

