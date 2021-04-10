//AddGuiMessage("x: "+str(x));
//AddGuiMessage("y: "+str(y));
//AddGuiMessage("width: "+str(width));
//AddGuiMessage("height: "+str(height));
//AddGuiMessage("focus_instance: "+str(focus_instance));
//AddGuiMessage("view_camera[0]: "+str(view_camera[0]));
//AddGuiMessage("active camera: "+str(camera_get_active()));
//AddGuiMessage("view_enabled: "+str(view_enabled));
//AddGuiMessage("Collision: "+str(layer_tilemap_get_id(layer_get_id("Collision"))));
//AddGuiMessage("BG: "+str(layer_tilemap_get_id(layer_get_id("BG"))));
with Player{
    AddGuiMessage("Hsp: "+str(hsp));
    AddGuiMessage("Vsp "+str(vsp));
    AddGuiMessage("hlock: "+str(hlock));
    AddGuiMessage("vlock: "+str(vlock));
    AddGuiMessage("Jumping: "+str(jumping));
    AddGuiMessage("sprite_index: "+sprite_get_name(sprite_index));
    AddGuiMessage("State: "+str(state_text));
    AddGuiMessage("Bbox_left: "+str(bbox_left));
    AddGuiMessage("grav: "+str(grav));
    AddGuiMessage("coyt: "+str(coyt));
    AddGuiMessage("jump_buff_block: "+str(jump_buff_block));
}
with Input{
    AddGuiMessage("hlock: "+str(hlock));
    AddGuiMessage("vlock: "+str(vlock));
    AddGuiMessage("action_lock: "+str(action_lock));
}
with Enemy{
    AddGuiMessage("normal.t: "+str(normal.t));
}
draw_set_halign(fa_left);
for(var i=0;i<array_length(gui_message);i++){
    draw_text(0,16*i,gui_message[i]);
}
