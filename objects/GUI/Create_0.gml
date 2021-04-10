heart_scale=4;
function get_heart(_x,_y){
    with InstanceCreate(obj_gui_heart){
        sprite={
            normal:spr_heart_normal,
            brk:spr_heart_break,
        }
        x=_x;
        y=_y;
        image_xscale=other.heart_scale;
        image_yscale=other.heart_scale;
        sprite_index=sprite.normal;
        function hurt(){
            state=state_break;
            image_index=0;
        }
        function state_normal(){
            sprite_index=sprite.normal;
        }
        function state_break(){
            sprite_index=sprite.brk;
            if animEnd{
                instance_destroy();
            }
        }
        state=state_normal;
        return id;
    }
}
hearts=ds_list_create();
ds_list_add(hearts,
get_heart(32+(16*0*heart_scale),32),
get_heart(32+(16*1*heart_scale),32),
get_heart(32+(16*2*heart_scale),32),
);
