use <../Generic/Standoffs.scad>
use <../Generic/Fingerjoints.scad>
use <../GenericArcade/SegaAstroP2.scad>

/* TODO: 
 * Create Outer Frame Module which has Buttons and neutrik connector
 * Create Outer Frame Module for Joystick Loop
 * Create Bottom Panel
 */

$fn = 100;

/* Units 1:1mm */
/* Thickness of material */
mT 	= 6;

/* Control Panel Module Dimensions */
cpX  = 14 * 25;	 	// 14 inches
cpY  = 8 * 25;		//  8 inches
cpD  = [cpX, cpY];
cpH  = mT;			// Height of control panel layer

/* Inner Frame Dimensions */
fW = 25;			// Frame Width
/* TODO: Should I try smaller ones? */
sH = 50;			// Standoff Height
iFLFJC = 15;		// Inner Frame Length Finger Joint Count
iFDFJC = 9;			// Inner Frame Depth Finger Joint Count

/* Bottom Panel Dimensions */
bwH = mT;			// Height of wood layer of bottom panel
bfH = 2;			// Height of foam layer of bottom panel
bpH = bwH + bfH;	// Height of bottom panel

/* Outer Frame Dimensions */
ofH = (bfH / 2) + bwH + mT + sH + cpH;
oFFJC = 5;			// Outer Frame Finger Joint Count

/* Defines position of standoffs */
module Standoff_Positions()
{
	/* First Column */
	translate([fW/2, 0, 0])
	{
		translate([0, fW/2, 0]) 		children(0);
		translate([0, cpY/2, 0]) 		children(0);
		translate([0, cpY - fW/2, 0]) 	children(0);
	}

	/* Second Column */
	translate([cpX/2, 0, 0])
	{
		translate([0, fW/2, 0]) 		children(0);
		translate([0, cpY - fW/2, 0]) 	children(0);
	}

	/* Third Column */
	translate([cpX - fW/2, 0, 0])
	{
		translate([0, fW/2, 0]) 		children(0);
		translate([0, cpY/2, 0]) 		children(0);
		translate([0, cpY - fW/2, 0]) 	children(0);
	}
}

/* Defines a Layer of the inner frame */
module Inner_Frame_Layer_2D()
{
	translate([mT, mT, 0])
	{
		union()
		{
			/* Add finger joints around the edge */
			Fingerjoint_Tabs_2D("DOWN", "ODD", cpX, iFLFJC, mT);
			Fingerjoint_Tabs_2D("LEFT", "ODD", cpY, iFDFJC, mT);
			translate([cpX, 0, 0])	Fingerjoint_Tabs_2D("RIGHT", "ODD", cpY, iFDFJC, mT);
			translate([0, cpY, 0])	Fingerjoint_Tabs_2D("UP", "ODD", cpX, iFLFJC, mT);

			difference()
			{
				/* Main Body */
				square(cpD);
				/* Inner Cut */
				translate([fW, fW, 0])	square([cpX - (fW*2), cpY - (fW*2)]);
				/* Cutout for standoffs */
				Standoff_Positions() children(0);		
			}
		}
	}
}

module Outer_Frame_Length_2D()
{
	translate([mT, 0, 0])
	{
		union()
		{
			Fingerjoint_Tabs_2D("LEFT", "EVEN", ofH, oFFJC, mT);
			translate([cpX,0,0]) Fingerjoint_Tabs_2D("RIGHT","EVEN", ofH, oFFJC, mT);
			difference()
			{
				square([cpX, ofH]);
				translate([0, bfH /2 + bwH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpX, iFLFJC, mT);
				translate([0, bfH/2 + bwH + sH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpX, iFLFJC, mT);
			}
		}
		
	}
}

module Outer_Frame_Depth_2D()
{
	translate([mT, 0, 0])
	{
		union()
		{
			Fingerjoint_Tabs_2D("LEFT", "ODD", ofH, oFFJC, mT);
			translate([cpY,0,0]) Fingerjoint_Tabs_2D("RIGHT","ODD", ofH, oFFJC, mT);
			difference()
			{
				square([cpY, ofH]);
				translate([0, bfH /2 + bwH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpY, iFDFJC, mT);
				translate([0, bfH/2 + bwH + sH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpY, iFDFJC, mT);
			}
		}
	}
}

/* Panel for Top and Bottom */
module Panel_2D()
{
	difference()
	{
		square(cpD);
		Standoff_Positions() circle(d=5);
	}
}

module Test_Fit()
{
	translate([mT, mT, 0])
	{
		/* Foam Layer */
		linear_extrude(bfH) color([0,0,0]) Panel_2D();
		/* Sheet Wood Bottom Panel */
		translate([0, 0, bfH]) linear_extrude(mT) Panel_2D();
	}

	/* Outer Frame */
	translate([0, 0, bfH /2])
	{
		rotate([90, 0, 90]) linear_extrude(mT) Outer_Frame_Depth_2D();
		translate([cpX + mT, 0, 0]) rotate([90, 0, 90]) linear_extrude(mT) Outer_Frame_Depth_2D();
		translate([0, mT, 0])
		{
			rotate([90, 0, 0]) linear_extrude(mT) Outer_Frame_Length_2D();
			translate([0, cpY + mT, 0]) rotate([90, 0, 0]) linear_extrude(mT) Outer_Frame_Length_2D();
		}
	}
	
	translate([0, 0, bpH])	// Space for bottom panel
	{
		
		/* Bottom inner frame layer */
		linear_extrude(mT/2) Inner_Frame_Layer_2D() circle(d=4); 
		
		translate([0, 0, 3]) 
		{
			/* Inner Layer of Frame, has cutout of standoffs to ensure a locking fit */
			linear_extrude(mT/2) Inner_Frame_Layer_2D() S_970500451_2D(0);
			/* Standoffs */
			translate([mT, mT, 0]) Standoff_Positions() S_970500451();
		}
		translate([0, 0, sH])
		{
			/* Top Inner Frame Layers */
			linear_extrude(mT/2) Inner_Frame_Layer_2D() S_970500451_2D(0);
			translate([0,0,mT/2]) linear_extrude(mT/2) Inner_Frame_Layer_2D() circle(d=4); 
			
			/* Control Panel */
			translate([cpX/2 + mT, cpY/2 + mT, mT])linear_extrude(3) SegaAstroP2_8B_ControlPanel_L3();
			translate([cpX/2 + mT, cpY/2 + mT, mT * 1.5])linear_extrude(3) SegaAstroP2_8B_ControlPanel_L1();
		}
	}
}

/* Individual Layouts */
//Inner_Frame_Layer_2D() circle(d=4);			/* Need 2 of these (3mm) */
//Inner_Frame_Layer_2D() S_970500451_2D(0);		/* Need 2 of these (3mm) */
/* TODO: Create a layout which has Connectors and Extra Buttons (Maybe even a handle) */
//Outer_Frame_Length_2D();						/* Need 1 of these (6mm) */
/* TODO: Create a Layout which has Hole for Key Ring */
//Outer_Frame_Depth_2D();						/* Need 1 of these (6mm) */
//Panel();

Test_Fit();