module NE8FDP_Cutout_2D()
{
	cD = [26, 31];
	square(cD, true);
}

module NE8FDP_Holes_2D()
{
	circle(d=24);
	translate([9.5, -12, 0]) circle(d=3.2);
	translate([-9.5, 12, 0]) circle(d=3.2);
}
