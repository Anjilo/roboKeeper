-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
-- requires
    local composer = require "composer"
-- consts
-----------------------------------------------------------------------------------------
    IS_SIMULATOR = "simulator" == system.getInfo("environment")

    ASSETS_PATH = "Assets\\Objects"

    ENTER_FRAME_EVENT_NAME = "enterFrame"
    CREATE_SCENE_EVENT_NAME = "create"
    SHOW_SCENE_EVENT_NAME = "show"
    HIDE_SCENE_EVENT_NAME = "hide"
    DESTROY_SCENE_EVENT_NAME = "destroy"
-- source
-----------------------------------------------------------------------------------------
    display.setStatusBar( display.HiddenStatusBar )
    composer.gotoScene( "Core.Scenes.GameScene", "fade" )