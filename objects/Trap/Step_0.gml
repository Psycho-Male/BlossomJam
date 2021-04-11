if object_index==obj_swamp_trap2{
    if triggered{
        if sprite_index==spr_swamp_trap2{
            sprite_index=spr_swamp_trap2_active;
            image_index=0;
        }else{
            if animEnd{
                triggered=false;
                sprite_index=spr_swamp_trap2;
                image_index=0;
            }
        }
    }
}
