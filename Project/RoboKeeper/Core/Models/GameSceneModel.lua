-- requires
-----------------------------------------------------------------------------------------
    local json = require("json")
    local tiledModule = require("com.ponywolf.ponytiled")
    local buttonModule = require("com.ponywolf.plugins.button")

    local robotModule = require("Core.Objects.Robot.Robot" )
    local enemyRobotModule = require("Core.Objects.EnemyRobot.EnemyRobot")
    local gripperModule = require("Core.Objects.Gripper.Gripper")
    local boxModule = require("Core.Objects.Box.Box")
-- consts
-----------------------------------------------------------------------------------------
    local const MAP_PATH = "Assets/TiledMaps/GameScene.json"
-- declarations
-----------------------------------------------------------------------------------------
    local M = {}
-- fabric method    
-----------------------------------------------------------------------------------------
    function M.new(_model, _presenter)
    -- constructor 
    -----------------------------------------------------------------------------------------
        local presenter = _presenter

        function _model:initMap()    
            local mapData = json.decodeFile(system.pathForFile(MAP_PATH, system.ResourceDirectory))
            local map = tiledModule.new(mapData, ASSETS_PATH)

            local wallBuffer = map:findObject("WallLeft")
            wallBuffer.isVisible = false
            physics.addBody(wallBuffer)

            local wallBuffer = map:findObject("WallRight")
            wallBuffer.isVisible = false
            physics.addBody(wallBuffer)  

            return map
        end

        function _model:initMainRobot(_map)
            local robot = {}
            robot = robotModule.new(_map)            

            return robot
        end

        function _model:initGripper(_map)
            local gripper = {}
            gripper = gripperModule.new(_map)

            return gripper
        end

        function _model:createBox()
            local box = boxModule.new()

            return box
        end

        function _model:initEnemyRobot(_map, _trackingInstance, _boxesAmount)
            boxes = {}
            for i = 0, BOXES_AMOUNT - 1 do
                boxes[i] = self:createBox()
                boxes[i].x = display.contentCenterX
                boxes[i].y = display.contentCenterY + display.contentHeight
                boxes[i].blocked = true
            end

            local gripper = self:initGripper(_map)

            local enemyRobot = {}
            enemyRobot = enemyRobotModule.new(_map, gripper, boxes, _trackingInstance)

            return enemyRobot        
        end

        function _model:initBorders(_map)
            local wallRight = _map:findObject("WallRight")
            local wallLeft = _map:findObject("WallLeft")
            local xBorderRight = wallRight.x - wallRight.width 
            local xBorderleft = wallLeft.x + wallLeft.width

            return xBorderleft, xBorderRight
        end
    end

return M