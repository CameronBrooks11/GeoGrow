/*
 * Title: Recursive Tree Library
 * Author: Cameron K. Brooks
 * Organization: FAST Research Group
 * Date: [2023-12-27]
 * License: GPL 3.0 or later
 *
 * Description:
 * This library generates customizable fractal trees for both static and animated rendering.
 * It features a variety of parameters for tree customization, including size, branching, and color.
 * Branching variation and angle adjustment can be controlled via optional parameters.
 *
 * Parameters:
 * - depth (int): Recursion depth of the tree, controls complexity.
 * - r (float): Radius at the base of the tree, determines initial size.
 * - cur_x, cur_y (float): Current position for branch placement, used in recursion.
 * - n_branches (int): Number of branches at each level.
 * - branch_len (float): Length of the branches, affects overall tree size.
 * - branch_d (float): Diameter of the branches, impacts thickness.
 * - ang (float): Starting angle for branching, influences tree spread.
 * - ang_dec (float): Angle decrement at each level, affects branching pattern.
 * - branch_xoffset, branch_yoffset (float): Offset for branch placement, can create asymmetry.
 * - branch_d_factor, branch_len_factor (float): Factors for reducing branch size at each level.
 * - color_palette (int): Index of the color palette to use.
 * - max_branch_variation (int): Optional maximum additional branches for variation.
 * - ang_rand_var (float): Optional random variance in angle, adds randomness to branching.
 * - fixed_xoffset, fixed_yoffset (bool): When true, applies a fixed offset at each iteration.
 *
 * Usage:
 * To generate a tree, call the tree module with desired parameters:
 * tree(depth=6, branch_len=100, color_palette=1);
 */


// --- Color Palettes ---
palette_vibrant = ["Red", "DeepSkyBlue", "LimeGreen", "Fuchsia", "Gold", 
                   "MediumSlateBlue", "HotPink", "OrangeRed", "MediumSpringGreen", "DodgerBlue"];

palette_pastel = ["LavenderBlush", "Honeydew", "MintCream", "AliceBlue", "Seashell", 
                  "LemonChiffon", "Azure", "LightCyan", "PaleTurquoise", "MistyRose"];

palette_earthy = ["SandyBrown", "Goldenrod", "Peru", "OliveDrab", "Khaki", 
                  "DarkKhaki", "Tan", "DarkOliveGreen", "BurlyWood", "Wheat"];

palette_cool = ["Indigo", "SlateBlue", "CadetBlue", "DarkSlateBlue", "Teal", 
                "DarkCyan", "SteelBlue", "MediumSlateBlue", "LightSeaGreen", "MidnightBlue"];

palette_autumn = ["SaddleBrown", "Sienna", "Chocolate", "Peru", "Goldenrod", 
                  "DarkGoldenrod", "Maroon", "FireBrick", "Crimson", "Tomato"];

palette_spring = ["GreenYellow", "Chartreuse", "LawnGreen", "PaleGreen", "LightGreen", 
                  "MediumSpringGreen", "SpringGreen", "Aquamarine", "MediumAquamarine", "YellowGreen"];

palette_night = ["MidnightBlue", "Navy", "DarkBlue", "MediumBlue", "RoyalBlue", 
                 "CornflowerBlue", "DarkSlateBlue", "SlateBlue", "Indigo", "DarkCyan"];

palette_warm = ["Chocolate", "Sienna", "Maroon", "FireBrick", "Brown", 
                "DarkRed", "Crimson", "DarkOrange", "Tomato", "OrangeRed"];


// --- Global Parameters ---
$fn = 16;
branch_ang_lim = 9999;
branch_d_factor = 0.86;
branch_len_factor = 0.95;

// --- Branch Variation Functions ---
// New function to determine the number of branches based on depth
function variable_branches(level, base_branches) = 
    let(
        variation = floor(sin(level) * 2)  // Simple variation based on sine wave
    )
    base_branches + variation;
function varied_branches(n, max_variation) = n + floor(rands(0, max_variation + 1, 1)[0]);
function varied_angles(ang, ang_rand_var) = rands(min_value=ang-ang_rand_var, max_value=ang+ang_rand_var, value_count=1)[0];
function varied_branch_offset(branch_offset) = rands(min_value=-branch_offset, max_value=branch_offset, value_count=1)[0];

// --- Utility Functions ---
function branch_diameter(d, level) = d * pow(branch_d_factor, level);
function branch_length(l, level) = l * pow(branch_len_factor, level);


// --- Main Tree Module ---
// Recursive tree module with all parameters customizable
module tree(
    depth=4, // Depth of recursion, controls complexity of the tree.
    r=9, // Radius at the base of the tree, determines initial size.
    cur_x=0, // Current x position, used in recursion for positioning branches.
    cur_y=0, // Current y position, used in recursion for positioning branches.
    n_branches=3, // Number of branches at each level of the tree.
    branch_len=100, // Initial length of branches, affects overall tree size.
    branch_d=40, // Initial diameter of branches, impacts thickness.
    ang=60, // Starting angle for branching, influences tree spread.
    ang_dec=3, // Angle decrement at each level, affects branching pattern.
    ang_rand_var=undef, // When defined introduces a random variance of that magnitude to ang with each iteration
    branch_xoffset=0, // x Offset for branch placement, can create asymmetry.
    branch_yoffset=0, // y Offset for branch placement, can create asymmetry.
    fixed_xoffset=false, // When true, applies a fixed x offset at each iteration.
    fixed_yoffset=false, // When true, applies a fixed y offset at each iteration.
    max_branch_variation=undef, // New parameter for max branch variation
    branch_d_factor=0.86, // Factor for reducing branch diameter at each level.
    branch_len_factor=0.95, // Factor for reducing branch length at each level.
    level=0, // Current recursion level, used internally for calculations.
    color_palette=0 // Index of the color palette to use, 0 for default.
     ) {

    // Select color palette based on color_palette variable
    selected_colors = 
        color_palette == 1 ? palette_vibrant :
        color_palette == 2 ? palette_pastel :
        color_palette == 3 ? palette_earthy :
        color_palette == 4 ? palette_cool :
        color_palette == 5 ? palette_autumn :
        color_palette == 6 ? palette_spring :
        color_palette == 7 ? palette_night :
        palette_warm; // Default or when color_palette == 8
    
    // Recursive tree generation
    // Apply color cycling based on recursion level
    color_index = level % len(selected_colors);  // Determine color index based on level
    current_color = selected_colors[color_index];  // Get current color from array
    
    // Base case for recursion
    if (depth > 0) {
        color(current_color) {
            // Draw branch components with the appropriate color
            cylinder(h=branch_len, d1=branch_d, d2=branch_diameter(branch_d, level), center=false);
            sphere(r=branch_diameter(branch_d, level) * 0.5, $fn=$fn);
        }

        
        // Create branches at the current level
        n_branches = is_undef(max_branch_variation) ? n_branches : varied_branches(n_branches, max_branch_variation);
        for (i=[0 : (360 / n_branches) : (359)]) {            let (
                x_offset = fixed_xoffset ? branch_xoffset : varied_branch_offset(branch_xoffset),
                y_offset = fixed_yoffset ? branch_yoffset : varied_branch_offset(branch_yoffset),
                ang = is_undef(ang_rand_var) ? ang - ang_dec : varied_angles(ang, ang_rand_var),
                x_ang = sin(i + x_offset) * ang,
                y_ang = cos(i + y_offset) * ang,
                cur_x = cur_x + x_ang,
                cur_y = cur_y + y_ang
            ) {
                // Position and orient the next level of branches
                translate([0, 0, branch_len]) rotate([y_ang, x_ang, 0]) {
                    // Recursive call to create the next level of branches if within limits
                    if ((max(abs(cur_x), abs(cur_y)) < branch_ang_lim)) {
                        tree(r=(r - 1), cur_x=cur_x, cur_y=cur_y, n_branches=n_branches, 
                             branch_len=branch_length(branch_len, level + 1), 
                             branch_d=branch_diameter(branch_d, level + 1),
                             ang=ang, depth=depth - 1, level=level + 1, color_palette=color_palette,max_branch_variation=max_branch_variation);
                    }
                }
            }
        }
    }
}

// Example call
//tree(depth=6, color_palette=3);

