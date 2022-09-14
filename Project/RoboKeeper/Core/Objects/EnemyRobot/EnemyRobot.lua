-- requires
-----------------------------------------------------------------------------------------
    local sheetInfo = require("Core.Objects.EnemyRobot.EnemyRobotSheetInfo")
-- decls
------------------------------------------------------------------------------------------
    local M = {}
-- fabric method
-----------------------------------------------------------------------------------------
    function M.new(_map)
    -- private consts
    ----------------------------------------------------------------------------------------
        local const IMAGE_SHEET_FILENAME = "Assets/Objects/EnemyRobot/EnemyRobotAnimationSheet.png"

        local const ANGRY_SEQ_NAME = "IdleAngry"
        local const CONTROL_SEQ_NAME = "IdleControl"
        local const HAPPY_SEQ_NAME = "IdleHappy"
        local const MAX_ANGRY_SEQ_NAME = "MaxAngry"
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

        local instance = _map:findObject("EnemyRobot")
        local sheet = {}

    -- constructor
    -----------------------------------------------------------------------------------------        
        local x, y = instance.x, instance.y
        local parent = instance.parent
        instance.isVisible = false

        sheet = graphics.newImageSheet(IMAGE_SHEET_FILENAME, sheetInfo:getSheet())

        instance = display.newSprite(parent, sheet, sequenceData)
        instance.x = x
        instance.y = y
        instance:scale(0.6, 0.6)
        instance:setSequence(CONTROL_SEQ_NAME)
        instance:play()

        return instance
    end

return M