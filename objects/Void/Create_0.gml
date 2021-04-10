sprite={
    prv:noone,
    frame_prot:false,
    spawn:void_spawn,
    normal:void_normal,
    //end:void_normal,
    hit:void_hit,
}
sprite_index=sprite.normal;
function state_spawn(){
    sprite_index=sprite.spawn;
    if animEnd{
        state=state_normal;
    }
}
function state_normal(){
    sprite_index=sprite.normal;
    //Check collision
    //if instance_meeting(x,y,Enemy){
    //  speed=0;
    //  state=state_pull;
    //}
    if speed=0{
        state=state_end;
    }
}
function state_pull(){
    sprite_index=sprite.void_pull;
}
function state_end(){
    sprite_index=sprite.normal;
    if image_alpha>0{
        image_alpha-=.05;
    }else{
        instance_destroy();
    }
}
