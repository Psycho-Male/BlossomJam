bounce=false;
function state_normal(){
    image_index=0;
    sprite_index=sprite_normal;
    if bounce{
        state=state_bounce;
        SfxPlay(au_mushroom_bounce);
    }
}
function state_bounce(){
    sprite_index=sprite_bounce;
    if animEnd{
        state=state_normal;
        bounce=false;
    }
}
state=state_normal;
