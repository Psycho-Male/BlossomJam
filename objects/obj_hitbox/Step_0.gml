if !instance_exists(owner){
    instance_destroy();
    exit;
}
x=owner.x;
y=owner.y;
if !hit_player{
    if !Player.immunity.active&&instance_place(x,y,Player){
        Player.hit(id);
        hit_player=true;
    }
}
