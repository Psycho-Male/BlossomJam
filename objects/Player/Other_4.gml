if instance_exists(SpawnPoint){
    x=SpawnPoint.x;
    y=SpawnPoint.y;
}
var _layId=layer_get_id("Collision");
//collison_map=layer_tilemap_get_id(_layId);
layer_set_visible(_layId,false);
