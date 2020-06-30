---
description: How to use and install amazing rcore
---

# Installation

## Download rcore framework

Download rcore from github releases - [https://github.com/Isigar/relisoft\_core/releases](https://github.com/Isigar/relisoft_core/releases)  
Of course, you can download a master branch to get the newest API and fixes but it could happen that there will be some bug so if you want to use it for production server use production releases. 

1. Download rcore framework from git
2. Rename folder from relisoft\_core to rcore
3. Create `[rcore]` folder in your resources
4. Add rcore framework folder into `[rcore]` folder
5. Add to config `ensure rcore`

### Right place in config

Right place in config is after starting es\_extended and esx\_billing, esx\_addonaccount, esx\_datastore and esx\_addonaccount these will need to be start before rcore because rcore using it in it code. 

