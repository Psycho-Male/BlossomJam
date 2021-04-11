function approach(c,t,a){
    if (c < t) {
        c = min(c+a, t); 
    }else{
        c = max(c-a, t);
    }
    return c;
}
function ThrowVoid(_x,_y,_dir,_spd){
    var _void=instance_create_layer(_x,_y,"Instances",Void);
    with _void{
        image_xscale=_dir;
        direction=_dir==1?0:180;
        speed=_spd;
        friction=.1;
        spawn_pos=[x,y];
        t=0;
        tt=640;
        state=state_spawn;
    }
}
function FrameCheck(){
    if sprite.frame_prot{
        sprite.frame_prot=false;
    }else if sprite.prv!=sprite_index{
        image_index=0;
        image_speed=1;
    }
}
function InputLock(_hlock,_vlock){
    Input.hlock=_hlock;
    Input.vlock=_vlock;
}
function InputRelease(){
    Input.hlock=false;
    Input.vlock=false;
}
function InputActionLock(){
    Input.action_lock=true;
}
function InputActionRelease(){
    Input.action_lock=false;
}
function SfxPlay(_index,_loop){
    if is_undefined(_loop) _loop=false;
    if audio_exists(_index){
        return audio_play_sound(_index,1,false);
    }
}
function GetHitbox(_x,_y,_id){
    with instance_create_layer(_x,_y,"Instances",obj_hitbox){
        owner=_id;
        return id;
    }
}
function CheckHCollision(){
    if hsp!=0{
        if object_index==Player{
            var _bbox=image_xscale==1?bboxRight:bboxLeft;
        }else{
            var _bbox=image_xscale==1?bboxLeft:bboxRight;
        }
        var _hsp=hsp+sign(hsp);
        var _collided=position_meeting(_bbox+_hsp,y-2,Collision);
        if _collided{
            AddGuiMessage("HCollided");
            hsp=0;
            return true;
        }
    }
    return false;
}
