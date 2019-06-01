ESX               = nil
local blowtorching = false
local clearweld = false
local dooropen = false
local blowtorchingtime = 300
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

-----

RegisterNetEvent('esx_borrmaskin:startblowtorch')
AddEventHandler('esx_borrmaskin:startblowtorch', function(source)
	blowtorchAnimation()
	Citizen.CreateThread(function()
		while true do
			if blowtorching then
				DisableControlAction(0, 73,   true) -- LookLeftRight
			end
			Citizen.Wait(10)
		end
	end)
end)

RegisterNetEvent('esx_borrmaskin:finishclear')
AddEventHandler('esx_borrmaskin:finishclear', function(source)
	clearweld = false
end)


RegisterNetEvent('esx_borrmaskin:clearweld')
AddEventHandler('esx_borrmaskin:clearweld', function(x,y,z)
		ESX.ShowNotification(' llego')
		clearweld = true
		Citizen.CreateThread(function()
			while clearweld do
				Wait(1000)
				local weld = ESX.Game.GetClosestObject('prop_weld_torch', {x,y,z})
				ESX.Game.DeleteObject(weld)
			end
		end)
end)

RegisterNetEvent('esx_borrmaskin:stopblowtorching')
AddEventHandler('esx_borrmaskin:stopblowtorching', function()
	blowtorching = false
	blowtorchingtime = 0
	ClearPedTasksImmediately(GetPlayerPed(-1))
	ESX.ShowNotification('cancelo blowtorch')
end)

--RegisterNetEvent('esx_borrmaskin:opendoors')
--AddEventHandler('esx_borrmaskin:opendoors', function(x,y,z)
	--Citizen.CreateThread(function()
	--while dooropen do
		--Wait(5000)
		--ESX.ShowNotification('abrete sesamo')
		--local obs, distance = ESX.Game.GetClosestObject('V_ILEV_GB_VAULDR', {x,y,z})
		--local pos = GetEntityCoords(obs);
		--ESX.ShowNotification(' hola' .. distance)
		--SetEntityHeading(obs, GetEntityHeading(obs) + 70.0)
	--end
	--end)
--end)

function blowtorchAnimation()
	local playerPed = GetPlayerPed(-1)
	blowtorchingtime = 300
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('esx_holdupbank:clearweld', {coords.x, coords.y, coords.z})
	Citizen.CreateThread(function()
			blowtorching = true
			Citizen.CreateThread(function()
				while blowtorching do
						Wait(2000)
						--local weld = ESX.Game.GetClosestObject('prop_weld_torch', GetEntityCoords(GetPlayerPed(-1)))
						--ESX.Game.DeleteObject(weld)
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
						ESX.ShowNotification('pongo anim')
						blowtorchingtime = blowtorchingtime - 1
						if blowtorchingtime <= 0 then
							blowtorching = false
							ClearPedTasksImmediately(PlayerPedId())
							ESX.ShowNotification('quito anim')
						end
				end
			end)
			
			--while blowtorching do
				--TaskPlayAnim(playerPed, "amb@world_human_const_blowtorch@male@blowtorch@base", "base", 2.0, 1.0, 5000, 5000, 1, true, true, true)
				TaskPlayAnim(playerPed, "atimetable@reunited@ig_7", "thanksdad_bag_02", 2.0, 1.0, 5000, 5000, 1, true, true, true)
				--if IsControlJustReleased(1, 51) then
					
				--end
			--end
		--end
	end)
end

--[[function blowtorchAnimation()
	ESX.ShowNotification(' llego')
	local playerPed = GetPlayerPed(-1)
	Citizen.CreateThread(function()
	--while true do	
		--Wait(100)
		
		while true do	
		Wait(100)
		end
	--end
	end)
	--anim@heists@fleeca_bank@blowtorching
	--blowtorch_right_door
	--amb@lo_res_idles@
	--world_human_const_blowtorch_lo_res_base
end

--[[
TASK_PLAY_ANIM(Ped ped, char* animDictionary, char* animationName, float speed, float speedMultiplier, int duration, int flag, float playbackRate, BOOL lockX, BOOL lockY, BOOL lockZ);


]]--