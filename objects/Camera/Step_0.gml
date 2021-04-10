update();
x=lerp(x,x+rumble.x,.3);
y=lerp(y,y+rumble.y,.3);
camera_set_view_pos (view_camera[0],x,y);
camera_set_view_size(view_camera[0],view_width,view_height);
