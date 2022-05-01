
    function love.load()
    
        posicionInitialX=100
        posicionInitialY=100
        contador=0
        love.window.setMode(500,500)
    end
    
    
    function love.update(dt)
    
        if love.mouse.isDown(posicionInitialX,posicionInitialY,1) then
            --Referencia: https://love2d.org/wiki/love.math.random || https://love2d.org/wiki/love.window.setMode
            setRandomPosition()
           
        end
    
    end
    
    function setRandomPosition()
        posicionInitialX= love.math.random(0,500)
        posicionInitialY= love.math.random(0,500)
        contador=contador+1
        
    end
    
    
    
    function love.draw()
        love.graphics.circle("fill",posicionInitialX,posicionInitialY, 20)
        love.graphics.print(contador)
    end

