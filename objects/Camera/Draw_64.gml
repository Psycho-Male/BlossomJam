var _text=
[
//"x: "+str(x),
//"y: "+str(y),
//"width: "+str(width),
//"height: "+str(height),
//"focus_instance: "+str(focus_instance),
//"view_camera[0]: "+str(view_camera[0]),
//"active camera: "+str(camera_get_active()),
//"view_enabled: "+str(view_enabled),
"collision_map: "+str(Player.collision_map),
"onground: "+str(Player.onground),
//"Collision: "+str(layer_tilemap_get_id(layer_get_id("Collision"))),
//"BG: "+str(layer_tilemap_get_id(layer_get_id("BG"))),
"hsp: "+str(Player.hsp),
"vspv "+str(Player.vsp),
"sprite_index: "+sprite_get_name(Player.sprite_index),
"State: "+str(Player.state_text),
"Bbox_left: "+str(Player.bbox_left),
];
draw_set_halign(fa_left);
for(var i=0;i<array_length(_text);i++){
    draw_text(0,16*i,_text[i]);
}
Player.collision_map=layer_tilemap_get_id(layer_get_id("Collision"));
