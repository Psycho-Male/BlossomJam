if debug{
    if kp_o{
        if room==room_last{
            room_goto(rm_stage1);
        }else{
            if room_next(room)!=-1{
                room_goto_next();
            }
        }
    }
    if kp_r{
        instance_destroy(all);
        room_goto(rm_init);
    }
}
if mc_right1{
    if !instance_exists(Void){
        with instance_create_layer(mouse_x,mouse_y,"Instances",Void){
            image_xscale=1;
            direction=0;
            speed=0;
            friction=.1;
            spawn_pos=[x,y];
            t=0;
            tt=640;
            state=state_spawn;
        }
    }else{
        with Void{
            x=mouse_x;
            y=mouse_y;
            if state!=state_normal{
                state=state_normal;
            }
            if !instance_exists(obj_hitbox) GetHitbox(x,y,id);
        }
    }
}
if mp_left1&&kc_shift{
    instance_create_layer(SpawnPoint.x,SpawnPoint.y,"Instances",Enemy1);
}
if kp_tab{
    debug=!debug;
}
