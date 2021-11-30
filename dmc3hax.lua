fullAccess("dmc3se.exe+188E234", 8)
fullAccess("dmc3se.exe+188CE34", 8)
fullAccess("dmc3se.exe+838AA0", 8)
fullAccess("dmc3se.exe+188D04C", 8)

-- lvl 2: 8.51083777008812E27
-- lvl 3: 2.83488268996406E29

function getEverything(sender)
    everythingShouldRun=not everythingShouldRun
    createThread(function()
        while everythingShouldRun do
            writeDouble("dmc3se.exe+188E234", 2.83488268996406E29) -- Royal Guard
            writeFloat("dmc3se.exe+188CE34", 10000) -- Devil Trigger
            writeFloat("dmc3se.exe+838AA0", 7.311887258E-21) -- Items
            writeFloat("dmc3se.exe+188D04C", 20000) -- Health
            sleep(100)
        end
    end)
end

function saveState(sender)
    devilTrigger=readFloat("dmc3se.exe+188CE34")
    royalGuard=readDouble("dmc3se.exe+188E234")
    storedItems=readFloat("dmc3se.exe+838AA0")
    danteHealth=readFloat("dmc3se.exe+188D04C")
    orbCount=readInteger("[dmc3se.exe+76B860+C40+8]+30+1C")
    orbsCollected=readInteger("[dmc3se.exe+76B860+C40+8]+30+94")
    stylePts=readInteger("dmc3se.exe+188F854")
    damageTaken=readInteger("[dmc3se.exe+76B860+C40+8]+30+90")
    itemsUsed=readInteger("[dmc3se.exe+76B860+C40+8]+30+98")
    frameCount=readInteger("[dmc3se.exe+76B860+C40+8]+30+8C")
    rgExp=readFloat("dmc3se.exe+188E218")
    return true
end

function autoSave(sender)
    autoSaveShouldRun=not autoSaveShouldRun
    createThread(function()
        while autoSaveShouldRun do
            roomId=readInteger("[[dmc3se.exe+76B860+C40+8]+10+8]+10+0")
            tmpHealth=readFloat("dmc3se.exe+188D04C")
            if oldRoomId ~= roomId and tmpHealth > 0 then
                devilTrigger=readFloat("dmc3se.exe+188CE34")
                royalGuard=readDouble("dmc3se.exe+188E234")
                storedItems=readFloat("dmc3se.exe+838AA0")
                danteHealth=readFloat("dmc3se.exe+188D04C")
                orbCount=readInteger("[dmc3se.exe+76B860+C40+8]+30+1C")
                orbsCollected=readInteger("[dmc3se.exe+76B860+C40+8]+30+94")
                stylePts=readInteger("dmc3se.exe+188F854")
                damageTaken=readInteger("[dmc3se.exe+76B860+C40+8]+30+90")
                itemsUsed=readInteger("[dmc3se.exe+76B860+C40+8]+30+98")
                frameCount=readInteger("[dmc3se.exe+76B860+C40+8]+30+8C")
                rgExp=readFloat("dmc3se.exe+188E218")
                oldRoomId=roomId
                sleep(250)
            end
        end
    end)
end


function loadState(sender)
    -- Ignus Fatuus: writeInteger("dmc3se.exe+838ABC", 65536)
    writeFloat("dmc3se.exe+188CE34", devilTrigger)
    writeDouble("dmc3se.exe+188E234", royalGuard)
    writeFloat("dmc3se.exe+838AA0", storedItems)
    writeFloat("dmc3se.exe+188D04C", danteHealth)
    writeInteger("[dmc3se.exe+76B860+C40+8]+30+1C", orbCount)
    writeInteger("[dmc3se.exe+76B860+C40+8]+30+8C", frameCount)
    writeInteger("[dmc3se.exe+76B860+C40+8]+30+94", orbsCollected)
    writeInteger("dmc3se.exe+188F854", stylePts)
    writeInteger("[dmc3se.exe+76B860+C40+8]+30+90", damageTaken)
    writeInteger("[dmc3se.exe+76B860+C40+8]+30+98", itemsUsed)
    writeFloat("dmc3se.exe+188E218", rgExp)
    return true
end

if loadHotkey ~= nil then loadHotkey.destroy(); loadHotkey=nil end
if saveHotkey ~= nil then saveHotkey.destroy(); saveHotkey=nil end
if autoSaveHotkey ~= nil then autoSaveHotkey.destroy(); autoSaveHotkey=nil end
if haxHotkey ~= nil then haxHotkey.destroy(); haxHotkey=nil end

loadHotkey=createHotkey("loadState", VK_F1)
generichotkey_onHotkey(loadHotkey, loadState)

saveHotkey=createHotkey("saveState", VK_F5)
generichotkey_onHotkey(saveHotkey, saveState)

autoSaveHotkey=createHotkey("autoSave", VK_F6)
generichotkey_onHotkey(autoSaveHotkey, autoSave)
autoSaveShouldRun=false
isSpawned=nil
roomId=nil

haxHotkey=createHotkey("getEverything", VK_F7)
generichotkey_onHotkey(haxHotkey, getEverything)
everythingShouldRun=false
