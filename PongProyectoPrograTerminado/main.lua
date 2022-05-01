-- la funcion love.load() lo que hace es iniciar todas la variables y constantes
-- esta funcion es invocada una unica vez al inicio del programa
function love.load()
    --CMD + L
    --CREACIÓN DE OBJETOS QUE SE USAN EN EL JUEGO: PELOTA Y LOS JUGADORES.

    --se asigna una semilla a la funcion estatica math, para poder generar numeros pseudo aleatoreos
    math.randomseed(os.time())

    --declaracion de objeto juego
    juego={}
    --se crea un atributo a juego para el estado del juego incio y enjuego
    juego.estado = 'inicio'

    --Se crea un objeto pelota
    pelota= {}

    --Se crea la propiedad x la cual va a ser utilizada para obtener o configurar la ubicacion en el plano X
    pelota.x= love.graphics.getWidth()/2
    --Se crea la propiedad Y la cual va a ser utilizada para obtener o configurar la ubicacion en el plano Y
    pelota.y= love.graphics.getHeight()/2
    --Se crea la propiedad velocidad la cual va a ser utilizada para obtener o configurar la velocidad, y es determinada en la cantidad de pixeles 
    --que la bola se va mover en una dirección determinada
    pelota.velocidad=6
    --Se declara un atributo moverseDerecha para para obtener o configurar la direccion en el plano X
    -- condicional en lua no hay ? para condicional (condicional ? true : false;)
    pelota.moverseDerecha = math.random(2) == 1 and true or false
    --Se declara un atributo moverseArriba para para obtener o configurar la direccion en el plano y
    -- condicional en lua no hay ? para condicional (condicional ? true : false;)
    pelota.moverseArriba= math.random(2) == 1 and true or false
    --de declara y asigna un valor para el tamano de la pelota en pixeles
    pelota.radio=20

    --Declara el objeto player1
    player1={}
    --Se declara el atributo y para obtener o configurar en el plano Y
    player1.y= love.graphics.getHeight()/2  
    --Se declara el atributo x para obtener o configurar en el plano X, (50 es 50px del borde de la pantalla iz)
    player1.x= 50
    --Se declara el atributo contador para obtener o configurar el marcador del jugador 1
    player1.contador=0
    --se declara el artibuto velocidad, indica cuantos pixales se mueve
    player1.velocidad=14
    --delcara el tamano de la paleta del jugador 1
    player1.altura=80
    --declara el ancho de la paleta del jugador 1
    player1.ancho=25

    player2={}
    player2.y= love.graphics.getHeight()/2
    player2.x= 700
    player2.contador=0
    player2.velocidad=14
    player2.altura=80
    player2.ancho=25

    --OBJETOS DE CONFIGURACION
    ventana={}
    ventana.tam= love.window.setMode(800,600)
    ventana.color= love.graphics.setBackgroundColor(0,0,0,0)
    ventana.titulo=love.window.setTitle("Pong - Progra III")
    ventana.altura= love.graphics.getHeight()-80
    ventana.ancho= love.graphics.getWidth()

    sounds = {
        ['bola'] = love.audio.newSource('bola.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static')
    }

    font={}
    font.mainFont= love.graphics.newFont("/franchise_2/Franchise.ttf",50)
    

end

function love.update(dt)
   --Referencia: https://love2d.org/wiki/love.keyboard.isDown 
   useKeyboard(player1,player2)
   bola(pelota)
   if juego.estado == 'enjuego' then
        if golpeBola(player1) then
            pelota.x=pelota.x+pelota.velocidad
            pelota.moverseDerecha = true
            sounds['bola']:play()
            --pelota.velocidad = pelota.velocidad*1.05
        end
        if golpeBola(player2) then
            pelota.x=pelota.x-pelota.velocidad
            pelota.moverseDerecha = false
            sounds['bola']:play()
            --pelota.velocidad = pelota.velocidad*1.05
        end
    else
        pelota.x= love.graphics.getWidth()/2
            pelota.y= love.graphics.getHeight()/2
            pelota.moverseDerecha= math.random(2) == 1 and true or false
            pelota.moverseArriba= math.random(2) == 1 and true or false

   end


end

--La función love keypressed recibe un parametro "Key" (tecla) que nos ayuda a intentificar cuál tecla está pulsando el usuario
function love.keypressed(key)
    --Este if determina si el user tocó la tecla "Esc" 
    if key == 'escape' then
        --Una vez determinado tocado esta letra, el juego mediante el método love.event.quit() termina el juego
        love.event.quit()
        --Este else if determina si el user tocó la tecla "enter" o "return"
    elseif key == 'enter' or key == 'return' then
        --Una vez determinado tocado cualquiera de estas letra, el estado del juego (juego.estado) cambia a "Inicio" indicando que el juego ha iniciado
        if juego.estado == 'inicio' then
            --Al haber iniciado el juego, el estado del juego (juego.estado) cambia a "enjuego" indicando que el juego se está jugando
            juego.estado = 'enjuego'
        else
            --Si no ha se ha tocado ninguna de las teclas, el estado del juego (juego.estado) está esperando a iniciar ("inicio")
            juego.estado = 'inicio'
        end
    end
end

--La funcion useKeyboard recibe dos parametros utilizados para indicarle a Love que cuando se toque la tecla indicada haga una determinada opción
function useKeyboard(player1,player2)

    --La función keyboard.isDown identifica la si la "W" y es mayor a 1 entonces le resta la velocidad a la posición para que limitar el borde
    if love.keyboard.isDown("w") and player1.y >= 1 then
        player1.y = player1.y + -player1.velocidad 
    end

    --La función keyboard.isDown identifica la si la "S" y es menor a la altura de la ventana entonces le suma  la velocidad a la posición para que limitar el borde
    if love.keyboard.isDown("s")  and player1.y <= ventana.altura then
        player1.y = player1.y + player1.velocidad   
   end

    --PLAYER 2
    --La función keyboard.isDown identifica la si la "UP" y es mayor a 1 entonces le resta la velocidad a la posición para que limitar el borde
    if love.keyboard.isDown("up") and player2.y >=1 then
        player2.y = player2.y - player2.velocidad 
    end

    --La función keyboard.isDown identifica la si la "DOWN" y es menor a la altura de la ventana entonces le suma  la velocidad a la posición para que limitar el borde
    if love.keyboard.isDown("down") and player2.y <= ventana.altura then
        player2.y = player2.y + player2.velocidad
    end
   
   return player1.y , player2.y 
end


function bola(pelota)

    if juego.estado == 'enjuego' then
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
            player1.contador = player1.contador + 1
            sounds['score']:play()
            juego.estado = 'inicio'
        end

        if (pelota.x-pelota.radio) <= 0 then
            player2.contador = player2.contador + 1
            sounds['score']:play()
            juego.estado = 'inicio'
        endJUGADOR 1

        if (pelota.y+pelota.radio) >= love.graphics.getHeight() then
            pelota.moverseArriba=true
        end

        if (pelota.y-pelota.radio) <= 0 then
            pelota.moverseArriba=false
        end
    end
end

--Funcion que verifica si la bola golpea el lado derecho
function golpeBola(jugador)

    --El if está constantemente verificando sin la posición de la pelota en X es mayor o menor a la del jugador para saber si toca o no un margen máximo
    if pelota.x > jugador.x + jugador.ancho or jugador.x > pelota.x + pelota.radio then
        return false
    end
    --El if está constantemente verificando sin la posición de la pelota en Y es mayor o menor a la del jugador para saber si toca o no un margen máximo
    if pelota.y > jugador.y + jugador.altura or jugador.y > pelota.y + pelota.radio then
        return false
    end 
    return true
    --Si no ocurre lo anterior devuelve un true que significa que no ha tocado
end


function love.draw()

    --Se le indica que utilice el color verde (R,G,B)
    love.graphics.setColor(0,1,0)
    --Se indican los parametros previamente definidos para cree los rectangulos 
    love.graphics.rectangle("fill", player1.x, player1.y, player1.ancho, player1.altura)
    love.graphics.rectangle("fill", player2.x, player2.y, player2.ancho, player2.altura)
    --Se establece la fuente del juego
    love.graphics.setFont(font.mainFont)
    --Se le indica que imprima en pantalla los dos contadores con las posiciones determinadas
    love.graphics.print(player1.contador, 200, 40)
    love.graphics.print(player2.contador, 600, 40)
    --Se indican los parametros previamente definidos para cree la pelota
    love.graphics.circle("fill",pelota.x,pelota.y,pelota.radio)

end