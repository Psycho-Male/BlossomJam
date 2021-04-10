if !instance_exists(owner){
    instance_destroy();
    exit;
}
x=owner.x;
y=owner.y;
if !hit_player{
    if instance_place(x,y,Player){
        hit_player=true;
    }
}
