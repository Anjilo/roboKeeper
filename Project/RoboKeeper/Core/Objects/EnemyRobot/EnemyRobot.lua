-- requires
-----------------------------------------------------------------------------------------
    local sheetInfo = require("Core.Objects.EnemyRobot.EnemyRobotSheetInfo")
-- decls
------------------------------------------------------------------------------------------
    local M = {}
-- fabric method
-----------------------------------------------------------------------------------------
    function M.new(_instance)
    -- private consts
    ----------------------------------------------------------------------------------------
        local const IMAGE_SHEET_FILENAME = "Assets\\Objects\\EnemyRobot\\EnemyRobotAnimationSheet.png"

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

    -- constructor
    -----------------------------------------------------------------------------------------
        local x, y = _instance.x, _instance.y
        local parent = _instance.parent
        _instance.isVisible = false

        local sheet = {}

        if (IS_SIMULATOR) then
            sheet = graphics.newImageSheet(IMAGE_SHEET_FILENAME, sheetInfo:getSheet())
        else
            sheet = graphics.newImageSheet(system.pathForFile(IMAGE_SHEET_FILENAME), sheetInfo:getSheet())
        end

        _instance = display.newSprite(parent, sheet, sequenceData)
        _instance.x = x
        _instance.y = y
        _instance:scale(0.7, 0.7)
        -- _instance.timescale = 0.05
        _instance:setSequence(CONTROL_SEQ_NAME)
        _instance:play()
    end

return M