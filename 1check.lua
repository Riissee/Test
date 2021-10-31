script_author('Risee')
script_version("2.11.2021")
require "lib.moonloader"
require "lib.samp.events"
local sampev = require 'lib.samp.events'
local inicfg= require 'inicfg'
local directIni = "moonloader\\config\\time.ini"
local mainIni = inicfg.load(nil, directIni)
local stateIni = inicfg.save(mainIni, directIni)
local collor = 0xFF1818

function main()
  if not isSampfuncsLoaded() or not isSampLoaded() then return end
  while not isSampAvailable() do wait(0) end
		res = false
		sampRegisterChatCommand("ginfo", cmd_ginfo)
		sampRegisterChatCommand("sid", cmd_sid)
	
	 sampAddChatMessage("[EasyCheck]:{FFFFFF} Актививирован.", 0xFFB8F08B)
	 sampAddChatMessage("Отказаться от аренды : {00FF00}SHIFT+F{FFFFFF}. ", 0xFFB8F08B)
	 sampAddChatMessage("Ближайший слетевший дом : {00FF00}delete{FFFFFF}. ", 0xFFB8F08B)
	 sampAddChatMessage("Смена погоды и пробив AF : {00FF00}*{FFFFFF}. ", 0xFFB8F08B)
	 sampAddChatMessage("Информация о домах в госсе : {00FF00}+{FFFFFF}. ", 0xFFB8F08B)
	 sampAddChatMessage("Автор: {FFFFFF}Rise. ", 0xFFB8F08B)
     autoupdate("https://raw.githubusercontent.com/Riissee/Test/main/update.json", '['..string.upper(thisScript().name)..']: ', "https://github.com/Riissee/Test/raw/a28e918bf5ef319f1824101782f75bb7eb4772fe/1check.lua")
	 while true do wait(0)
	if res == false and os.date( "%M", os.time()) == "58" then
		if os.date( "%S", os.time()) == "00" then
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		wait(mainIni.config.idtext)
		sampAddChatMessage("ЕРЖАН ВСТАВАЙ! СЛЁТ СЛЁТ СЛЁТ", collor)
		res = true
		elseif os.date( "%S", os.time()) == "05" then
		 res = false
		end
	end
	
 
	
	if isKeyJustPressed(0x4C) and not sampIsChatInputActive() and not sampIsDialogActive() then
		sampProcessChatInput("/lock")
	end
    if isKeyJustPressed(0x2E) and not sampIsChatInputActive() and not sampIsDialogActive() then
	  wait(300)
      sampProcessChatInput("/gos 0 1000-5000000")
	  wait(950)
	  sampProcessChatInput("/gos")
	
    end 
	if isKeyJustPressed(0x6B) and not sampIsChatInputActive() and not sampIsDialogActive() then
      sampProcessChatInput("/gos")
    end 
	if isKeyDown(0xA0) and isKeyJustPressed (0x46) and not sampIsChatInputActive() and not sampIsDialogActive() then
      sampProcessChatInput("/unrentveh")
	end
	if isKeyJustPressed(0x05) then
	 sampProcessChatInput("/callcar")
	end
	if isKeyJustPressed(0x6A) and not sampIsChatInputActive() and not sampIsDialogActive() then
	 sampProcessChatInput("/sw 14")
	 wait(900)
	 sampProcessChatInput("/gos 0 1000-100001")
	 wait(1000)
	 sampProcessChatInput("/gos 2 1000-5000000")
	end
  end
end

function sampev.onServerMessage(collor, text)
	if string.find(text, 'Администрация', 1, true) then
	lua_thread.create(function()
	sampProcessChatInput("/gos 0 1000-5000000")
	end)
	end
end

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

function pressKey(key)
  setVirtualKeyDown(key, true)
  wait(5)
  setVirtualKeyDown(key, false)
end


function cmd_ginfo(arg)
mainIni = inicfg.load(nil, directIni)
sampAddChatMessage(mainIni.config.idtext, -1)
end
function cmd_sid(arg)
	mainIni.config.idtext = arg
	if inicfg.save(mainIni, directIni) then
	   sampAddChatMessage("Успешно", -1)
	end
end

function autoupdate(json_url, prefix, url)
  local dlstatus = require('moonloader').download_status
  local json = getWorkingDirectory() .. '\\'..thisScript().name..'-version.json'
  if doesFileExist(json) then os.remove(json) end
  downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
      if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
          local f = io.open(json, 'r')
          if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion ~= thisScript().version then
              lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                sampAddChatMessage((prefix..'Обнаружено обновление. Пытаюсь обновиться c '..thisScript().version..' на '..updateversion), color)
                wait(250)
                downloadUrlToFile(updatelink, thisScript().path,
                  function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                      print(string.format('Загружено %d из %d.', p13, p23))
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                      print('Загрузка обновления завершена.')
                      sampAddChatMessage((prefix..'Обновление завершено!'), color)
                      goupdatestatus = true
                      lua_thread.create(function() wait(500) thisScript():reload() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                      if goupdatestatus == nil then
                        sampAddChatMessage((prefix..'Обновление прошло неудачно. Запускаю устаревшую версию..'), color)
                        update = false
                      end
                    end
                  end
                )
                end, prefix
              )
            else
              update = false
              print('v'..thisScript().version..': Обновление не требуется.')
            end
          end
        else
          print('v'..thisScript().version..': Не могу проверить обновление. Смиритесь или проверьте самостоятельно на '..url)
          update = false
        end
      end
    end
  )
  while update ~= false do wait(100) end
end

