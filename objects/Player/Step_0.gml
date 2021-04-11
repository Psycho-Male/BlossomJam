vcenter=y-15;
immunity_check();
if jumping>1 jumping--;
sprite.prv=sprite_index;
state();
if hsp!=0 image_xscale=sign(hsp);
FrameCheck();
ground_collision();
if !hlock x+=hsp;
if !vlock y+=vsp;
if GameController.debug&&kp_h{
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
