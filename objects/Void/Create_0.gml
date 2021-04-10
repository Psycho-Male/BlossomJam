sprite={
    prv:noone,
    frame_prot:false,
    spawn:void_spawn,
    normal:void_normal,
    //end:void_normal,
    pull:void_pull,
}
function catch_enemy(){
    var _enemy=collision_rectangle(xprevious,y,x,y-sprite_height,Enemy,false,true);
    if instance_exists(_enemy){
        state=state_pull;
        speed=0;
        _enemy.image_xscale=sign(_enemy.x-x);
        _enemy.state=_enemy.pull.state;
        _enemy.image_index=0;
        return true;
    }else{
        return false;
    }
}
sprite_index=sprite.normal;
function state_spawn(){
    sprite_index=sprite.spawn;
    if animEnd{
        state=state_normal;
    }
    catch_enemy();
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
    catch_enemy();
}
function state_pull(){
    sprite_index=sprite.pull;
    if animEnd{
        instance_destroy();
    }
}
function state_end(){
    sprite_index=sprite.normal;
    if image_alpha>0{
        image_alpha-=.05;
    }else{
        instance_destroy();
    }
}
