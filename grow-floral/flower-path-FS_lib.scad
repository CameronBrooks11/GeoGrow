// flower_library.scad - Library for creating flower shapes using Fourier series

// Function to create flower shape outlines using Fourier series
function FlowerF(r, isteps, w, a, h_range) =
  let(steps = min(isteps * w, 300))
  [  for (t = [0 : 1/steps : 1])
     let( r2 = r * 1.05 + vsum([
       for (k = h_range)     
         a[k] * (sin(k * t * w * 360) / k) * r] ),
       x = r2 * sin(t * 360),
       y = r2 * cos(t * 360)
     )
     [x, y]
  ];

// Function to close a shape by adding a last point equal to the first
function close(p) = concat(p, [p[0]]);

// Function to generate random numbers
function rnd(a = 1, b = 0, s = []) =
  s == [] ? rands(min(a, b), max(a, b), 1)[0] : rands(min(a, b), max(a, b), 1, s)[0];

// Function to sum vectors
function vsum(l) = len(l) > 0 ? [for (li = l) 1] * l : undef;

// Main module for creating a flower shape with intuitive parameters
module createFlower(radius = 100, complexity = 5, waveCount = 3, amplitudeRange = [0.5, 0.75], hRange = [2, 5]) {
    local_a = concat([rnd(amplitudeRange[0]), rnd(amplitudeRange[1])], [for (k = [0 : 1 : 30]) rnd(1)]);
    local_p = FlowerF(
      radius,
      complexity,
      waveCount,
      local_a,
      [min(hRange[0], hRange[1]) : 1 : max(hRange[0], hRange[1])]
    );

    polygon(local_p);
}

// Example usage of the module
createFlower(radius = 120, complexity = 200, waveCount = 3, amplitudeRange = [0.5, 1], hRange = [2, 6]);
