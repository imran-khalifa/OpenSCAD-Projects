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

	if(a) OBSF30_L_Hole(); 				// A
	translate([30.5, 20, 0])			// A->B
	{
		if(b) OBSF30_L_Hole();			// B
		translate([36,0,0])				// B->C
		{
			if(c) OBSF30_L_Hole();		// C
			translate([36,-9,0])		// C->D
			{
				if(d) OBSF30_L_Hole();	// D
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
		translate([63,19,0])  ButtonRow();
		// Bottom Layer, rel to Joystick
		translate([63,-20,0]) ButtonRow();
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
