if !GameController.debug{
    exit;
}
draw_set_color(c_black);
draw_rectangle(0,0,width/4,height*4,false);
draw_set_color(c_white);
if instance_exists(Player) with Player{
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
    AddGuiMessage("air_dashed: "+str(air_dashed));
    AddGuiMessage("hp: "+str(hp));
    AddGuiMessage("jump_force: "+str(jump_force));
}
if instance_exists(Input) with Input{
    AddGuiMessage("hlock: "+str(hlock));
    AddGuiMessage("vlock: "+str(vlock));
    AddGuiMessage("action_lock: "+str(action_lock));
}
if instance_exists(Enemy) with Enemy{
    AddGuiMessage("Enemy hsp: "+str(hsp));
    AddGuiMessage("normal.t: "+str(normal.t));
    AddGuiMessage("Enemy State: "+str(state_name));
}
AddGuiMessage("xoff: "+str(xoff));
//AddGuiMessage("yoff: "+str(yoff));
draw_set_halign(fa_left);
for(var i=0;i<array_length(gui_message);i++){
    draw_text(0,16*i,gui_message[i]);
}
