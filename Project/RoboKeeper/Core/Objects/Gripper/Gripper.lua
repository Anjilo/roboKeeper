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
        local const STD_GRIPPER_VELOCITY = 21
    -- private decls
    
    -----------------------------------------------------------------------------------------        
        local group = nil
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
        local instance = _map:findObject("Gripper")
        instance.name = "Gripper"
    -- constructor    
    -----------------------------------------------------------------------------------------        
        group = display.newGroup()
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

        group:insert(gripperLeft)
        group:insert(gripperMidDown)
        group:insert(gripperMidUp)
        group:insert(gripperRight)
        group:insert(gripperRope)
        group:insert(gripperBinding)

        gripperMidUp.x, gripperMidUp.y = x, y - gripperMidUp.height / 3.5 - gripperRope.height / 3
        gripperRight.x, gripperRight.y = x + gripperMidDown.width / 2, y + gripperRight.height / 3.5 - gripperRope.height / 3
        gripperLeft.x, gripperLeft.y = x - gripperMidDown.width / 1.5, y + gripperLeft.height / 3.5 - gripperRope.height / 3
        gripperMidDown.x, gripperMidDown.y = x, y - gripperRope.height / 3

        local function getGripperLeftOffset()
            return (-1) * gripperMidDown.width / 1.5
        end

        local function getGripperMidDownOffset()
            return  (-1) * gripperMidDown.width / 4.5
        end
        
        local function getGripperMidUpOffset()
            return 0
        end

        local function getGripperRightOffset()
            return gripperMidDown.width / 2    
        end

        local function getGripperRopeOffset()
            return 0    
        end

        local function getGripperBindingOffset()
            return 0    
        end

        local function getBoxOffset()
            return 0
        end

    -- box setter
    -----------------------------------------------------------------------------------------            
        local function setBox(_box)
            box = _box
            box.blocked = true
            box.x = gripperRope.x
            box.y = gripperMidDown.y + (box.height / 3) * 2
            group:insert(box)
            gripperRight:toFront()
        end

    -- release box
    -----------------------------------------------------------------------------------------     
        local function dropBox()
            if (box ~= nil) then
                box.blocked = false
                box = nil                
            end
        end 

    -- gripper reset
        function instance:reset()
            if (box ~= nil) then
                gripped = false
                box.x = display.contentCenterX - display.contentWidth
                box.blocked = false
                box = nil
            end
        end

    -- getter group position
    -----------------------------------------------------------------------------------------            
        function instance:getPosition()
            return gripperMidUp.x, gripperMidUp.y
        end 

    -- gripper state method 
    ----------------------------------------------------------------------------------------- 
        function instance:isGripped()
            return gripped
        end

    -- gripper speed getter
    ----------------------------------------------------------------------------------------- 
        function instance:getSpeed()
            return STD_GRIPPER_VELOCITY
        end

    -- open gripper method    
    ----------------------------------------------------------------------------------------- 
        function instance:grip(_box)
            if (gripped == false) then
                gripperLeft.x = gripperLeft.x + GRIPPER_PLATES_OFFSET
                gripperRight.x = gripperRight.x - GRIPPER_PLATES_OFFSET
                gripperMidDown.x = gripperMidDown.x + GRIPPER_PLATES_OFFSET 

                if (_box ~= nil) then
                    setBox(_box)
                end

                gripped = true
            end
        end

    -- close gripper method    
    -----------------------------------------------------------------------------------------            
        function instance:ungrip()
            if (gripped == true) then
                gripperLeft.x = gripperLeft.x - GRIPPER_PLATES_OFFSET
                gripperRight.x = gripperRight.x + GRIPPER_PLATES_OFFSET
                gripperMidDown.x = gripperMidDown.x - GRIPPER_PLATES_OFFSET
                dropBox()
                gripped = false
            end
        end

    -- move gripper    
    -----------------------------------------------------------------------------------------            
        function instance:move(_direction)            
            local directionSign = 1
            if (_direction < 0) then
                directionSign = -1
            end
            gripperLeft.x = gripperLeft.x + STD_GRIPPER_VELOCITY * directionSign
            gripperRight.x = gripperRight.x + STD_GRIPPER_VELOCITY * directionSign
            gripperMidUp.x = gripperMidUp.x + STD_GRIPPER_VELOCITY * directionSign
            gripperMidDown.x = gripperMidDown.x + STD_GRIPPER_VELOCITY * directionSign
            gripperRope.x = gripperRope.x + STD_GRIPPER_VELOCITY * directionSign
            gripperBinding.x = gripperBinding.x + STD_GRIPPER_VELOCITY * directionSign

            if (box ~= nil) then
                box.x = box.x + STD_GRIPPER_VELOCITY * directionSign
            end
        end
-- 
    -- move ripper to absolute pos
    ----------------------------------------------------------------------------------------- 
        function instance:absMove(_x)
            gripperLeft.x = _x + getGripperLeftOffset() 
            gripperRight.x = _x + getGripperRightOffset() 
            gripperMidUp.x = _x + getGripperMidUpOffset() 
            gripperMidDown.x = _x + getGripperMidDownOffset()          
            gripperRope.x = _x + getGripperRopeOffset()
            gripperBinding.x = _x + getGripperBindingOffset()

            if (box ~= nil) then
                box.x = _x + getBoxOffset()
            end
        end                           

        return instance
    end


return M