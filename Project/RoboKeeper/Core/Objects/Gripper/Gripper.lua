-- requires
-----------------------------------------------------------------------------------------

-- decls
------------------------------------------------------------------------------------------
    local M = {}
-- fabric method
-----------------------------------------------------------------------------------------
    function M.new(_map)
    -- private consts
    -----------------------------------------------------------------------------------------
        local const GRIPPER_LEFT_FILENAME = "Assets/Objects/gripper_left_part.png"
        local const GRIPPER_RIGHT_FILENAME = "Assets/Objects/gripper_right_part.png"
        local const GRIPPER_MID_DOWN_FILENAME = "Assets/Objects/gripper_mid_down_part.png"
        local const GRIPPER_MID_UP_FILENAME = "Assets/Objects/gripper_mid_up_part.png"
        local const GRIPPER_ROPE_FILENAME = "Assets/Objects/gripper_rope.png"
        local const GRIPPER_BINDING_FILENAME = "Assets/Objects/gripper_binding.png"

        local const GRIPPER_PLATES_OFFSET = 10
    -- private decls
    -----------------------------------------------------------------------------------------        
        local gripperLeft = nil
        local gripperRight = nil
        local gripperMidUp = nil
        local gripperMidDown = nil
        local gripperRope = nil
        local gripperBinding = nil

        local box = nil

        local gripped = false
    -- public decls
    -----------------------------------------------------------------------------------------            
        instance = {}
    -- constructor    
    -----------------------------------------------------------------------------------------        
        local instance = _map:findObject("Gripper")
        local x, y = instance.x, instance.y
        instance.isVisible = false

        gripperLeft = display.newImage(GRIPPER_LEFT_FILENAME)
        gripperMidDown = display.newImage(GRIPPER_MID_DOWN_FILENAME)
        gripperMidUp = display.newImage(GRIPPER_MID_UP_FILENAME)
        gripperRight = display.newImage(GRIPPER_RIGHT_FILENAME)

        gripperRope = _map:findObject("GripperBindingRope")
        gripperRope.x = x
        gripperBinding = _map:findObject("GripperBinding")
        gripperBinding.x = x

        gripperMidUp.x, gripperMidUp.y = x, y - gripperMidUp.height / 3.5 - gripperRope.height / 3
        gripperRight.x, gripperRight.y = x + gripperMidDown.width / 2, y + gripperRight.height / 3.5 - gripperRope.height / 3
        gripperLeft.x, gripperLeft.y = x - gripperMidDown.width / 1.5, y + gripperLeft.height / 3.5 - gripperRope.height / 3
        gripperMidDown.x, gripperMidDown.y = x - gripperMidDown.width /4.5, y - gripperRope.height / 3

    -- gripper state method 
    ----------------------------------------------------------------------------------------- 
        function instance:isGripped()
            return gripped
        end

    -- open gripper method    
    ----------------------------------------------------------------------------------------- 
        function instance:grip()
            if (gripped == false) then
                gripperLeft.x = gripperLeft.x + GRIPPER_PLATES_OFFSET
                gripperRight.x = gripperRight.x - GRIPPER_PLATES_OFFSET
                gripperMidDown.x = gripperMidDown.x + GRIPPER_PLATES_OFFSET

                gripped = true
            end
        end

    -- close gripper method    
    -----------------------------------------------------------------------------------------            
        function instance:ungrip()
            if (gripped == true) then
                gripperLeft.x = gripperLeft.x - GRIPPER_PLATES_OFFSET
                gripperRight.x = gripperRight.x + GRIPPER_PLATES_OFFSET
                gripperMidDown = gripperMidDown.x - GRIPPER_PLATES_OFFSET

                gripped = false
            end
        end

    -- fabric method to create box
    -----------------------------------------------------------------------------------------            
        function instance:createBox()
        end

    -- move gripper    
    -----------------------------------------------------------------------------------------            
        function instance:move(_offset)
            gripperLeft.x = gripperLeft.x + _offset
            gripperMidDown.x = gripperMidDown.x + _offset
            gripperMidUp.x = gripperMidUp.x + _offset
            gripperRight.x = gripperRight.x + _offset
            gripperRope.x = gripperRope.x + _offset
            gripperBinding.x = gripperBinding.x + _offset
        end


        return instance
    end


return M