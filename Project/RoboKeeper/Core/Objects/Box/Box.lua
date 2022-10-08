-- requires
-----------------------------------------------------------------------------------------

-- decls
------------------------------------------------------------------------------------------
local M = {}
-- fabric method
-----------------------------------------------------------------------------------------
    function M.new()
    -- private consts
    -----------------------------------------------------------------------------------------
        local const BOX_FILENAME = "Assets/Objects/Box.png"
        local const FALLING_SPEED = 6
    -- private decls
    -----------------------------------------------------------------------------------------     
    
    -- public decls
    -----------------------------------------------------------------------------------------     
        local instance = display.newImage(BOX_FILENAME)       
        instance.blocked = false     
        instance.name = "Box"
    
    -- constructor    
    -----------------------------------------------------------------------------------------  

        local colliderParams = {
            halfWidth = instance.width / 2,
            halfHeight = instance.height / 2,
            x = 0,
            y = 0
        }

        local bodyParams = {
            box = colliderParams,
            isSensor = true
        }   

        physics.addBody(instance, "kinamatic", bodyParams)

    -- falling box method
    -----------------------------------------------------------------------------------------            
        function instance:falling()
            if (self.blocked == false) then    
                if (self.y < display.screenOriginY + display.contentHeight * 1.5) then
                    self.y = self.y + FALLING_SPEED   
                end
            end
        end

        return instance
    end

return M