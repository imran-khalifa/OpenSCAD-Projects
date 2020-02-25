/*
 * TODO:
 * - Add option to button L_Hole modules for clip clearance
 *   (This would be useful for creating backing material for buttons)
 * - Get dimensions for Sanwa Joystick
 */

$fn=100;
/* Button Modules */
/* Creates a Hole large enough for a Sanwa OSBF30 Button */
module OBSF30_L_Hole()
{
	circle(15);	
}

/* Rough Model of the Sanwa OBSF30, Useful for Test Fitting */
module OBSF30_3D(cp=[1.0, 1.0, 1.0], cb=[0.0, 0.0, 0.0])
{
	/*TODO Add Clips if I can get the Dimensions */
	translate([0,0,3]) color(cp) linear_extrude(3.5) circle(d=25);
	color(cb) linear_extrude(3) circle(d=33.2);
	translate([0,0,-31.7]) linear_extrude(31.7) circle(d=29.5);
}

OBSF30_3D();

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

	JLFTP8YT_L_CPHole();
	//square(53, true);
}
