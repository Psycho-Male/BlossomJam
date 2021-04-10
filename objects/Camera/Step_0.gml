update();
x=lerp(x,x+rumble.x,.3);
y=lerp(y,y+rumble.y,.3);
x=clamp(x,0,room_width-width);
y=clamp(y,0,room_height-height);
camera_set_view_pos (view_camera[0],x,y);
camera_set_view_size(view_camera[0],view_width,view_height);
