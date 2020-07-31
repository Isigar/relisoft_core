---
description: Create object and manage it
---

# Objects

### Create object

With rcore you can simply create a model without the need of requesting model or anything else, rcore will request model and will set model as no longed needed when its work is done. You can create networked object which will see all players or only local object which will see only a client where you will spawn object.

You can use for name as well string name of object like 'prop\_car\_door\_01' or hash

#### Example

We will create simple command /spawnobj which will spawn one local object and one networked object

{% code title="your\_clientside.lua" %}
```lua
rcore = exports.rcore

local obj = 'prop_car_door_01' 

RegisterCommand('spawnobj',function() 
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    rcore:createLocalObject(obj,coords,function(objId) 
        print('Yes we create local object and we got it ID '..objId)
    end)
end)
```
{% endcode %}

