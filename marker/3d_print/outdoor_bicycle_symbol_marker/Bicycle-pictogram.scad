// Bicycle Pictogram
// Intent: To mount on fences and posts, so you can indicate if a location is friendly for temporary parking of bicycle.
//         E.g. In front of a cafe with cameras etc...
// Author: Brian Khuu 2023

// Mount Spec
fence_mount_depth = 50;
fence_mount_width_top = 50;
fence_mount_width_bottom = 50-10;
fence_mount_width_latch_thickness = 4.0;
fence_mount_width_base_thickness = 2.5;

// Bicycle Symbol Thickness
bicycle_symbol_thickness = 1.0;
bicycle_symbol_width = 200;

// Calc
rescaling = bicycle_symbol_width/100;

/////////////////////////////////////////////////////////////////////////
module mount_clip()
{
    mount_width = 10;
    clip_height = 10;
    clip_bump = 4;

    // Mount
    hull()
    {
        translate([-mount_width/2,0,0])
            cube([mount_width,0.01,fence_mount_width_base_thickness+fence_mount_width_top+clip_height]);
        translate([-2/2,fence_mount_width_latch_thickness,0])
            cube([2,0.01,fence_mount_width_base_thickness+fence_mount_width_top+clip_height]);
    }
    hull()
    {
        translate([-mount_width/2,-fence_mount_depth,0])
            cube([mount_width,0.01,fence_mount_width_base_thickness+fence_mount_width_latch_thickness+fence_mount_width_bottom]);
        translate([-2/2,-fence_mount_width_latch_thickness-fence_mount_depth,0])
            cube([2,0.01,fence_mount_width_base_thickness+fence_mount_width_latch_thickness+fence_mount_width_bottom]);
    }
    translate([-mount_width/2,-fence_mount_depth,0])
        cube([mount_width,fence_mount_depth,fence_mount_width_base_thickness]);
    // Clip
    hull()
    {
        translate([-mount_width/2,0,fence_mount_width_base_thickness+fence_mount_width_top])
            cube([mount_width,0.01,clip_height]);
        translate([-mount_width/2,-clip_bump,fence_mount_width_base_thickness+fence_mount_width_top+clip_height/2-1/2])
            cube([mount_width,0.01,1]);
    }
}

/////////////////////////////////////////////////////////////////////////
// Bicycle-pictogram.svg 100mm length
// Source of image: Retraced and slightly adjusted version of a public domain 
//                  Bicycle symbol found at https://publicdomainvectors.org/en/free-clipart/Bicycle-pictogram-vector-illustration/23113.html
translate([0,-0.3,0])
linear_extrude(height=bicycle_symbol_thickness)
    scale(rescaling)
        import("Bicycle-pictogram.svg");

// Bicycle Clip
translate([18*rescaling,0,0])
    mount_clip();
translate([18*rescaling+65*rescaling,0,0])
    mount_clip();

/////////////////////////////////////////////////////////////////////////
// 25x25mm QR code
translate([45*rescaling,30*rescaling,0])
linear_extrude(height=bicycle_symbol_thickness)
minkowski() 
{
    square([25,25]);
    circle(r=2, $fn=30);
}

/////////////////////////////////////////////////
// Check against the pole model
if(0)
translate([0,-25*rescaling,5])%cube([200,50,50]);