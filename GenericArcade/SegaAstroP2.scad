/* Sega Astro Player 2 Layout as defined on  *
 * https://slagcoin.com/joystick/layout.html */

/*
 * DONE: Snap-In Layer
 * TODO: Support Layer 1 (Joytick Clearance)
 * TODO: Support Layer 2 (Joystick Support)
 */

use <SanwaModules.scad>

cp_d=[14*25,8*25];		// Control Panel Dimensions

/* Defines a row of buttons */
module ButtonRow(a=true, b=true, c=true, d=true)
{
	// A B C D

	if(a) children(0); 					// A
	translate([30.5, 20, 0])			// A->B
	{
		if(b) children(0);				// B
		translate([36,0,0])				// B->C
		{
			if(c) children(0);			// C
			translate([36,-9,0])		// C->D
			{
				if(d) children(0);		// D
			}
		}
	}
}

module SegaAstroP2_8B_Layout()
{
	// TODO is this correct?
	translate([-66.75,0,0])
	{
		children(0);		// Joystick

		// Top Layer, rel. to Joystick
		translate([63,19,0])  ButtonRow() children(1);
		// Bottom Layer, rel to Joystick
		translate([63,-20,0]) ButtonRow() rotate([0, 0, 315]) children(1);
	}
}

module SegaAstroP2_8B_ControlPanel_L1(d=cp_d)
{
	difference()
	{
		square(d, true);
		SegaAstroP2_8B_Layout() JLFTP8YT_L_CPHole();
	}
}

module SegaAstroP2_8B_ControlPanel_L2(d=cp_d)
{
	difference()
	{
		square(d, true);
		SegaAstroP2_8B_Layout() JLFP1_L_Plate();
	}
}

module SegaAstroP2_8B_ControlPanel_L3(d=cp_d)
{
	difference()
	{
		square(d, true);
		SegaAstroP2_8B_Layout() JLFP1_L_Holes();
	}
}

linear_extrude(3) SegaAstroP2_8B_ControlPanel_L1();
translate([0,0,-3])
linear_extrude(3) SegaAstroP2_8B_ControlPanel_L2();
translate([0,0,-9])
linear_extrude(6) SegaAstroP2_8B_ControlPanel_L3();
