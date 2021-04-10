function Trace(_text){
    show_debug_message(_text);
}
function InstanceCreate(_index){
    return instance_create_layer(0,0,"Instances",_index);
}
function ExcessiveInstance(){
    if instance_number(object_index)>1{
        instance_destroy();
    }
}
