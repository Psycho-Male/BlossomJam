#macro animEnd          image_index>sprite_get_number(sprite_index)-1
#macro otherAnimEnd     other.image_index>other.sprite_get_number(other.sprite_index)-1
#macro sprHalfW         sprite_width/2
#macro sprHalfH         sprite_height/2
#macro bboxLeft         x-9
#macro bboxRight        x+9
#macro idFacing         image_xscale
#macro attOffsetX       26
#macro idVcenter        y-sprite_height/2
#macro voidPosY         y-8
#macro idAbove          y-15
sprite={
    prv:noone,
    frame_prot:false,
    idle:player_idle,
    run:player_run,
    fall:player_fall,
    jump:player_jump,
    dash:player_dash,
    dash_recover:player_dash_recover,
    death:player_death,
    precharge:player_precharge,
    charge:player_charge,
    charge_full:player_charge_full,
    attack:player_attack,
    hurt:player_hurt,
}
sprite_index=sprite.idle;
hsp=0;
vsp=0;
jump=false;
jumping=false;
jumping_reset=5;
msp=2;
hsp_a=.1;
hps_target=0;
grav_reset=.5;
grav_low=.5;
grav=grav_reset;
grav_v=.01;
grav_lowv=.005;
acc_lerp=.1;
immune=false;
hlock=false;
vlock=false;
coyt_reset=5;
coyt=coyt_reset;
drop_buffer_reset=5;
drop_buffer=drop_buffer_reset;
vcenter=0;
jump_buff_block=false;
function lock_movement(_hlock,_vlock){
    hlock=_hlock;
    vlock=_vlock;
}
function lerp_increase(){
    acc_lerp=approach(acc_lerp,1,.1);
}
function lerp_decrease(){
    acc_lerp=approach(acc_lerp,0,.1);
    if acc_lerp>0{
        return true;
    }else{
        return false;
    }
}
function move(){
    if Input.right{
        hsp_target=msp;
        hsp=lerp(hsp,hsp_target,acc_lerp);
        lerp_increase();
    }else if Input.left{
        hsp_target=-msp;
        hsp=lerp(hsp,hsp_target,acc_lerp);
        lerp_increase();
    }else{
        if lerp_decrease(){
            hsp=lerp(hsp,0,acc_lerp);
        }else{
            hsp=0;
        }
    }
    return check_hcollision();
}
function hsp_approach(_target,_spd){
    hsp=hsp_target;
    hsp_target=approach(hsp_target,_target,_spd);
}
//----\\
//DASH||
//---//
dash_force=8;
function dash(){
    SfxPlay(sfx_dash);
    if Input.shift{
        hsp_target=sign(image_xscale)*dash_force;
        state=state_dash;
        vsp=0;
        jumping=false;
        return true;
    }else{
        return false;
    }
}
function state_dash(){
    lock_movement(false,true);
    if Input.left{
        hsp_target-=.1;
    }else if Input.right{
        hsp_target+=.1;
    }
    if abs(hsp_target)>4{
        hsp_approach(0,.2);
        sprite_index=sprite.dash;
    }else{
        if onground{
            state=state_dash_recover;
        }else{
            state=state_drop;
        }
        image_index=0;
    }
    if check_hcollision(){
        state=state_normal;
    }
    jump();
    if jumping>0{
        state=state_jump;
    }
}
function state_dash_recover(){
    lock_movement(false,false);
    sprite_index=sprite.dash_recover;
    hsp_approach(0,.2);
    AddGuiMessage("image_index: "+str(image_index));
    if !onground||image_index>sprite_get_number(sprite_index)-1{
        state=state_normal;
    }
    if check_hcollision(){
        state=state_normal;
    }
}
//----------\\
//HCollision||
//---------//
function check_hcollision(){
    if hsp!=0{
        var _bbox=image_xscale==1?bboxRight:bboxLeft;
        var _hsp=hsp+sign(hsp);
        //var _slope=instance_position(_bbox+_hsp,y-1,Slope);
        //if instance_exists(_slope){
        //    if Input.right{
        //        hsp=lengthdir_x(hsp,45);
        //        vsp=lengthdir_y(vsp,45);
        //    }
        //    AddGuiMessage("Slope Collided");
        //    return true;
        //}else{
            var _collided=position_meeting(_bbox+_hsp,y-2,Collision);
            if _collided{
                AddGuiMessage("HCollided");
                hsp=0;
                return true;
            }
        //}
    }
    return false;
}
//---------------\\
//Above Collision||
//--------------//
function above_collision(){
    if vsp<0&&place_meeting(x,idAbove+vsp,Collision){
        while !place_meeting(x,idAbove,Collision){
            y--;
        }
        jumping=false;
        vsp=0;
        jump_buff_block=true;
        return true;
    }
}
//----------------\\
//Ground Collision||
//---------------//
function ground_collision(){
    if !onground{
        onground=position_meeting(x,y+vsp,Collision);//||position_meeting(x,y+vsp,Slope);
        if onground{
            //var _col=position_meeting(x,y+vsp,Collision)?instance_position(x,y+vsp,Collision):instance_position(x,y+vsp,Slope);
            while !position_meeting(x,y,Collision){
                y++;
            }
            vsp=0;
        }
    }else{
        if position_meeting(x,y+vsp,Collision){
            coyt=coyt_reset;
            onground=true;
        }else{
            onground=coyt>0;
            coyt--;
        }
    }
}
//--------------------------------------------------\\
//||
//--------------------------------------------------//
function jump(){
    if onground&&(inpJump){
        jump_buffer();
        grav_v=.01;
        return true;
    }else{
        return false;
    }
}
function touchdown(){
    jump_buff_block=false;
    vsp=0;
    state=state_normal;
    grav=grav_reset;
    drop_buffer=drop_buffer_reset;
    if jumping>1{
        jump();
    }else{
        jumping=false;
    }
}
onground=true;
jump_force=12;
function state_normal(){
    lock_movement(false,false);
    if charge.func(){
        exit;
    }
    move();
    state_text="Normal";
    jump();
    dash();
    sprite_index=hsp==0?sprite.idle:sprite.run;
    if jumping{
        state=state_jump;
        vsp-=jump_force;
    }else if !onground{
        state=state_drop;
    }
}
function state_jump(){
    lock_movement(false,false);
    if charge.func()||dash(){
        exit;
    }
    move();
    jump_buffer();
    state_text="Jump";
    sprite_index=sprite.jump;
    if vsp>=0||above_collision(){
        state=state_drop;
    }else{
        vsp=approach(vsp,0,grav);
        grav+=grav_v;
    }
}
function state_drop(){
    lock_movement(false,false);
    if charge.func()||dash(){
        exit;
    }
    jump_buffer();
    move();
    state_text="Drop";
    if drop_buffer<=0{
        sprite_index=sprite.fall;
    }else{
        drop_buffer--;
    }
    vsp+=grav;
    grav+=grav_v;
    if onground{
        touchdown();
    }
}
hurt={
    by:noone,
    vforce:2,
    hforce:5,
    tt:5,
    t:5,
}
immunity={
    active:false,
    tt:120,
    t:120,
    reset:function(){
        t=tt;
    }
}
function hit(){
    immunity.active=true;
    jumping=false;
    vsp=0;
    if instance_exists(hurt.by){
        hsp+=hurt.hforce*sign(x-hurt.by.x);
        vsp+=hurt.vforce;
    }
    state=state_hurt_recover;
}
function state_hurt_recover(){
    lock_movement(false,false);
    sprite_index=sprite.hurt;
    hurt.t--;
    if hurt.t<=0{
        state=state_normal;
        hurt.t=hurt.tt;
    }
}
function immunity_check(){
    with immunity{
        if active{
            other.image_alpha=.5;
            if t<=0{
                active=false;
                reset();
            }
            t--;
            return true;
        }else{
            other.image_alpha=1;
            return false;
        }
    }
}
//------\\
//Attack||
//-----//
function state_precharge(){
    lock_movement(true,false);
    InputLock(true,true);
    ground_check(true);
    move();
    sprite_index=sprite.precharge;
    if animEnd{
        if Input.action1{
            state=state_charge;
        }else{
            state=state_attack;
        }
    }
}
charge={
    mx:6,
    mn:2,
    v:.1,
    current:2,
    tt:30,
    t:0,
    func:function(){
        if Input.action1{
            with other{
                if state!=state_charge{
                    image_index=0;
                    vsp=0;
                    jumping=false;
                    state=state_precharge;
                }
            }
            return true;
        }else{
            return false;
        }
    },
}
function state_charge(){
    lock_movement(true,false);
    InputLock(true,true);
    ground_check(true);
    move();
    Camera.screenshake();
    charge.current=approach(charge.current,charge.mx,charge.v);
    AddGuiMessage("charge.current: "+str(charge.current));
    if charge.current==charge.mx{
        charge.t++;
        if charge.t%charge.tt<charge.tt/2{
            sprite.frame_prot=true;
            sprite_index=sprite.charge;
        }else{
            sprite.frame_prot=true;
            sprite_index=sprite.charge_full;
        }
    }else{
        sprite_index=sprite.charge;
    }
    if !Input.action1{
        Camera.rumble.reset();
        state=state_attack;
    }
}
shot=false;
function state_attack(){
    lock_movement(true,false);
    InputLock(true,true);
    ground_check(true);
    move();
    sprite_index=sprite.attack;
    if !shot&&image_index>=4{
        ThrowVoid(x+sign(idFacing)*attOffsetX,voidPosY,idFacing,charge.current);
        shot=true;
        charge.current=charge.mn;
    }
    if animEnd{
        state=state_normal;
        shot=false;
        grav=grav_reset;
        InputRelease();
    }
}
function ground_check(_low){
    if is_undefined(_low) _low=false;
    if !onground{
        vsp=_low?grav_low:grav;
        grav+=_low?grav_v:grav_v;
        if onground{
            touchdown();
        }
    }
}
state=state_normal;
function jump_buffer(){
    if (inpJump)&&!jump_buff_block{
        jumping=jumping_reset;
    }
}
