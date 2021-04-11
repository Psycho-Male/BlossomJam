draw_self();

for(var i=0;i<objective_count;i++){
    draw_sprite(spr_remaining,0,draw_x+(i%5)*16,draw_y+floor(i/5)*16);
}
