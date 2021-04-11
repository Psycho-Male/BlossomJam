vcenter=y-15;
if state!=state_fade{
    immunity_check();
}
if jumping>1 jumping--;
sprite.prv=sprite_index;
state();
if hsp!=0 image_xscale=sign(hsp);
FrameCheck();
ground_collision();
if !hlock x+=hsp;
if !vlock y+=vsp;
if instance_exists(GameController)&&GameController.debug&&kp_h{
    hit(noone);
}
AddGuiMessage("x: "+str(x));
AddGuiMessage("y: "+str(y));
if x>room_width||y>room_height{
    with SpawnPoint{
        other.hp--;
        other.x=x;
        other.y=y;
    }
}
collectible_detect();
if charge.powerup{
    if charge.powerup_t<=0{
        charge.powerup=false;
    }
    charge.powerup_t--;
}
if state!=state_fade{
    detect_portal();
}
detect_trap();
