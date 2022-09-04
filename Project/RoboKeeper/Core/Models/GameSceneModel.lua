-- requires
-----------------------------------------------------------------------------------------
    local json = require("json")
    local tiledModule = require("com.ponywolf.ponytiled")
    local buttonModule = require("com.ponywolf.plugins.button")

    local robotModule = require("Core.Objects.Robot.Robot" )
    local enemyRobotModule = require("Core.Objects.EnemyRobot.EnemyRobot")
-- consts
-----------------------------------------------------------------------------------------
    local const MAP_PATH = "Assets\\TiledMaps\\GameScene.json"
-- declarations
-----------------------------------------------------------------------------------------
    local M = {}
-- fabric method    
-----------------------------------------------------------------------------------------
    function M.new(_model, _presenter)
    -- constructor 
        local presenter = _presenter

        function _model.initMap()
            local mapData = json.decodeFile(system.pathForFile(MAP_PATH, system.ResourceDirectory))
            local map = tiledModule.new(mapData, ASSETS_PATH)

            return map
        end

        function _model.initMainRobot(_map)
            local robot = _map:findObject("MainRobot")
            robotModule.new(robot)            

            return robot
        end

        function _model.initEnemyRobot(_map)
            local enemyRobot = _map:findObject("EnemyRobot")
            enemyRobotModule.new(enemyRobot)

            return enemyRobot        
        end
    end

return M