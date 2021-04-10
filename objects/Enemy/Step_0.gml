vcenter=y-sprite_height/2;
sprite.prv=sprite_index;
state();
FrameCheck();
if hsp!=0 image_xscale=sign(hsp)*-1;
x+=hsp;
y+=vsp;
hsp=approach(hsp,0,1);
vsp=0;
