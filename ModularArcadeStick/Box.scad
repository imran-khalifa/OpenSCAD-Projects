use <../Generic/Standoffs.scad>
use <../Generic/Fingerjoints.scad>
use <../GenericArcade/SanwaModules.scad>
use <../GenericArcade/SegaAstroP2.scad>

/* TODO: 
 * Create Outer Frame Module which has Buttons and neutrik connector
 * Create Outer Frame Module for Joystick Loop
 * Create Bottom Panel
 */

$fn = 100;

/* Units 1:1mm */
/* Thickness of material */
mT 	= 6;		// Main Material
mT2 = 3;		// Thinner Material
/* Screw hole size */
sHS = 4;

/* Control panel module dimensions */
cpX  = 14 * 25;	 			// 14 inches
cpY  = 8 * 25;				//  8 inches
cpD  = [cpX, cpY];
cpH  = mT + mT2;			// Height of control panel layer

/* Inner frame dimensions */
fW = 25;			// Frame width

sH = 50;			// Standoff height
sWS = 8;			// Standoff wrench size
sTL = 10;			// Standoff 
iFLFJC = 15;		// Inner frame length finger joint count
iFDFJC = 9;			// Inner frame depth finger joint count

/* Bottom panel dimensions */
bwH = mT;			// Height of wood layer of bottom panel
bfH = 2;			// Height of foam layer of bottom panel
bpH = bwH + bfH;	// Height of bottom panel

/* Button Colors */
mbpc = [173/255, 216/255, 230/255];	/* Main Buttons Plunger Colour */
mbsc = [0/255  , 35/255 , 102/255];	/* Main Buttons Surround Colour */

/* Outer frame dimensions */
ofH = (bfH / 2) + bwH + (2 * mT2) + sH + cpH; 	// Height of the outer frame (
oFFJC = 5;										// Outer Frame Finger Joint Count

tPBS = 9;										// Top Panel Button Spacing
tPBP = 0.80;									// Position of Buttons (%)
tPNP = 0.15;									// Position of Neutrik Connector (%)
/* Defines position of standoffs */
module Standoff_Positions()
{
	/* First column */
	translate([fW/2, 0, 0])
	{
		translate([0, fW/2, 0]) 		children(0);
		translate([0, cpY/2, 0]) 		children(0);
		translate([0, cpY - fW/2, 0]) 	children(0);
	}

	/* Second column */
	translate([cpX/2, 0, 0])
	{
		translate([0, fW/2, 0]) 		children(0);
		translate([0, cpY - fW/2, 0]) 	children(0);
	}

	/* Third column */
	translate([cpX - fW/2, 0, 0])
	{
		translate([0, fW/2, 0]) 		children(0);
		translate([0, cpY/2, 0]) 		children(0);
		translate([0, cpY - fW/2, 0]) 	children(0);
	}
}

/* Defines a layer of the inner frame
   Accepts one child which is placed at the standoff positions
 */
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
				/* Main body */
				square(cpD);
				/* Inner cut */
				translate([fW, fW, 0])	square([cpX - (fW*2), cpY - (fW*2)]);
				/* Cutout for standoffs */
				Standoff_Positions() children(0);		
			}
		}
	}
}

/* Defines a blank outer frame panel for the front and back */
module Outer_Frame_Length_2D()
{
	translate([mT, 0, 0])
	{
		union()
		{
			/* Create fingerjoint tabs on the left and right side of the panel */
			Fingerjoint_Tabs_2D("LEFT", "EVEN", ofH, oFFJC, mT);
			translate([cpX,0,0]) Fingerjoint_Tabs_2D("RIGHT","EVEN", ofH, oFFJC, mT);
			difference()
			{
				/* Main body of the panel */
				square([cpX, ofH]);
				/* Cut out gaps for the inner frame to slot into */
				translate([0, bfH /2 + bwH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpX, iFLFJC, mT2*2);
				translate([0, bfH/2 + bwH + sH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpX, iFLFJC, mT2*2);
			}
		}
		
	}
}

/* Defines a blank outer frame panel for the left and right side */
module Outer_Frame_Depth_2D()
{
	translate([mT, 0, 0])
	{
		union()
		{
			/* Create fingerjoint tabs for the left and right side of the panel */
			Fingerjoint_Tabs_2D("LEFT", "ODD", ofH, oFFJC, mT);
			translate([cpY,0,0]) Fingerjoint_Tabs_2D("RIGHT","ODD", ofH, oFFJC, mT);
			difference()
			{
				/* Main body */
				square([cpY, ofH]);
				/* Cut out gaps for the inner frame to slot into */
				/* TODO: I could common this... */
				translate([0, bfH /2 + bwH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpY, iFDFJC, mT2*2);
				translate([0, bfH/2 + bwH + sH, 0])
				Fingerjoint_Slots_2D("HORIZONTAL", "ODD", cpY, iFDFJC, mT2*2);
			}
		}
	}
}


module Outer_Frame_Length_Top_L1_2D()
{
	spacing = 6;
	difference()
	{
		Outer_Frame_Length_2D();
		translate([cpX * tPBP, ofH/2, 0]) 
		{
			OBSF24_L_Hole();
			translate([(24 + tPBS), 0, 0]) OBSF24_L_Hole();	
			translate([-(24 + tPBS), 0, 0]) OBSF24_L_Hole();	
		}
		translate([cpX * tPNP, ofH/2, 0])
		{
			square([26, 31], true);
		}
	}
}

module Outer_Frame_Length_Top_L2_2D()
{
	difference()
	{
		Outer_Frame_Length_2D();
		translate([cpX * tPBP, ofH/2, 0]) 
		{
			OBSF24_L_Hole(3);
			translate([(24 + tPBS), 0, 0]) OBSF24_L_Hole(3);	
			translate([-(24 + tPBS), 0, 0]) OBSF24_L_Hole(3);	
		}
		translate([cpX * tPNP, ofH/2, 0])
		{
			circle(d=24);
			translate([+(19/2), -12, 0]) circle(d=3.2);
			translate([-(19/2), 12, 0]) circle(d=3.2);
		}
	}
}

/* Panel for top and bottom */
module Panel_2D(hS=sHS)
{
	difference()
	{
		square(cpD);
		/* Cut out holes for screws */
		Standoff_Positions() circle(d=hS);
	}
}

module Control_Panel_Layer_2D()
{
	difference()
	{
		Panel_2D();
		translate([cpX/2, cpY/2 + 12, 0]) children(0);
	}
}

module Test_Fit()
{
	translate([mT, mT, 0])
	{
		/* Foam Layer */
		/* TODO: Magic Number... */
		color("black") linear_extrude(bfH) Panel_2D(8);
		/* Sheet Wood Bottom Panel */
		translate([0, 0, bfH]) linear_extrude(mT) Panel_2D();
	}

	/* Outer Frame */
	translate([0, 0, bfH /2])
	{
		#rotate([90, 0, 90]) linear_extrude(mT) Outer_Frame_Depth_2D();
		#translate([cpX + mT, 0, 0]) rotate([90, 0, 90]) linear_extrude(mT) Outer_Frame_Depth_2D();
		translate([0, mT, 0])
		{
			/* Top Wall */
			#rotate([90, 0, 0]) linear_extrude(mT) Outer_Frame_Length_2D();
Outer_Frame_Length_Top_L1_2D();
			translate([0, cpY + mT2, 0]) rotate([90, 0, 0]) 
			{
				#linear_extrude(mT2) Outer_Frame_Length_Top_L1_2D();
				translate([0,0,-mT2])linear_extrude(mT2) Outer_Frame_Length_Top_L2_2D();
				/* Start Select Home Buttons */
				rotate([180, 0, 0]) translate([cpX * tPBP + (24 + tPBS), -ofH/2, 0])  OBSF24_3D();
				rotate([180, 0, 0]) translate([cpX * tPBP , -ofH/2, 0])  OBSF24_3D();
				rotate([180, 0, 0]) translate([cpX * tPBP - (24 + tPBS), -ofH/2, 0])  OBSF24_3D();
			}
		}
	}
	
	translate([0, 0, bpH])	// Space for bottom panel
	{
		
		/* Bottom inner frame layer */
		linear_extrude(mT2) Inner_Frame_Layer_2D() circle(d=sHS); 
		
		translate([0, 0, mT2]) 
		{
			/* Inner Layer of Frame, has cutout of standoffs to ensure a locking fit */
			linear_extrude(mT2) Inner_Frame_Layer_2D() HexStandoff_2D(sWS, 0);//S_970500451_2D(0);
			/* Standoffs */
			translate([mT, mT, 0]) Standoff_Positions() HexStandoff_3D(sWS, sHS, sH, sTL); //S_970500451();
		}
		translate([0, 0, sH])
		{
			/* Top Inner Frame Layers */
			linear_extrude(mT2) Inner_Frame_Layer_2D() S_970500451_2D(0);
			translate([0,0,mT2]) linear_extrude(mT2) Inner_Frame_Layer_2D() circle(d=sHS); 
			
			/* Control Panel */
			translate([mT, mT, mT2 * 2])
			{
				linear_extrude(mT) 
					Control_Panel_Layer_2D() 
					{ 
						SegaAstroP2_8B_Layout() 
						{ 
							JLFP1_L_Holes();
							OBSF30_L_Hole();
						} 
					};
				translate([0, 0, mT])
				{
					linear_extrude(mT2) 
						Control_Panel_Layer_2D()
						{
							SegaAstroP2_8B_Layout() 
							{ 
								JLFTP8YT_L_CPHole();
								OBSF30_L_Hole();
							}
						};

					/* Buttons */
					translate([cpX/2,cpY/2 +12,3])
					SegaAstroP2_8B_Layout() 
					{ 
						circle(0);
						OBSF30_3D(cp=mbpc, cs=mbsc);
					}
				}
			}
		}
	}
}

/* Individual Layouts */

// mT mm
Control_Panel_Layer_2D() SegaAstroP2_8B_Layout() { JLFP1_L_Holes(); OBSF30_L_Hole(); }
//Outer_Frame_Depth_2D();
//Outer_Frame_Depth_2D();	
//Outer_Frame_Length_2D();

/* TODO Create Bottom with Holes for PCB Mounting */


// mT2 mm
//Control_Panel_Layer_2D() SegaAstroP2_8B_Layout() { JLFTP8YT_L_CPHole(); OBSF30_L_Hole(); }
//Inner_Frame_Layer_2D() circle(d=sHS);
//Inner_Frame_Layer_2D() circle(d=sHS);	
//Inner_Frame_Layer_2D() HexStandoff_2D(sWS, 0);
//Inner_Frame_Layer_2D() HexStandoff_2D(sWS, 0);
//Outer_Frame_Length_Top_L1_2D();
//Outer_Frame_Length_Top_L2_2D();
/* TODO: Top Panel */
//Test_Fit();

module 3mm_Print_1()
{
	#square([400, 600]);
	translate([5, 5, 0])
	{
		Outer_Frame_Length_Top_L1_2D();
		translate ([0, 75, 0])
		Outer_Frame_Length_Top_L2_2D();
		translate([0, 150, 0])
		Inner_Frame_Layer_2D() HexStandoff_2D(sWS, 0);
		translate([0, 370, 0])
		Inner_Frame_Layer_2D() HexStandoff_2D(sWS, 0);
	}
}

module 3mm_Print_2()
{
	#square([400, 600]);
	translate([5, 5, 0])
	{
		Inner_Frame_Layer_2D() circle(d=sHS);
		translate([0, 220, 0])
		Inner_Frame_Layer_2D() circle(d=sHS);	
	}
}

//3mm_Print_1();
//translate([410, 0, 0]) 3mm_Print_2(); 
