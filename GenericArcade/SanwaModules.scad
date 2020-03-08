/*
 * TODO:
 * - Add option to button L_Hole modules for clip clearance
 *   (This would be useful for creating backing material for buttons)
 * - Get dimensions for Sanwa Joystick
 */

$fn=100;
/* Button Modules */
/* Creates a Hole large enough for a Sanwa OSBF30 Button */

tW = 6;
module OBSF30_L_Hole(padding=0, tab=false)
{
	HS=30;
	union()
	{
		circle(d=(HS + padding));	
		if(tab==true)
		{
			translate([0, HS/2, 0]) square([tW, 6], true);
			translate([0, -HS/2, 0]) square([tW, 6], true);
		}
	}
}

/* Rough Model of the Sanwa OBSF30, Useful for Test Fitting */
module OBSF30_3D(cp=[1.0, 1.0, 1.0], cs=[0.0, 0.0, 0.0])
{
	/*TODO Add Clips if I can get the Dimensions */
	translate([0,0,3]) color(cp) linear_extrude(3.5) circle(d=25);
	color(cs) linear_extrude(3) circle(d=33.2);
	translate([0,0,-32]) linear_extrude(32) circle(d=29.5);
}

module OBSF24_L_Hole(padding=0, tab=false)
{
	HS=24;
	union()
	{
		circle(d=(HS + padding));
		if(tab==true)
		{
			translate([0, HS/2, 0]) square([tW, 6], true);
			translate([0, -HS/2, 0]) square([tW, 6], true);
		}
	}	
}

/* Rough Model of the Sanwa OBSF24, Useful for Test Fitting */
module OBSF24_3D(cp=[1.0, 1.0, 1.0], cs=[0.0, 0.0, 0.0])
{
	/*TODO Add Clips if I can get the Dimensions */
	translate([0,0,2.8]) color(cp) linear_extrude(3.5) circle(d=19.5);
	color(cs) linear_extrude(2.8) circle(d=27);
	translate([0,0,-32]) linear_extrude(32) circle(d=23.5);
}

/* Joystick Modules */

module JLFTP8YT_L_CPHole()
{
	hD = 24;

	circle(d=hD);
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
		circle(d=hDC);
		translate([-20, 0, 0]) circle(d=hD);
		translate([+20, 0, 0]) circle(d=hD);
	}

	// Hole diameter
	hDC = 6;
	hD =  4;

	translate([0, +42.25, 0]) hl();
	translate([0, -42.25, 0]) hl();

	JLFTP8YT_L_CPHole();
}
