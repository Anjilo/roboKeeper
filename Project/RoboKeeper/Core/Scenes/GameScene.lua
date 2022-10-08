-- requires
-----------------------------------------------------------------------------------------
    local composer = require "composer"
    local modelModule = require "Core.Models.GameSceneModel"

-- consts
----------------------------------------------------------------------------------------
    local const STD_VELOCITY_FACTOR = 50
    local const BOXES_AMOUNT = 12
    local const AIM_TIME = 3000
-- declarations
----------------------------------------------------------------------------------------
    local scene = composer.newScene()
    local sceneModel = {}

    local mapView = nil
    local mainRobotView = nil
    local enemyRobot = nil
    local currentBoxId = 0

    local xBorderLeft = -1
    local xBorderRight = -1

    local aimTimer = nil
    
    local isPlaying = true 
-- source
----------------------------------------------------------------------------------------
    function scene:create(_event)                  
        physics.start()
        physics.setGravity(0, 0)
        
        modelModule.new(sceneModel, scene)
        mapView = sceneModel:initMap()
        mainRobotView = sceneModel:initMainRobot(mapView)
        enemyRobotView = sceneModel:initEnemyRobot(mapView, mainRobotView, BOXES_AMOUNT)
        xBorderLeft, xBorderRight = sceneModel:initBorders(mapView)
    end

    function scene:show(_event)
    end

    function scene:hide(_event)
    end

    function scene:destroy(_event)
    end

    local function onAccelerometer(_event)
        if (isPlaying == true) then
            local canMoveToLeft = mainRobotView.x >= xBorderLeft
            local canMoveToRight = mainRobotView.x <= xBorderRight
            -- native.showAlert("Debug", "test condition " .. tostring(xBorderLeft), {"ok"})
        
            if ((canMoveToLeft) and (_event.xRaw < 0)) or ((canMoveToRight) and (_event.xRaw > 0)) then
                mainRobotView:move(_event.xRaw * STD_VELOCITY_FACTOR)
            end
        end
    end

    local function onEnterFrame(_event)
        local boxes = enemyRobotView:getBoxes()
        for i = 0, #boxes do
            boxes[i]:falling() 
        end

        if (isPlaying == true) then
            enemyRobotView:execute()
        end
    end

    local function onCollision(_event)
        if (_event.phase == "began") then
            local boxAndRobotCollids = ((_event.object1.name == "Robot") and (_event.object2.name == "Box")) or ((_event.object1.name == "Box") and (_event.object2.name == "Robot"))
            if (boxAndRobotCollids == true) and (mainRobotView:isAlive()) then
                isPlaying = false             
                mainRobotView:die()   
            end
        end
    end
    
-- lisneres setup    
-----------------------------------------------------------------------------------------
    scene:addEventListener( CREATE_SCENE_EVENT_NAME, scene )
    scene:addEventListener( SHOW_SCENE_EVENT_NAME, scene )
    scene:addEventListener( HIDE_SCENE_EVENT_NAME, scene )
    scene:addEventListener( DESTROY_SCENE_EVENT_NAME, scene )
    Runtime:addEventListener( ACC_EVENT_NAME, onAccelerometer )
    Runtime:addEventListener( ENTER_FRAME_EVENT_NAME, onEnterFrame )
    Runtime:addEventListener( COLL_DET_EVENT_NAME, onCollision )
-----------------------------------------------------------------------------------------
return scene