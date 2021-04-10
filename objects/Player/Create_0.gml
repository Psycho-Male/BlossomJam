sprite={
    idle:player_idle,
    run:player_run,
    fall:player_fall,
    jump:player_jump,
}
sprite_index=sprite.idle;
sprite_prv=sprite_index;
hsp=0;
vsp=0;
jump=false;
jumping=false;
msp_run=2;
msp_sprint=4;
hsp_a=.1;
hps_target=0;
grav=.5;
grav_v=.01;
function jump(){
    jumping=true;
    grav=.5;
    grav_v=.01;
}
function touchdown(){
    jumping=false;
    vsp=0;
    grav=0;
    state=state_normal;
}
onground=true;
jump_force=12;
function state_normal(){
    state_text="Normal";
    if Input.action2||Input.up{
        jump();
    }
    sprite_index=hsp==0?sprite.idle:sprite.run;
    if jumping{
        state=state_jump;
        vsp-=jump_force;
    }else if !onground{
        state=state_drop;
    }
}
function state_jump(){
    state_text="Jump";
    sprite_index=sprite.jump;
    if vsp>=0{
        state=state_drop;
    }else{
        vsp=approach(vsp,0,grav);
        grav+=grav_v;
    }
}
function state_drop(){
    state_text="Drop";
    sprite_index=sprite.fall;
    vsp+=grav;
    grav+=grav_v;
    if onground{
        touchdown();
    }
}
function state_land(){
}
function state_charge(){
}
function state_attack(){
}
function state_damage(){
}
state=state_normal;
collision_map=noone;
