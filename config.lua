local Config = {}

Config.Command = 'pedmask'
Config.MenuTitle = 'Masks'

-- Bone index for head (SKEL_Head)
Config.HeadBone = 31086


-- Define your masks here. Adjust offset/rotation per model for perfect fit.
Config.Masks = {
	-- Tuned to sit in front of face and face forward
	{ label = 'Welding Mask', model = 'prop_welding_mask_01', offset = { x = 0.1, y = 0.015, z = -0.015 }, rotation = { x = 0.0, y = -90, z = 180 } },
	{ label = 'Gas Mask', model = 'prop_player_gasmask', offset = { x = 0, y = 0.005, z = -0.015 }, rotation = { x = 0.0, y = -90, z = 180 } },
	{ label = 'Monkey Mask', model = 'p_orleans_mask_s', offset = { x = 0, y = 0.005, z = -0.015 }, rotation = { x = 0.0, y = -90, z = 180 } },
}

return Config

