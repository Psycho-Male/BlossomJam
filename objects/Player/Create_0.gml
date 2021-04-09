movement={
    hsp:0,
    vsp:0,
    jump:false,
    grav:0,
    jump_v:12,
    reset:function(){
        hsp=0;
        vsp=0;
    },
    jump:function(){
        jumping=true;
        grav=1;
        grav_v=.5;
    },
    touchdown:function(){
        jumping=false;
        vsp=0;
        grav=0;
    },
    onground=true;
}
function movement(){
    if Input.any{
        hsp=Input.right-Input.left;
        if Input.action2||Input.up{
            movement.jump();
        }
    }
    movement.reset();
}
function state_normal(){
    movement();
    if jumping{
        state=state_jump;
        vsp=jump_v;
    }
}
function state_jump(){
    vsp+=grav_v;
    if vsp>=0
}
function state_drop(){
    vsp=grav;
    grav+=grav_v;
    if onground{
        if vsp>0{
            vsp=0;
            y+=y%16;
        }
        movement.touchdown();
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
