if animEnd{
    switch sprite_index{
        case spr_cutscene_end1:
        sprite_index=spr_cutscene_end2;
        image_index=0;
        break;case spr_cutscene_end2: 
        sprite_index=spr_cutscene_end3;
        image_index=0;
        break;case spr_cutscene_end3: 
        instance_destroy(all);
        room_goto(rm_init);
        break;
    }
}
