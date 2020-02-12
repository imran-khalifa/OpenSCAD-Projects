function HexConvert_Apothem_CentreToVertex(a = 1) = (a * 2) / sqrt(3);
function HexConvert_Apothem_VertexToVertex(a = 1) = HexConvert_Apothem_CentreToVertex(a) * 2;
function HexConvert_SideToSide_CentreToVertex(a = 1) = a / sqrt(3);
function HexConvert_SideToSide_VertexToVertex(a = 1) = HexConvert_SideToSide_CentreToVertex(a) * 2;

/* Used to create regular polygons */
module RegularPolygon_2D(order = 4, r=1)
{
	angles=[ for (i = [0:order-1]) i*(360/order) ];
	coords=[ for (th=angles) [r*cos(th), r*sin(th)] ];
	polygon(coords);
}