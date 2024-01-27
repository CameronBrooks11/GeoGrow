// Function to create flower shape outlines using Fourier series
function FlowerF(r=100, isteps=5, w, a, h=2, h2) =
  let(steps = min(isteps * w, 300))  // Set the maximum number of steps
  [  for (t = [0 : 1/steps : 1])  // Loop through each step
     let( r2 = r * 1.05 + vsum([
       for (k = [h2 : h : max(9, 22 - w)])     
         a[k] * (sin(k * t * w * 360) / k) * r] ),
       x = r2 * sin(t * 360),  // Calculate x-coordinate
       y = r2 * cos(t * 360)   // Calculate y-coordinate
     )
     [x, y]  // Return the x and y coordinates
  ];

// Function to close a shape by adding a last point equal to the first
function close(p) = concat(p, [p[0]]);

// Function to generate random numbers
function rnd(a = 1, b = 0, s = []) =
  s == [] ? rands(min(a, b), max(a, b), 1)[0] : rands(min(a, b), max(a, b), 1, s)[0];

// Function to sum vectors
function vsum(l) = len(l) > 0 ? [for (li = l) 1] * l : undef;


// Module to draw a polyline based on points
module polyline(p) {
  for (i = [0 : max(0, len(p) - 2)])
    line(p[i], p[i + 1]);
}

// Module to draw a line between two points with a given width
module line(p1, p2, width = 0.5) {
  hull() {
    translate(p1) sphere(width);
    translate(p2) sphere(width);
  }
}


// Random coefficient generation for the Fourier series
a = concat([rnd(0.5), rnd(0.75)], [for (k = [0 : 1 : 30]) rnd(1)]);

// Generate points for the flower shape
p = FlowerF(
  100,
  200,
  round(rnd(0, 3)) * 2 + 1,
  a,
  min(2, round(rnd(1, 3))),
  min(2, round(rnd(1, 3)))
);

// Create the flower shape
polygon(p);

// Uncomment to draw the shape using lines
// polyline(p); 