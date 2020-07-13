--Server side event config for esx addon scripts
EventConfig = {}
EventConfig.Account = {
    ['getAccount'] = 'esx_addonaccount:getAccount',
    ['getSharedAccount'] = 'esx_addonaccount:getSharedAccount',
}
EventConfig.Datastore = {
    ['getSharedDatastore'] = 'esx_datastore:getSharedDataStore',
    ['getDatastore'] = 'esx_datastore:getDataStore',
}
EventConfig.Common = {
    ['showHelpNotif'] = 'esx:showHelpNotification',
    ['playerDropped'] = 'esx:playerDropped',
    ['setJob'] = 'esx:setJob',
    ['playerLoaded'] = 'esx:playerLoaded',
    ['phoneRegisterNumber'] = 'esx_phone:registerNumber',
    ['addMessage'] = 'chat:addMessage',
}

EventConfig.Inventory = {
    ['getInventory'] = 'esx_addoninventory:getInventory',
    ['getSharedInventory'] = 'esx_addoninventory:getSharedInventory',
}

EventConfig.Society = {
    ['registerSociety'] = 'esx_society:registerSociety',
    ['getSociety'] = 'esx_society:getSociety',
}
