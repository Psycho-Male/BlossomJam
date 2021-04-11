focus_instance=Player.id;
view_enabled=true;
function update(){
    x=focus_instance.x-view_width/2;
    y=focus_instance.vcenter-view_height/2;
    width=camera_get_view_width(view_camera[0]);
    height=camera_get_view_height(view_camera[0]);
    right=x+width;
    bottom=y+height;
    hcenter=x+width/2;
    vcenter=y+height/2;
    gui_w=display_get_gui_width();
    gui_h=display_get_gui_height();
}
view_width=683;
view_height=348;
//window_set_size(view_width,view_height);
alarm[0]=1;
for(var i = 1; i <= room_last; i++) {
    if(room_exists(i)) {    
        Trace(room_get_name(i));
        room_set_viewport(i,0,true,0,0,view_width,view_height);
        room_set_view_enabled(i,true);
    }
}
camera_set_view_pos (view_camera[0],x,y);
camera_set_view_size(view_camera[0],view_width,view_height);
update();
gui_message=[""];
//-----------\\
//Screenshake||
//----------//
rumble={
    reset:function(){
        x=0;
        y=0;
        value=0;
    },
    v:.05,
    mx:2,
}
rumble.reset();
function screenshake(){
    with rumble{
        value=approach(value,mx,v);
        x=choose(-value,value);
        y=choose(-value,value);
    }
    AddGuiMessage("rumble.value: "+str(rumble.value));
    AddGuiMessage("rumble.x: "+str(rumble.x));
    AddGuiMessage("rumble.y: "+str(rumble.y));
}
//--------\\
//Parallax||
//-------//
layers=noone;
layerpos=noone;
