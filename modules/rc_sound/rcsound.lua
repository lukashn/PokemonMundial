SOUNDS_CONFIG = {
	soundChannel = SoundChannels.Music,
	checkInterval = 500,
	folder = 'music/',
	noSound = 'No sound file for this area.',
}

SOUNDS = {
	-- Lavender town
	{fromPos = {x =1157, y =1108, z =7}, toPos = {x =1170, y =1172, z =7}, priority = 1, sound = "lavender.ogg"},
	{fromPos = {x =1170, y =1148, z =7}, toPos = {x =1218, y =1176, z =7}, priority = 1, sound = "lavender.ogg"},
	{fromPos = {x =1179, y =1125, z =7}, toPos = {x =1220, y =1151, z =7}, priority = 1, sound = "lavender.ogg"},
	{fromPos = {x =1171, y =1140, z =7}, toPos = {x =1179, y =1146, z =7}, priority = 1, sound = "cp.ogg"},
	-- Cerulean
	{fromPos = {x=984, y=1014, z=7}, toPos = {x=1053, y=1029, z=7}, priority = 2, sound="cidade 1.ogg"},
	{fromPos = {x=987, y=1029, z=7}, toPos = {x=1035, y=1043, z=7}, priority = 2, sound="cidade 1.ogg"},
	{fromPos = {x=962, y=933, z=7}, toPos = {x=1002, y=1007, z=7}, priority = 2, sound="cidade 1.ogg"},
	{fromPos = {x=983, y=1007, z=7}, toPos = {x=1003, y=1013, z=7}, priority = 2, sound="cidade 1.ogg"},
	{fromPos = {x=977, y=987, z=7}, toPos = {x=1024, y=1000, z=7}, priority = 2, sound="cidade 1.ogg"},
	{fromPos = {x=1019, y=1002, z=7}, toPos = {x=1048, y=1016, z=7}, priority = 2, sound="cidade 1.ogg"},
	{fromPos = {x=966, y=1006, z=7}, toPos = {x=1000, y=1044, z=7}, priority = 2, sound="cidade 1.ogg"},
	{fromPos = {x=1025, y=1036, z=6}, toPos = {x=1035, y=1041, z=6}, priority = 2, sound="cidade 1.ogg"},
	-- Saffron
	{fromPos = {x=984, y=1136, z=7}, toPos = {x=1067, y=1173, z=7}, priority = 2, sound="cidade 2.ogg"},
	{fromPos = {x=1015, y=1171, z=7}, toPos = {x=1067, y=1208, z=7}, priority = 2, sound="cidade 2.ogg"},
	{fromPos = {x=984, y=1168, z=7}, toPos = {x=1004, y=1210, z=7}, priority = 2, sound="cidade 2.ogg"},
	{fromPos = {x=1001, y=1186, z=7}, toPos = {x=1050, y=1208, z=7}, priority = 2, sound="cidade 2.ogg"},

	
		-- Pvp
		{fromPos = {x=955, y=1053, z=13}, toPos = {x=996, y=1091, z=13}, priority = 1, sound="pvp.ogg"},
		{fromPos = {x=1001, y=917, z=9}, toPos = {x=1002, y=919, z=9}, priority = 1, sound="FF VII - Main.ogg"},
		-- Batalha pvp
		{fromPos = {x=958, y=983, z=13}, toPos = {x=1008, y=1038, z=13}, priority = 1, sound="batalha.ogg"},
		-- Arena de duelos
		{fromPos = {x=572, y=1091, z=7}, toPos = {x=585, y=1102, z=7}, priority = 1, sound="batalha.ogg"},
		{fromPos = {x=572, y=1080, z=7}, toPos = {x=592, y=1091, z=7}, priority = 1, sound="cp.ogg"},
		{fromPos = {x=586, y=1091, z=7}, toPos = {x=592, y=1102, z=7}, priority = 1, sound="cp.ogg"},
	
	-- Main
	
		-- Cp
		-- Cerulean
		{fromPos = {x=1004, y=1002, z=7}, toPos = {x=1018, y=1013, z=7}, priority = 1, sound="cp.ogg"},
		{fromPos = {x=1004, y=1002, z=6}, toPos = {x=1018, y=1013, z=6}, priority = 1, sound="cp.ogg"},
		{fromPos = {x=1004, y=1002, z=5}, toPos = {x=1018, y=1013, z=5}, priority = 1, sound="cp.ogg"},
		
		-- Saffron
		{fromPos = {x=1006, y=1175, z=7}, toPos = {x=1014, y=1185, z=7}, priority = 1, sound="cp.ogg"},
		{fromPos = {x=1005, y=1175, z=6}, toPos = {x=1014, y=1186, z=6}, priority = 1, sound="cp.ogg"},
		{fromPos = {x=1005, y=1175, z=5}, toPos = {x=1014, y=1184, z=5}, priority = 1, sound="cp.ogg"},

		{fromPos = {x=1096, y=1088, z=5}, toPos = {x=1110, y=1100, z=6}, priority = 1, sound="Fairy Tail - Main.ogg"},

		
		
} ----------

-- Sound
local rcSoundChannel
local showPosEvent
local playingSound

-- Design
soundWindow = nil
soundButton = nil

function toggle()
  if soundButton:isOn() then
    soundWindow:close()
    soundButton:setOn(true)
  else
    soundWindow:open()
    soundButton:setOn(false)
  end
end

function onMiniWindowClose()
  soundButton:setOn(false)
end

function init()
	for i = 1, #SOUNDS do
		SOUNDS[i].sound = SOUNDS_CONFIG.folder .. SOUNDS[i].sound
	end
	
	connect(g_game, { onGameStart = onGameStart,
                    onGameEnd = onGameEnd })
	
	rcSoundChannel = g_sounds.getChannel(SOUNDS_CONFIG.soundChannel)
	-- rcSoundChannel:setGain(value/COUNDS_CONFIG.volume)
	
	soundWindow = g_ui.loadUI('rcsound', modules.game_interface.getRightPanel())
	soundWindow:disableResize()
	soundWindow:setup()
	
	if(g_game.isOnline()) then
		onGameStart()
	end
end

function terminate()
	disconnect(g_game, { onGameStart = onGameStart,
                       onGameEnd = onGameEnd })
	onGameEnd()
	soundWindow:destroy()
	soundButton:destroy()
end

function onGameStart()
	stopSound()
	toggleSoundEvent = addEvent(toggleSound, SOUNDS_CONFIG.checkInterval)
end

function onGameEnd()
	stopSound()
	removeEvent(toggleSoundEvent)
end

function isInPos(pos, fromPos, toPos)
	return
		pos.x>=fromPos.x and
		pos.y>=fromPos.y and
		pos.z>=fromPos.z and
		pos.x<=toPos.x and
		pos.y<=toPos.y and
		pos.z<=toPos.z
end

function toggleSound()
	local player = g_game.getLocalPlayer()
	if not player then return end
	
	local pos = player:getPosition()
	local toPlay = nil

	for i = 1, #SOUNDS do
		if(isInPos(pos, SOUNDS[i].fromPos, SOUNDS[i].toPos)) then
			if(toPlay) then
				toPlay.priority = toPlay.priority or 0
				if((toPlay.sound~=SOUNDS[i].sound) and (SOUNDS[i].priority>toPlay.priority)) then
					toPlay = SOUNDS[i]
				end
			else
				toPlay = SOUNDS[i]
			end
		end
	end

	playingSound = playingSound or {sound='', priority=0}
	
	if(toPlay~=nil and playingSound.sound~=toPlay.sound) then
		g_logger.info("RC Sounds: New sound area detected:")
		g_logger.info("  Position: {x=" .. pos.x .. ", y=" .. pos.y .. ", z=" .. pos.z .. "}")
		g_logger.info("  Music: " .. toPlay.sound)
		stopSound()
		playSound(toPlay.sound)
		playingSound = toPlay
	elseif(toPlay==nil) and (playingSound.sound~='') then
		g_logger.info("RC Sounds: New sound area detected:")
		g_logger.info("  Left music area.")
		stopSound()
	end

	toggleSoundEvent = scheduleEvent(toggleSound, SOUNDS_CONFIG.checkInterval)
end

function playSound(sound)
	rcSoundChannel:enqueue(sound, 0)
	setLabel(clearName(sound))
end

function clearName(soundName)
	local explode = string.explode(soundName, "/")
	soundName = explode[#explode]
	explode = string.explode(soundName, ".ogg")
	soundName = ''
	for i = 1, #explode-1 do
		soundName = soundName .. explode[i]
	end
	return soundName
end

function stopSound()
	setLabel(SOUNDS_CONFIG.noSound)
	rcSoundChannel:stop()
	playingSound = nil
end

function setLabel(str)
	soundWindow:recursiveGetChildById('currentSound'):getChildById('value'):setText(str)
end