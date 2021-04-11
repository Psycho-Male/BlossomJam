objective_count=instance_number(Enemy)
collision=instance_create_layer(x,y,"Instances",Collision);
collision.image_xscale=sprite_width/collision.sprite_width;
collision.image_yscale=sprite_height/collision.sprite_height;
collision.y-=collision.sprite_height/2;
function state_normal(){
    sprite_index=spr_idle;
    if objective_count<=0{
        state=state_active;
    }
}
function state_active(){
    sprite_index=spr_active;
    if animEnd{
        instance_destroy();
        instance_destroy(collision);
    }
}
state=state_normal;
draw_x=x-sprite_width/2;
draw_y=y+16;
