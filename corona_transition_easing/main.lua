local easingx  = require("easing")

local square = display.newRect( 0, 0, 100, 100 )
square:setFillColor( 255,255,255 )

square.x = display.contentWidth / 2
square.y = 150

--[[
local w,h = display.contentWidth, display.contentHeight

-- move square to bottom right corner; subtract half side-length b/c 
-- the local origin is at the square’s center; fade out square
transition.to( square, { time=1500, alpha=0, x=(w-50), y=(h-50) } )

-- fade square back in after 2.5 seconds
transition.to( square, { time=500, delay=2500, alpha=1.0 } )
--]]


transition.from( square,
                 {
                	time = 2500,
	                x = display.contentWidth / 2,
	                y = display.contentHeight - 150,
					--transition = easingx.easeIn
					--transition = easingx.easeOut
					--transition = easingx.easeInOut
					--transition = easingx.easeOutIn
					--transition = easingx.easeInBack
					--transition = easingx.easeOutBack
					--transition = easingx.easeInOutBack
					--transition = easingx.easeOutInBack
					--transition = easingx.easeInElastic
					--transition = easingx.easeOutElastic
					transition = easingx.easeInOutElastic
					--transition = easingx.easeOutInElastic
					--transition = easingx.easeInBounce
					--transition = easingx.easeOutBounce
					--transition = easingx.easeInOutBounce
					--transition = easingx.easeOutInBounce 
                } )



