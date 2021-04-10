function Trace(_text){
    show_debug_message(_text);
}
function InstanceCreate(_index){
    return instance_create_layer(0,0,"Instances",_index);
}
function ExcessiveInstance(){
    if instance_exists(object_index)&&instance_number(object_index)>1{
        instance_destroy();
    }
}
function AddGuiMessage(_text){
    if !instance_exists(Camera){
        exit;
    }
    var _len=array_length(Camera.gui_message);
    Camera.gui_message[_len]=_text;
}
function reset_color(){
    draw_set_color(c_white);
    draw_set_alpha(1);
}
