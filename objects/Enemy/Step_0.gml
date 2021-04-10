vcenter=y-sprite_height/2;
sprite.prv=sprite_index;
state();
FrameCheck();
if hsp!=0 image_xscale=sign(hsp)*-1;
if state!=pull.state{
    x+=hsp;
    y+=vsp;
    var _v=state==tired.state?.1:.01;
    hsp=lerp(hsp,0,_v);
    vsp=position_meeting(x,y+vsp,Collision)?1:0;
}
