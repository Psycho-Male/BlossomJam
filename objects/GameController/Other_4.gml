if room==rm_init{
    for(var i=0;i<array_length(controller_instances);i++){
        with InstanceCreate(controller_instances[i]){
            persistent=true;
        }
    }
    room_goto(room_begin);
    audio_group_set_gain(audiogroup_default,.5,0);
    InputLock(false,false);
    InputActionRelease();
    if audio_is_playing(au_music2){
        audio_stop_sound(au_music2);
    }
    if !audio_is_playing(au_music1){
        audio_play_sound(au_music1,1,true);
    }
    audio_sound_gain(bgm,.5,0);
}
