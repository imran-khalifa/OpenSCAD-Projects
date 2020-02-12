module Fingerjoint_Tabs_2D(direction="DOWN",
                           skip="EVEN",
                           total_length,
                           tab_count,
                           depth,
                           tolerance = 0)
{
    /* Sets where to start drawing from based on direction */
    start_y = (direction == "DOWN" || direction == "RIGHT") ? -depth : -1;
    rot_val = (direction == "LEFT" || direction == "RIGHT") ? [0,0,90] : [0,0,0];

    /* Get length of each tab */
    tab_length = total_length / tab_count;

    rotate(rot_val)
    {   
        translate([0, start_y, 0])
        {   
            skip_val = (skip == "ODD") ? 1 : 0;
            for(i=[0:1:tab_count-1])
            {
            
                translate([(i * tab_length) + tolerance, 0, 0])
                {
                    if(i % 2 == skip_val) square([tab_length - tolerance * 2, depth + 1]);
                }
            }
        }
    }
}

module Fingerjoint_Slots_2D(direction,
                            skip,
                            total_length,
                            slot_count,
                            slot_height,
                            tolerance=0)
{
    rot_val = (direction == "VERTICAL") ? [0,0,90] : [0,0,0];
    slot_length = total_length / slot_count;

    rotate(rot_val)
    {
        skip_val = (skip == "ODD") ? 1 : 0;
        for(i=[0:1:slot_count-1])
        {
            translate([(i * slot_length) + tolerance, 0, 0])
            {
                if(i % 2 == skip_val) square([slot_length - tolerance * 2, slot_height]);
            }
        }
    }
}

Fingerjoint_Slots_2D("HORIZONTAL", "ODD", 100, 9, 6);