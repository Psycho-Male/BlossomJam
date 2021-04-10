//collison_map=layer_tilemap_get_id(layer_get_id("Collision"));
vcenter=y-sprite_height/2;
msp=Input.shift?msp_sprint:msp_run;
if Input.right{
    hsp_target=msp;
}else if Input.left{
    hsp_target=-msp;
}else{
    hsp_target=0;
}
sprite_prv=sprite_index;
state();
if sprite_prv!=sprite_index{
    image_index=0;
}
//onground=tilemap_get_at_pixel(collision_map,x,y+vsp)!=-1;
if !onground{
    onground=position_meeting(x,y+vsp,Collision);
    if onground{
        while !position_meeting(x,y,Collision){
            y++;
        }
        vsp=0;
    }
}else{
    onground=position_meeting(x,y+vsp,Collision);
}
if hsp!=0 image_xscale=sign(hsp);
    var _bbox;
    if image_xscale==-1 _bbox=bbox_left;
    if image_xscale==1  _bbox=bbox_right;
    while !position_meeting(_bbox,vcenter,Collision){
        x++;
    }
    hsp=0;
}
x+=hsp;
y+=vsp;
hsp=approach(hsp,hsp_target,hsp_a);
