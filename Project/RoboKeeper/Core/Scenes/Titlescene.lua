-----------------------------------------------------------------------------------------
-- requires
local composer = require "composer"
-----------------------------------------------------------------------------------------
-- consts

-----------------------------------------------------------------------------------------
-- -- declarations
local scene = composer.newScene()
-----------------------------------------------------------------------------------------
-- -- source
-- local function loadMaxScore()
-- 	local path = system.pathForFile(SCORE_FILE_NAME, system.DocumentsDirectory)
-- 	local file = io.open(path)
-- 	local score = 0

-- 	if (file ~= nil) then
-- 		score = file:read("*n")
-- 		file:close()
-- 	end

-- 	return score
-- end

-- local function keyListener(_event)
-- 	if (_event.phase == "released") then
-- 		composer.gotoScene(GAME_SCENE_NAME, {params = {maxScore = maxScore}})
-- 	end
-- end

-- function scene:create( event )
-- 	local sceneGroup = self.view
-- 	local mapData = json.decodeFile(system.pathForFile( TITLE_MAP_PATH, system.ResourceDirectory ))
	
-- 	map = tiled.new(mapData, ASSETS_PATH)

-- 	if IS_SIMULATOR then
-- 		startButton = buttonModule.new(map:findObject(START_BUTTON_NAME))
-- 	else
-- 		startButton = buttonModule.new(system.pathForFile(map:findObject(START_BUTTON_NAME)))
-- 	end

-- 	yourBestCaption = map:findObject(YOUR_BEST_CAPTION)
-- 	maxScore = loadMaxScore()
-- 	scoreText = display.newText(tostring(maxScore), display.contentCenterX, 
-- 		yourBestCaption.y + yourBestCaption.contentHeight, native.systemFonts, 100)

-- 	background = map:findObject(BACKGROUND_NAME)
-- 	background.height = display.actualContentHeight

-- 	Runtime:addEventListener(UI_EVENT_NAME, keyListener)
-- end

-- function scene:show( event )
-- 	local sceneGroup = self.view
-- 	local phase = event.phase
	
-- 	if phase == "will" then
		
-- 	elseif phase == "did" then

-- 	end
-- end

-- function scene:hide( event )
-- 	local sceneGroup = self.view
-- 	local phase = event.phase
	
-- 	if event.phase == "will" then
	
-- 	elseif phase == "did" then
	
-- 	end	
-- end

-- function scene:destroy( event )
-- 	local sceneGroup = self.view	
-- end
---------------------------------------------------------------------------------
-- Listener setup
-- scene:addEventListener( CREATE_SCENE_EVENT_NAME, scene )
-- scene:addEventListener( SHOW_SCENE_EVENT_NAME, scene )
-- scene:addEventListener( HIDE_SCENE_EVENT_NAME, scene )
-- scene:addEventListener( DESTROY_SCENE_EVENT_NAME, scene )
-----------------------------------------------------------------------------------------

return scene