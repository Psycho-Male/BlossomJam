if room==rm_init{
    for(var i=0;i<array_length(controller_instances);i++){
        with InstanceCreate(controller_instances[i]){
            persistent=true;
        }
    }
    room_goto(rm_stage1);
}
