use <RegularPolygon.scad>
$fn=100;

// https://uk.farnell.com/wurth-elektronik/970500471/standoff-hex-female-female-50mm/dp/2884617
module S_970500451()
{
	// Thread Length
	TL = 10;
	SL = 50;
	HS = 4;
	union()
	{
		linear_extrude(SL) S_970500451_2D(HS);
		translate([0, 0, TL]) cylinder(d=HS+1, h=SL-(TL*2));
	}
}

module S_970500451_2D(HS=4)
{
	// Wrench Size (Side To Side Diameter)
	WS = 7;

	difference()
	{
		RegularPolygon_2D(6, HexConvert_SideToSide_CentreToVertex(WS));
		circle(d=HS);
	}
}