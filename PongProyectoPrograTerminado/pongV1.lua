function love.load()

    --CREACIÓN DE OBJETOS QUE SE USAN EN EL JUEGO: PELOTA Y LOS JUGADORES.
    pelota= {}
    pelota.x= love.graphics.getWidth()/2
    pelota.y= love.graphics.getHeight()/2
    pelota.velocidad=10
    pelota.moverseDerecha= true
    pelota.moverseArriba= false
    pelota.radio=20

    player1={}
    player1.cordeY= love.graphics.getHeight()/2   
    player1.contador=0
    player1.velocidad=10
    player1.altura=80
    player1.ancho=25

    player2={}
    player2.cordeY= love.graphics.getHeight()/2
    player2.contador=0
    player2.velocidad=10
    player2.altura=80
    player2.ancho=25

    --OBJETOS DE CONFIGURACION
    ventana={}
    ventana.tam= love.window.setMode(800,600)
    ventana.color= love.graphics.setBackgroundColor(0,0,0,0)
    ventana.titulo=love.window.setTitle("Pong - Progra III")
    ventana.altura= love.graphics.getHeight()-player2.altura
    ventana.ancho= love.graphics.getWidth()

    font={}
    font.mainFont= love.graphics.newFont("/franchise_2/Franchise.ttf",50)
    

end

function love.update(dt)
   --Referencia: https://love2d.org/wiki/love.keyboard.isDown 
   useKeyboard(player1,player2)
   bola(pelota)

end

function useKeyboard(player1,player2)

    --JUGADOR 1
    if love.keyboard.isDown("w") and player1.cordeY >= 1 then
        player1.cordeY = player1.cordeY - player1.velocidad   
    end

    if love.keyboard.isDown("s")  and player1.cordeY <= ventana.altura then
        player1.cordeY = player1.cordeY + player1.velocidad   
   end

    --PLAYER 2

    if love.keyboard.isDown("up") and player2.cordeY >=1 then
        player2.cordeY = player2.cordeY - player2.velocidad   
    end

    if love.keyboard.isDown("down") and player2.cordeY <= ventana.altura then
        player2.cordeY = player2.cordeY + player2.velocidad   
    end
   
   return player1.cordeY , player2.cordeY 
end


function bola(pelota)

    if pelota.moverseArriba ==true then
        pelota.y=pelota.y-pelota.velocidad
        --Si cae en el else, va para abajo
        else
            pelota.y= pelota.y+pelota.velocidad
            
    end

    if pelota.moverseDerecha then
        pelota.x=pelota.x+pelota.velocidad
        --Si cae en el else, va para la izquierda
        else
            pelota.x=pelota.x-pelota.velocidad

    end
    
    if (pelota.x+pelota.radio) >= love.graphics.getWidth() then
        pelota.moverseDerecha=false
    end

    if (pelota.x-pelota.radio) <= 0 then
        pelota.moverseDerecha=true
    end

    if (pelota.y+pelota.radio) >= love.graphics.getHeight() then
        pelota.moverseArriba=true
    end

    if (pelota.y-pelota.radio) <= 0 then
        pelota.moverseArriba=false
    end

end

function love.draw()

    --Referencia: https://love2d.org/wiki/love.graphics.circle
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle("fill", 50, player1.cordeY, player1.ancho, player1.altura)
    love.graphics.rectangle("fill", 700, player2.cordeY, player2.ancho, player2.altura)
    love.graphics.setFont(font.mainFont)
    love.graphics.print(player1.contador, 200, 40)
    love.graphics.print(player2.contador, 600, 40)
    love.graphics.circle("fill",pelota.x,pelota.y,pelota.radio)
end
