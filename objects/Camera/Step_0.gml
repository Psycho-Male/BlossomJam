update();
x=lerp(x,x+rumble.x,.3);
y=lerp(y,y+rumble.y,.3);
x=clamp(x,0,room_width-width);
y=clamp(y,0,room_height-height);
camera_set_view_pos (view_camera[0],x,y);
camera_set_view_size(view_camera[0],view_width,view_height);



xoff=(room_width-Player.x)/(room_width/2);
for(var i=0;i<array_length(layerpos[0]);i++){
    layer_x(layers[i],xoff*(10/i));
}
for(var i=0;i<array_length(layers[0]);i++){
    layer_y(layers[0][i],Player.y);
}
