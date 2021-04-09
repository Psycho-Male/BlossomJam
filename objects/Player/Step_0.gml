onground=tilemap_get_at_pixel(collision_map,x,y+vsp);
if onground{
    if vsp>0{
        vsp=0;
        y+=y%16;
    }
}
x+=hsp;
y+=vsp;
