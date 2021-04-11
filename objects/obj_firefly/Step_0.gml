if y>0{
    y-=.1;
}else{
    instance_destroy();
}
if t<=0{
    dir*=-1;
    t=irandom_range(tt-20,tt+20);
}
t--;
x+=spd*dir;
image_xscale=sign(dir);
if lifet>lifetime{
    image_alpha-=.1;
    if image_alpha<=0{
        instance_destroy();
    }
}else{
    image_alpha+=.1;
    lifet++;
}
