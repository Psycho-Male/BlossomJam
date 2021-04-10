function approach(c,t,a){
    if (c < t) {
        c = min(c+a, t); 
    }else{
        c = max(c-a, t);
    }
    return c;
}
