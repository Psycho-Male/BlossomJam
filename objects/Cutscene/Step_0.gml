if audio_is_playing(au_music1){
    audio_stop_sound(au_music1);
}
if !audio_is_playing(au_music2){
    audio_play_sound(au_music2,1,true);
}
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
