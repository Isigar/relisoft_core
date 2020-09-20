---
description: Command system used native RegisterCommand with permission system inside
---

# Command system

### Classic command

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore
rcore:addCmd('testcmd',function(source,args,rawCmd) 
    print('Just make cmd for all but not for rcon')
end)
```
{% endcode %}

### Group command

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore
rcore:addGroupCmd('testcmd','superadmin',function(source,args,rawCmd) 
    print('Just make cmd only for superadmin group and not for rcon')
end)
```
{% endcode %}

### Job command

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore
rcore:addJobCmd('arrest','police',function(source,args,rawCmd) 
    print('Just make cmd only for police job and not for rcon')
end)
```
{% endcode %}

### Rcon command

{% code title="your\_serverside.lua" %}
```lua
rcore = exports.rcore
rcore:addRconCmd('testcmd',function(source,args,rawCmd) 
    print('Make command only for console use')
end)
```
{% endcode %}



