var _len=ds_list_size(hearts);
if _len>0&&Player.hp<_len{
    if instance_exists(hearts[|_len-1]) with hearts[|_len-1]{
        hurt();
    }
    ds_list_delete(hearts,_len-1);
}else if Player.hp>_len{
    ds_list_add(hearts,get_heart(32+(16*_len*heart_scale),32));
}
