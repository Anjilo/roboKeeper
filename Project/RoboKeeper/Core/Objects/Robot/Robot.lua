-- requires
-----------------------------------------------------------------------------------------
    local sheetInfo = require("Core.Objects.Robot.RobotSheet")
-- decls
-----------------------------------------------------------------------------------------
    local M = {}
-- fabric method
-----------------------------------------------------------------------------------------
    function M.new(_instance)
    -- private consts
    -----------------------------------------------------------------------------------------
        
        local const IMAGE_SHEET_FILENAME = "Assets\\Objects\\MainRobot\\RobotSheet.png"
        local const DEAD_SEQ_NAME = "Dead"
        local const IDLE_SEQ_NAME = "Idle"
        local const JUMP_SEQ_NAME = "Jump"
        local const RUN_BCKRWRD_SEQ_NAME = "RunBackward"
        local const RUN_FRWRD_SEQ_NAME ="RunForward"

    -- private decls    
    -----------------------------------------------------------------------------------------
        local sequenceData = {
            {
                name = DEAD_SEQ_NAME,
                start = 1,
                count = 41,
                loopCount = 1
            },
            {
                name = IDLE_SEQ_NAME,
                start = 42,
                count = 49,
                loopCount = 0
            },
            {
                name = JUMP_SEQ_NAME,
                start = 91,
                count = 61,
                loopCount = 1
            },
            {
                name = RUN_BCKRWRD_SEQ_NAME,
                start = 152,
                count = 25,
                loopCount = 0
            },
            {
                name = RUN_FRWRD_SEQ_NAME,
                start = 177,
                count = 25,
                loopCount = 0
            }
        }

    -- constructor
    ----------------------------------------------------------------------------------------
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
        _instance:scale(2, 2)
        _instance:setSequence(RUN_FRWRD_SEQ_NAME)
        _instance:play()
    end

return M