sprite={
    prv:noone,
    frame_prot:false,
}
detector=instance_create_layer(x,y-sprite_height/2,"Instances",obj_detector);
detector.owner=id;
detector.image_xscale=detection_range/4;
detector.image_yscale=sprite_height/4;

target_found=false;
hsp=0;
vsp=0;
vcenter=0;
hitbox=noone;
//------\\
//States||
//-----//
normal={
    t:0,
    tt:360,
    msp:1,
    dir:1,
    state:function(){
        if other.target_found{
            other.state=other.chase.state;
        }else{
            if t>tt{
                dir*=-1;
                t=0;
            }else if t>tt/2{
                other.sprite_index=other.spr_walk;
                other.hsp=dir*msp;
            }else{
                other.sprite_index=other.spr_idle;
            }
            t++;
        }
    },
}
chase={
    msp:1,
    dir:1,
    state:function(){
        dir=sign(Player.x-other.x);
        other.hsp=dir*msp;
        if !other.target_found{
            other.state=other.normal.state;
        }else if abs(Player.x-other.x)<=other.attack_range/2{
            other.state=other.attack.state;
        }
    },
}
attack={
    force_reset:12,
    force:6,
    force_v:1,
    func:function(){
        other.hsp=-force*other.image_xscale;
        other.state=state;
    },
    reset:function(){
        force=force_reset;
    },
    state:function(){
        other.sprite_index=other.spr_attack;
        with other{
            if image_index>=hit_frame_first&&image_index<hit_frame_last{
                if !instance_exists(hitbox){
                    hsp=-other.force*image_xscale;
                    hitbox=GetHitbox(x,vcenter,id);
                }
            }else if instance_exists(hitbox){
                instance_destroy(hitbox);
                hsp=0;
            }
        }
        if otherAnimEnd{
            reset();
            other.state=other.normal.state;
        }
    },
}
tired={
    state:function(){
    },
}
//---\\
//END||
//--//
state=normal.state;
