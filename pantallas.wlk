import wollok.game.*
import example.pepita
import naves.*
import enemigos.*
import interfaz.*
import powerUps.*
import dificultades.*
import teclas.*

object pantallaDeJuego{
    // funciones de la pantalla de juego

    var activa = false

    method initialize(){           
    }

    method activa() = activa

    method desactivar(){
        // la nave no dispara mas proyectiles
        // no spawnean mas enemigos ni powerups
        activa = false
        nave.desactivar()
        self.removerElementos()
        game.removeTickEvent("spawnPowerUp")
        controlDeDificultad.desactivar()
        // limpiarPantalla.activar()
    }

    method activar(){
        activa = true
        // limpiar pantalla de enemigos y proyectiles
        nave.activar()
        self.agregarElementos()
        game.onTick(5000, "spawnPowerUp", {powerUpGenerador.crearCuandoSeNecesite()})
        controlDeDificultad.activar()
    }

    method agregarElementos(){
	    game.addVisual(nave)
        game.addVisual(puntaje)
        game.addVisual(nivel)
        game.addVisual(vida)

    }

    method removerElementos(){
        game.removeVisual(nave)
        game.removeVisual(puntaje)
        game.removeVisual(nivel)
        game.removeVisual(vida)
    }


}

object gameOver{

    var activa = false

    method image() = "gameover.png"

    var property position = game.at(0,0)

    method initialize(){
    }

    method activa() = activa

    method activar(){
        //limpiarPantalla.activar()
        game.addVisual(self)
        activa = true
        self.agregarElementos()
        pantallaDeJuego.desactivar()        
    }

    method desactivar(){
        activa = false
        game.removeVisual(self)
        self.removerElementos()
    }

    method remover(){}

    method activarAutomaticamente(){
        // Activa la pantalla de gameover cuando
        // La nave se queda sin vida
        game.onTick(1,"chequear estado de la nave",{
            if(nave.vida()<=0 && !self.activa()){
                self.activar()
                game.removeTickEvent("chequear estado de la nave")
            }
        })

    }

    method disparado(){}

    method agregarElementos(){
        // Agrega los elementos que acompañan
        // la pantalla
        reintentar.agregar()
        otraOpcion.agregar()
        flechita.agregar()
    }

    method removerElementos(){
        reintentar.remover()
        otraOpcion.remover()
        flechita.remover()
    }

    method reintentar(){
        // reinicio desde gameover
        self.desactivar()
        pantallaDeJuego.activar()
        self.activarAutomaticamente()
    }
    
    method inicio(){
        self.desactivar()
        inicio.activar()
    }

}

object inicio{

    var activa = false

    method image() = "pantalla_Inicio.png"

    var property position = game.at(0,0)

    method initialize(){
        nave.desactivar()
        game.addVisual(self)
        activa = true
        jugar.agregar()
        gameOver.activarAutomaticamente()
    }

    method activa() = activa

    method activar(){
        game.addVisual(self)
        activa = true
        jugar.agregar() 
    }

    method desactivar(){
        activa = false
        jugar.remover()
        game.removeVisual(self)
    }

    method jugar(){
        self.desactivar()
        pantallaDeJuego.activar()
        gameOver.activarAutomaticamente()
    }

    method disparado(){}


}

object controlDePantallas{

    method desactivarTodas(){
        pantallaDeJuego.desactivar()
        gameOver.desactivar()
    }

}

object limpiarPantalla{

    method image() = "transparente.png"

    var property position = game.at(1,0)

    method position(x,y){
        position = game.at(x,y)
    }

    method activar(){
        nave.proyectilesActivos().forEach({
            proyectil => proyectil.destruir()
        })
        controlDeDificultad.enemigosActivos().forEach({
            enemigo => enemigo.remover()
        })
        powerUpGenerador.listaActivos().forEach({
            powerUp => powerUp.remover()
        })
    }

}

