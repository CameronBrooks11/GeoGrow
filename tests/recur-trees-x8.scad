use <..\recur_tree_lib.scad>

// Recursive Tree Library Usage Examples

// Toggle for each example (set to true to enable, false to disable)
example_1 = true;
example_2 = true;
example_3 = true;
example_4 = true;
example_5 = true;
example_6 = true;
example_7 = true;
example_8 = true;

// Translation variables to position each example
trans_x = 500; // Distance in x-axis between each tree

// Example 1: Vibrant Tree with Asymmetry from Branch Offset
if (example_1) {
    translate([0 * trans_x, 0, 0]) {
        tree(depth=5, branch_len=120, color_palette=1, branch_xoffset=10, branch_yoffset=10);
    }
}

// Example 2: Pastel Colored Static Tree with Short Branches
if (example_2) {
    translate([1 * trans_x, 0, 0]) {
        tree(depth=4, branch_len=80, color_palette=2);
    }
}

// Example 3: Earthy Palette with More Branches
if (example_3) {
    translate([2 * trans_x, 0, 0]) {
        tree(depth=5, n_branches=5, color_palette=3, ang_dec=2.5);
    }
}

// Example 4: Cool Palette Tree with Long and Thin Branches with Randomly Varied Angles
if (example_4) {
    translate([3 * trans_x, 0, 0]) {
        tree(depth=5, branch_len=150, branch_d=30, ang_rand_var=20, color_palette=4, branch_d_factor=0.8, branch_len_factor=1.0);
    }
}

// Example 5: Warm Palette Tree with Large Base and High Depth
if (example_5) {
    translate([4 * trans_x, 0, 0]) {
        tree(depth=6, r=12, branch_len=90, branch_d=45, color_palette=5);
    }
}

// Example 6: Custom Palette with Complex Structure
if (example_6) {
    translate([5 * trans_x, 0, 0]) {
        tree(depth=6, branch_len=110, n_branches=4, color_palette=6, ang_dec=2.8, branch_xoffset=5, branch_yoffset=5);
    }
}

// Example 7: Minimalistic Tree with Fewer Branches
if (example_7) {
    translate([6 * trans_x, 0, 0]) {
        tree(depth=6, n_branches=2, branch_len=95, branch_d=35, color_palette=7, branch_d_factor=0.9);
    }
}

// Example 8: High-Depth Tree with Branch Variation
if (example_8) {
    translate([7 * trans_x, 0, 0]) {
        tree(depth=7, branch_len=120, color_palette=8, max_branch_variation=1);
    }
}
