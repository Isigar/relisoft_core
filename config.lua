Config = {}
Config.Debug = true
Config.ESXCallback = "esx:getSharedObject"
Config.DefaultChatColor = { 255, 255, 255 }
Config.DefaultBlipOptions = {
    scale = 1.0,
    shortRange = true,
    type = 4,
    color = 55
}

Config.DiscordWebhook = "https://discordapp.com/api/webhooks/"
Config.DiscordColors = {
    ['Green'] = 56108,
    ['Grey'] = 8421504,
    ['Red'] = 16711680,
    ['Orange'] = 16744192,
    ['Blue'] = 2061822,
    ['Purple'] = 11750815
}

Config.DefaultMarkerOptions = {
    scale = {
        x = 1.5,
        y = 1.5,
        z = 0.5
    },
    rot = {
        x = 0.0,
        z = 0.0,
        y = 0.0
    },
    color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    dir = {
        x = 0.0,
        y = 0.0,
        z = 0.0
    },
    bobUpAndDown = false,
    faceCamera = false,
    p19 = 2,
    rotate = false,
    textureDict = nil,
    textureName = nil,
    drawOnEnts = nil,
    onEnter = nil,
    onLeave = nil,
    onEnterKey = nil,
    jobs = nil,
    grades = nil
}

Config.DefaultTextOptions = {
    color = {
        r = 255,
        g = 255,
        b = 255,
        a = 255
    },
    scale = {
        scale = 0.5,
        size = 0.5
    }
}