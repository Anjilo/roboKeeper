-- requires
-----------------------------------------------------------------------------------------
    local composer = require "composer"
    local modelModule = require "Core.Models.GameSceneModel"

-- consts
----------------------------------------------------------------------------------------
    local const STD_VELOCITY_FACTOR = 50
-- declarations
----------------------------------------------------------------------------------------
    local scene = composer.newScene()
    local sceneModel = {}

    local mapView = nil
    local mainRobotView = nil
    local enemyRobot = nil

    local xBorderleft = -1
    local xBorderRight = -1
-- source
----------------------------------------------------------------------------------------
    function scene:create(_event)                  
        physics.start()
        physics.setGravity(0, 0)
        
        modelModule.new(sceneModel, scene)
        mapView = sceneModel.initMap()
        mainRobotView = sceneModel.initMainRobot(mapView)
        enemyRobotView = sceneModel.initEnemyRobot(mapView)

        -- init borders
        wallRight = mapView:findObject("WallRight")
        wallLeft = mapView:findObject("WallLeft")
        xBorderRight = wallRight.x - wallRight.width 
        xBorderleft = wallLeft.x + wallLeft.width

        -- native.showAlert("Debug", "test borders " .. tostring(xBorderRight), {"ok"})
        
    end

    function scene:show(_event)
    end

    function scene:hide(_event)
    end

    function scene:destroy(_event)
    end

    local function onAccelerometer(_event)
        local canMoveToLeft = mainRobotView.x >= xBorderleft
        local canMoveToRight = mainRobotView.x <= xBorderRight
        -- native.showAlert("Debug", "test condition " .. tostring(xBorderRight), {"ok"})
        
        if ((canMoveToLeft) and (_event.xRaw < 0)) or ((canMoveToRight) and (_event.xRaw > 0)) then
            mainRobotView:move(_event.xRaw * STD_VELOCITY_FACTOR)
            -- 
        end
    end
    
-- lisneres setup    
-----------------------------------------------------------------------------------------
    scene:addEventListener( CREATE_SCENE_EVENT_NAME, scene )
    scene:addEventListener( SHOW_SCENE_EVENT_NAME, scene )
    scene:addEventListener( HIDE_SCENE_EVENT_NAME, scene )
    scene:addEventListener( DESTROY_SCENE_EVENT_NAME, scene )
    Runtime:addEventListener( ACC_EVENT_NAME, onAccelerometer )
-----------------------------------------------------------------------------------------
return scene