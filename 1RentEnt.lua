script_name("EnterRent")
script_author('Rise')
script_version(1)
  
require "lib.moonloader" 
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
local sampev = require 'lib.samp.events'
update_state = false

local script_vers = 1
local script_vers_text = "1.00"

local update_url = "https://raw.githubusercontent.com/Riissee/Test/main/NN.ini" -- тут тоже свою ссылку
local update_path = getWorkingDirectory() .. "/NN.ini" -- и тут свою ссылку

local script_url = "" -- тут свою ссылку
local script_path = thisScript().path

function sampev.onShowDialog(dialogId, style, title, _, _, text)
  if text:find("Договор на аренду транспортного средства.* ") then
    lua_thread.create(function()
      wait(50) pressKey(0x0D)
    end)
  end
  if text:find("Ваш транспорт доставлен..* ") then
	lua_thread.create(function()
      wait(50) pressKey(0x0D)
	  wait(600) sampProcessChatInput("/inscar")
    end)
  end
  if text:find("Вы хотите купить этот дом в ипотеку с первым взносом в.* ") then
    lua_thread.create(function()
      wait(50) pressKey(0x0D)
    end)
  end
  if text:find("Вы не можете использовать этот аксессуар.* ") then
    lua_thread.create(function()
      wait(50) pressKey(0x0D)
    end)
  end
end
 
function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(0) end
  sampAddChatMessage("[FastRent]:{FFFFFF} Активация автоматическая.", 0xFFB8F08B)
   downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.Names.vers) > script_vers then
                sampAddChatMessage("Есть обновление! Версия: " .. updateIni.Names.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
	while true do
        wait(0)

        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("Скрипт успешно обновлен!", -1)
                    thisScript():reload()
                end
            end)
            break
        end

	end
end

function pressKey(key)
  setVirtualKeyDown(key, true)
  wait(5)
  setVirtualKeyDown(key, false)
end