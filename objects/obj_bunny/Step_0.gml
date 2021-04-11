switch round(image_index){
    case 1:
    hsp+=.3*dir;
    break;case 2:
    yoff=-1;
    break;case 3:
    yoff=-2;
    break;case 4:
    yoff=-3;
    break;case 5:
    yoff=-4;
    break;case 6:
    yoff=-3;
    break;case 7:
    yoff=-2;
    break;case 8:
    yoff=-1;
    break;case 9:
    hsp=0;
    break;
}
if hsp!=0 image_xscale=sign(hsp)*-1;
var _bbox=dir==1?bbox_right+hsp:bbox_left+hsp;
if !ignore_col&&instance_place(_bbox,y-2,Collision){
    if !changed_dir{
        changed_dir=true;
        dir*=-1;
    }
}
if changed_dir{
    if dir_t<=0{
        changed_dir=false;
        dir_t=120;
    }else{
        dir_t--;
    }
}
x+=hsp;
y+=vsp;
AddGuiMessage("hsp: "+str(hsp));
AddGuiMessage("dir: "+str(dir));
AddGuiMessage("image_xscale: "+str(image_xscale));
hsp=approach(hsp,0,.01);
if !place_meeting(x,y+vsp,Collision){
    vsp=3;
}else{
    vsp=0;
}
