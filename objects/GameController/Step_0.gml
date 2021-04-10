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
        }
    }
}
if mp_left1{
    instance_create_layer(SpawnPoint.x,SpawnPoint.y,"Instances",Enemy1);
}
if kp_tab{
    debug=!debug;
}
