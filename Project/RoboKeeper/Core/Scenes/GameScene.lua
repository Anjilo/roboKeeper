-- requires
-----------------------------------------------------------------------------------------
    local composer = require "composer"
    local modelModule = require "Core.Models.GameSceneModel"
-- declarations
----------------------------------------------------------------------------------------
    local scene = composer.newScene()
    local sceneModel = {}

    local mapView = nil
    local mainRobotView = nil
    local enemyRobot = nil
-- source
----------------------------------------------------------------------------------------
    function scene:create(_event)                  
        modelModule.new(sceneModel, scene)
        mapView = sceneModel.initMap()
        mainRobotView = sceneModel.initMainRobot(mapView)
        enemyRobotView = sceneModel.initEnemyRobot(mapView)
    end

    function scene:show(_event)
    end

    function scene:hide(_event)
    end

    function scene:destroy(_event)
    end

    local function onAccelerometer(_event)
        mainRobotView:move(_event.xRaw)
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