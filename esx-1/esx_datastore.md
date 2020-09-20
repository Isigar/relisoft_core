---
description: use datastore with a simple way
---

# esx\_datastore



{% hint style="info" %}
rcore using your database and if you missing some important data like datastore record it will create it for you :\)
{% endhint %}

### Get shared datastore

Get datastore will get shared datastore like the police or other fraction

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore

rcore:getDatastore('society_police', function(store) 
    if store then
        local value = store.get('weapons')
        --Do something will value
        store.set('weapons', value)
    end
end)
```
{% endcode %}

### Get player datastore

Get player datastore get you only store for your player and we are using identifier to get this

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore

rcore:getPlayerDatastore(identifier, 'property', function(store) 
    if store then
        local dress = store.get('dressing')
        --Do something with variable
        store.set('dressing', dress)
    end
end)
```
{% endcode %}

### Create datastore

You can create shared or not shared datastore with a single line of code, that code will check if this record exists at your database if not it will create it, and give you a log into your server console  after rcore will add datastore account at the database you have to restart your server once more to make other scripts to load this change.

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore

--True for shared if false it will create player datastore
rcore:createDatastore('society_police', true)

--Also you can do something after datastore check with callback
rcore:createDatastore('society_police', true, function() 
    print('Registered society!')
end)
```
{% endcode %}

