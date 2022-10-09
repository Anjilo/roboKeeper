-- requires
-----------------------------------------------------------------------------------------
    local buttonModule = require("com.ponywolf.plugins.button") 
-- decls
------------------------------------------------------------------------------------------
    local M  = {}
-- fabric method
-----------------------------------------------------------------------------------------
    function M.new(_map)
    -- private consts
    ----------------------------------------------------------------------------------------
        local const RELOAD_BUTTON_NAME = "ReloadButton"
        local const BUTTON_MOVE_TIME = 1000
    -- private decls
    ----------------------------------------------------------------------------------------
        local instance = _map:findObject(RELOAD_BUTTON_NAME)
    -- constructor
    ----------------------------------------------------------------------------------------        
        instance = buttonModule.new(instance)
        instance.enabled = false

    -- start x pos getter
    ----------------------------------------------------------------------------------------
        local function getStartPosX()
            return display.contentCenterX + display.contentWidth / 2 + instance.contentWidth / 2 + 16
        end

    -- end game event listener
    ----------------------------------------------------------------------------------------
        local function endGameListener(_event)
            transition.to(instance, { x = display.contentCenterX , time = BUTTON_MOVE_TIME, onComplete = function()
                    instance.enabled = true 
                end})
        end

    -- ui event listener    
    ----------------------------------------------------------------------------------------
        local function uiEventListener(_event)
            instance.enabled = false
            instance.x = getStartPosX()
        end

        instance.x = getStartPosX()

    -- event listeners
    ----------------------------------------------------------------------------------------
        Runtime:addEventListener( END_GAME_EVENT_NAME, endGameListener )
        Runtime:addEventListener( UI_EVENT_NAME, uiEventListener )

        return instance
    end

    return M