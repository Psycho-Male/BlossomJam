if instance_exists(owner){
    x=owner.x;
    y=owner.y-owner.sprite_height/2;
}
if instance_place(x,y,Player){
    owner.target_found=true;
}else{
    owner.target_found=false;
}
