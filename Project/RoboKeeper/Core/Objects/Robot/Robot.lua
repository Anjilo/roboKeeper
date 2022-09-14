-- requires
-----------------------------------------------------------------------------------------
    local sheetInfo = require("Core.Objects.Robot.RobotSheet")
-- decls
-----------------------------------------------------------------------------------------
    local M = {}
-- fabric method
------------------------------------------------------------------------------------------
    function M.new(_map)
    -- private consts
    -----------------------------------------------------------------------------------------
        local const IMAGE_SHEET_FILENAME = "Assets/Objects/MainRobot/RobotSheet.png"
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

        local instance = _map:findObject("MainRobot")

        local sheet = {}

    -- constructor
    ----------------------------------------------------------------------------------------
        local x, y = instance.x, instance.y
        local parent = instance.parent    
        instance.isVisible = false        

        sheet = graphics.newImageSheet(IMAGE_SHEET_FILENAME, sheetInfo:getSheet())
        instance = display.newSprite( sheet , sequenceData )
        instance.x = x
        instance.y = y
        instance:scale(1.5, 1.5)
        instance:setSequence(IDLE_SEQ_NAME)
        instance:play()

        -- change direction method
        ----------------------------------------------------------------------------------------
        function instance:updateDirection(_direction)
            local seqName = ""

            if (_direction == true) then
                seqName = RUN_FRWRD_SEQ_NAME
            else
                seqName = RUN_BCKRWRD_SEQ_NAME
            end

            if (seqName ~= self.sequence) then
                self:setSequence(seqName)  
                self:play()              
            end
        end

        -- move method--
        ----------------------------------------------------------------------------------------
        function instance:move(_speed)
            self:updateDirection(_speed <= 0)
            self.x = self.x + _speed * 50
        end

        return instance
    end
return M