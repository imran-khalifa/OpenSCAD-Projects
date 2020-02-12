/*
 * TODO:
 * - Add option to button L_Hole modules for clip clearance
 *   (This would be useful for creating backing material for buttons)
 * - Get dimensions for Sanwa Joystick
 */

/* Button Modules */
module OBSF30_L_Hole()
{
	circle(15);	
}

module OBSF24_L_Hole()
{
	circle(12);
}

/* Joystick Modules */

module JLFTP8YT_L_CPHole()
{
	hD = 24;

	circle(hD/2);
}

/* 2D Layout for JLF-P1 Mounting Plate
 * Dimensions 95mm H x 53 mm W x 1.6mm D, 2mm R */
module JLFP1_L_Plate(pad=0)
{
	pH = 95;
	pW = 53;
	pR = 2;

	minkowski()
	{
		square([(pW - pR) + pad, (pH - pR) + pad], true);
		circle(pR);
	}
}

/* 2D Layout for JLF-P1 Mounting Holes */
module JLFP1_L_Holes()
{
	module hl()
	{
		circle(hD/2);
		translate([-20, 0, 0]) circle(hD/2);
		translate([+20, 0, 0]) circle(hD/2);
	}

	// Hole diameter
	hD = 5;

	translate([0, +41.25, 0]) hl();
	translate([0, -41.25, 0]) hl();

	square(53, true);
}
