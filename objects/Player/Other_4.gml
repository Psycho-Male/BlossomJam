if instance_exists(SpawnPoint){
    x=SpawnPoint.x;
    y=SpawnPoint.y;
}
var _layId=layer_get_id("Collision");
layer_set_visible(_layId,false);
state=state_normal;
