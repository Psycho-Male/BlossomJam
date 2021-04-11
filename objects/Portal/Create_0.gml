triggered=false;
function state_normal(){
    sprite_index=spr_idle;
    if triggered{
        state=state_active;
        image_index=0;
    }
}
function state_active(){
    sprite_index=spr_teleport;
    if animEnd{
        Player.image_alpha=1;
        room_goto_next();
    }
}
state=state_normal;
