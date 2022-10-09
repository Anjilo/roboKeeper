-- requires
-----------------------------------------------------------------------------------------
    local sheetInfo = require("Core.Objects.EnemyRobot.EnemyRobotSheetInfo")
    local math = require("math")
-- decls
------------------------------------------------------------------------------------------
    local M = {}
-- fabric method
-----------------------------------------------------------------------------------------
    function M.new(_map, _gripper, _boxes, _trackingInstance)
    -- private consts
    ----------------------------------------------------------------------------------------
        local const IMAGE_SHEET_FILENAME = "Assets/Objects/EnemyRobot/EnemyRobotAnimationSheet.png"

        local const ANGRY_SEQ_NAME = "IdleAngry"
        local const CONTROL_SEQ_NAME = "IdleControl"
        local const HAPPY_SEQ_NAME = "IdleHappy"
        local const MAX_ANGRY_SEQ_NAME = "MaxAngry"

        local const MIN_TRACKING_TIME = 19
        local const MAX_TRACKING_TIME = 35
    -- private decls
    -----------------------------------------------------------------------------------------
        local sequenceData = {
            {
                name = ANGRY_SEQ_NAME,
                start = 1,
                count = 27,
                loopCount = 1
            },
            {
                name = CONTROL_SEQ_NAME,
                start = 28,
                count = 25,
                loopCount = 0
            },
            {
                name = HAPPY_SEQ_NAME,
                start = 53,
                count = 21,
                loopCount = 1
            },
            {
                name = MAX_ANGRY_SEQ_NAME,
                start = 74,
                count = 38,
                loopCount = 1
            },    
        }

        local gripper = _gripper
        local boxes = _boxes 
        local currentBoxId = 0
        local instance = _map:findObject("EnemyRobot")
        local sheet = {}
        local trackingInstance = _trackingInstance
        local trackingInstancePosXBuffer = trackingInstance.x
        local currentTrackingTime = 0

    -- status methods
        local preTrackingStatus = nil
        local trackingStatus = nil
        local reloadStatus = nil
    -- public decls
    -----------------------------------------------------------------------------------------         
        instance.name = "EnemyRobot"    

    -- constructor
    -----------------------------------------------------------------------------------------        
        local x, y = instance.x, instance.y
        local parent = instance.parent
        instance.isVisible = false

        sheet = graphics.newImageSheet(IMAGE_SHEET_FILENAME, sheetInfo:getSheet())

        instance = display.newSprite(parent, sheet, sequenceData)
        instance.x = x
        instance.y = y
        instance.execute = nil
        instance:scale(0.6, 0.6)
        instance:setSequence(CONTROL_SEQ_NAME)
        instance:play()

    -- tracking instance setter
    -----------------------------------------------------------------------------------------     
        function instance:setTrackingInstance(_instance)
            trackingInstance = _instance
            trackingInstancePosXBuffer = trackingInstance.x
        end

    -- boxes getter
    -----------------------------------------------------------------------------------------     
        function instance:getBoxes()
            return boxes
        end

    -- gripper getter
    -----------------------------------------------------------------------------------------     
        function instance:getGripper()
            return gripper
        end

    -- reset
    -----------------------------------------------------------------------------------------             
        function instance:reset()
            gripper:reset()
            self.execute = reloadStatus
        end

    -- reload position getter
    -----------------------------------------------------------------------------------------     
        local function getReloadPosition()
            local relativeOffset = display.contentWidth - trackingInstancePosXBuffer
            return display.contentCenterX - display.contentWidth * 0.6 -- relativeOffset
        end

    -- pre tracking status
    -----------------------------------------------------------------------------------------     
        local function preTracking()
            math.randomseed(os.time())
            currentTrackingTime = math.random(MIN_TRACKING_TIME, MAX_TRACKING_TIME)
            instance.execute = trackingStatus
        end

    -- gripper reload
    -----------------------------------------------------------------------------------------     
        local function reload()
            if (gripper ~= nil) then
                local x, y = gripper:getPosition()
                if (x > getReloadPosition()) then
                    gripper:move(-1)
                else
                    currentBoxId = currentBoxId + 1
                    if (currentBoxId > #boxes) then
                        currentBoxId = 0
                    end

                    gripper:grip(boxes[currentBoxId])
                    
                    instance.execute = preTrackingStatus
                end
            end
        end

    -- gripper tracking
    -----------------------------------------------------------------------------------------         
        local function tracking()
            if (gripper ~= nil) and (trackingInstance ~= nil) then
                local direction = 1
                local gripperX, gripperY = gripper:getPosition()

                if (gripperX > trackingInstance.x) then
                    direction = -1
                end

                if (gripper:getSpeed() < math.abs( gripperX - trackingInstance.x )) then
                    gripper:move(direction) 
                else
                    gripper:absMove(trackingInstance.x)
                end
                -- 

                currentTrackingTime = currentTrackingTime - 1
                if (currentTrackingTime <= 0) then
                    gripper:ungrip()
                    trackingInstancePosXBuffer = trackingInstance.x

                    instance.execute = reloadStatus
                end
            end
        end

        preTrackingStatus = preTracking
        trackingStatus = tracking
        reloadStatus = reload

        instance.execute = reloadStatus

        return instance
    end

return M