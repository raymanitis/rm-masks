---@diagnostic disable: undefined-global
local Mod = require 'config'
local Config = Mod

local currentMask = nil
local currentMaskIndex = nil

local function notify(message, type)
	if lib and lib.notify then
		lib.notify({ title = Config.MenuTitle, description = message, type = type or Config.NotifyType })
	else
		SetNotificationTextEntry('STRING')
		AddTextComponentString(message)
		DrawNotification(false, true)
	end
end

local function deleteCurrentMask()
	if currentMask and DoesEntityExist(currentMask) then
		DeleteEntity(currentMask)
		currentMask = nil
		currentMaskIndex = nil
	end
end

local function loadModel(model)
	local hash = (type(model) == 'number') and model or GetHashKey(model)
	if not HasModelLoaded(hash) then
		RequestModel(hash)
		while not HasModelLoaded(hash) do
			Wait(10)
		end
	end
	return hash
end

local function attachMask(mask)
	deleteCurrentMask()
	local ped = PlayerPedId()
	local hash = loadModel(mask.model)
	local obj = CreateObject(hash, 0.0, 0.0, 0.0, true, false, false)
	SetModelAsNoLongerNeeded(hash)
	SetEntityCollision(obj, false, false)
	SetEntityCompletelyDisableCollision(obj, true, true)
	SetEntityProofs(obj, true, true, true, true, true, true, true, true)
	SetEntityCanBeDamaged(obj, false)
	SetEntityInvincible(obj, true)
	SetEntityAlpha(obj, 255, false)
	SetEntityAsMissionEntity(obj, true, true)

	local bone = GetPedBoneIndex(ped, Config.HeadBone)
	AttachEntityToEntity(obj, ped, bone,
		mask.offset.x or 0.0, mask.offset.y or 0.0, mask.offset.z or 0.0,
		mask.rotation.x or 0.0, mask.rotation.y or 0.0, mask.rotation.z or 0.0,
		false, true, false, false, 2, true)

	currentMask = obj
end

local function buildOptions()
	local options = {}
	for i, mask in ipairs(Config.Masks) do
		table.insert(options, { label = mask.label, args = { index = i } })
	end
	if #options > 0 then
		table.insert(options, { label = 'Remove Mask', icon = 'xmark', args = { remove = true } })
	end
	return options
end

lib.registerMenu({
	id = 'ray_masks_menu',
	title = Config.MenuTitle,
	position = 'top-right',
	options = buildOptions()
}, function(selected, scrollIndex, args)
	if args and args.remove then
		if currentMask then
			deleteCurrentMask()
			notify('Mask removed', 'success')
		else
			notify('No mask to remove', 'error')
		end
		return
	end

	if args and args.index then
		local idx = args.index
		local mask = Config.Masks[idx]
		if not mask then return end
		attachMask(mask)
		currentMaskIndex = idx
		notify(('Equipped: %s'):format(mask.label), 'success')
	end
end)

RegisterCommand(Config.Command, function()
	local ped = PlayerPedId()
	local model = GetEntityModel(ped)
	local male = GetHashKey('mp_m_freemode_01')
	local female = GetHashKey('mp_f_freemode_01')
	if model == male or model == female then
		notify('This command is only for custom ped models.', 'error')
		return
	end

	local open = lib.getOpenMenu()
	if open == 'ray_masks_menu' then
		lib.hideMenu(true)
		return
	end
	lib.setMenuOptions('ray_masks_menu', buildOptions())
	lib.showMenu('ray_masks_menu')
end, false)

AddEventHandler('onResourceStop', function(res)
	if res ~= GetCurrentResourceName() then return end
	deleteCurrentMask()
end)

