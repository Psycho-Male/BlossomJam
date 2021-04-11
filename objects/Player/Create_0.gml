#macro animEnd          image_index>sprite_get_number(sprite_index)-1
#macro otherAnimEnd     other.image_index>sprite_get_number(other.sprite_index)-1
#macro sprHalfW         sprite_width/2
#macro sprHalfH         sprite_height/2
#macro bboxLeft         x-9
#macro bboxRight        x+9
#macro idFacing         image_xscale
#macro attOffsetX       26
#macro idVCenter        y-sprite_height/2
#macro voidPosY         y-8
#macro idAbove          y-15
layer_add_instance("Instances",id);
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
    corner_grab:player_corner_grab,
    wine_grab:player_wine_grab,
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
air_dashed=false;
hp=3;
onground=true;
jump_force=9;
shot=false;
corner=noone;
wine_prevent=false;
//---------\\
//Functions||
//--------//
function jump_buffer(){
    if (inpJump)&&!jump_buff_block{
        jumping=jumping_reset;
    }
}
function ground_check(_low){
    if is_undefined(_low) _low=false;
    if !onground&&corner==noone{
        vsp=_low?grav_low:grav;
        //grav+=_low?grav_v:grav_v;
        if onground{
            touchdown();
        }
    }
}
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
    return CheckHCollision();
}
function hsp_approach(_target,_spd){
    hsp=hsp_target;
    hsp_target=approach(hsp_target,_target,_spd);
}
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
function ground_collision(){
    if !onground&&corner=noone{
        onground=position_meeting(x,y+vsp,Collision);//||position_meeting(x,y+vsp,Slope);
        if onground{
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
function jump(){
    if kp_anykey&&(onground||corner!=noone)&&(inpJump){
        jump_buffer();
        //grav_v=.01;
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
    air_dashed=false;
    wine_prevent=false;
}
function corner_check(){
    if Input.left||Input.right{
        var _bbox=(Input.right-Input.left)==1?bboxRight+2:bboxLeft-2;
        if state==state_drop{
            corner=instance_position(_bbox+hsp,y+vsp,Corner);
        }else if state==state_jump{
            corner=instance_position(_bbox+hsp,idVCenter+vsp,Corner);
        }else if state==state_dash{
            corner=instance_position(_bbox+hsp,idVCenter,Corner);
        }else{
            return false;
        }
        if instance_exists(corner){
            if corner.image_xscale!=image_xscale*-1 return false;
            vsp=0;hsp=0;
            air_dashed=false;
            var _dir=sign(corner.x-x);
            x=_dir==1?corner.bbox_left:corner.bbox_right;
            y=corner.y+sprHalfH;
            state=state_hang;
            jumping=false;
            return true;
        }
    }
    return false;
}
function wine_check(){
    if !wine_prevent&&hsp!=0{
        var _bbox=image_xscale==1?bboxRight:bboxLeft;
        var _wine=noone;
        _wine=instance_position(_bbox+hsp,y+vsp,Wine);
        if instance_exists(_wine){
            air_dashed=false;
            _wine.depth=Player.depth+1;
            vsp=0;hsp=0;
            x=_wine.x;
            state=state_wine_hang;
            jumping=false;
            return true;
        }
    }
    return false;
}
//----\\
//DASH||
//---//
dash_force=6;
function dash(){
    if Input.dash{
        if state==state_jump||state==state_drop{
            if !air_dashed{
                air_dashed=true;
            }else{
                return false;
            }
        }
        //SfxPlay(sfx_dash);
        hsp_target=sign(image_xscale)*dash_force;
        state=state_dash;
        vsp=0;
        jumping=false;
        return true;
    }else{
        return false;
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
function hit(){
    immunity.active=true;
    jumping=false;
    vsp=0;
    if instance_exists(hurt.by){
        hsp+=hurt.hforce*sign(x-hurt.by.x);
        vsp+=hurt.vforce;
    }
    hp--;
    if hp<=0{
        state=state_death;
    }else{
        state=state_hurt_recover;
    }
}
function set_dir(){
    var _dir=Input.right-Input.left;
    if _dir!=0 image_xscale=_dir;
}
function state_precharge(){
    lock_movement(true,false);
    InputLock(false,true);
    ground_check(true);
    move();
    sprite_index=sprite.precharge;
    set_dir();
    if animEnd{
        if Input.action1{
            state=state_charge;
        }else{
            state=state_attack;
        }
    }
}
//-------\\
//Structs||
//------//
charge={
    mx:10,
    mn:6,
    v:.1,
    current:6,
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
//------\\
//States||
//------//
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
function state_dash(){
    lock_movement(false,true);
    if charge.func()||wine_check()||corner_check(){
        exit;
    }
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
    if CheckHCollision(){
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
    if CheckHCollision(){
        state=state_normal;
    }
}
function state_jump(){
    lock_movement(false,false);
    if charge.func()||dash()||corner_check()||wine_check(){
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
        //grav+=grav_v;
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
    }else{
        if !corner_check(){
            wine_check();
        }
    }
}
function state_hang(){
    lock_movement(true,true);
    sprite_index=sprite.corner_grab;
    var _release=false;
    if image_xscale==1{
        if kp_a{
            x-=8;
            _release=true;
        }
    }else{
        if kp_d{
            x+=8;
            _release=true;
        }
    }
    if _release{
        corner=noone;
        state=state_drop;
    }
    jump();
    if jumping{
        state=state_jump;
        vsp-=jump_force;
    }
}
function state_wine_hang(){
    lock_movement(true,false);
    sprite_index=sprite.wine_grab;
    if (kp_w||kp_k)&&(Input.left||Input.right){
        wine_prevent=true;
        jumping=true;
        state=state_jump;
        vsp-=jump_force;
    }else if Input.up||Input.down{
        vsp=(Input.down-Input.up)/2;
        if !position_meeting(x,y,Wine){
            state=state_drop;
        }
        image_speed=1;
    }else{
        vsp=0;
        image_speed=0;
    }
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
function state_death(){
    lock_movement(true,true);
    immunity.active=false;
    image_alpha=1;
    sprite_index=sprite.death;
    if animEnd{
        instance_destroy(all);
        room_goto(rm_init);
    }
}
function state_charge(){
    lock_movement(true,false);
    InputLock(false,true);
    ground_check(true);
    move();
    Camera.screenshake();
    charge.current=approach(charge.current,charge.mx,charge.v);
    AddGuiMessage("charge.current: "+str(charge.current));
    set_dir();
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
        image_index=0;
        state=state_attack;
    }
}
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
state=state_normal;
