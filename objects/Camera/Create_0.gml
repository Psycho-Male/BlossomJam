focus_instance=Player.id;
view_enabled=true;
function update(){
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
update();
