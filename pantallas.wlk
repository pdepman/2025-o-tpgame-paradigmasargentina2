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
        // nave con movimiento
        activa = true
        game.addVisual(nave)
        nave.initialize()
           
        //puntaje
        game.addVisual(puntaje)

        //enemigos y dificultad
        game.addVisual(nivel)

        //vida
        game.addVisual(vida)

        //PowerUps Solo los genera cuando se pueda

        game.onTick(5000, "spawnPowerUp", {powerUpGenerador.crearCuandoSeNecesite()})
        // controladorDePowerUps.initialize()

    }

    method activa() = activa

    method desactivar(){
        // la nave no dispara mas proyectiles
        // no spawnean mas enemigos ni powerups
        activa = false
        nave.desactivar()
        game.removeTickEvent("spawnPowerUp")
        controlDeDificultad.desactivar()
        // limpiarPantalla.activar()
    }

    method activar(){
        activa = true
        nave.activar()
        game.onTick(5000, "spawnPowerUp", {powerUpGenerador.crearCuandoSeNecesite()})
        controlDeDificultad.activar()
    }

}

object gameOver{

    var activa = false

    method image() = "gameovergrande.png"

    var property position = game.at(0,0)

    method initialize(){
        self.activarAutomaticamente()
    }

    method activa() = activa

    method activar(){
        game.addVisual(self)
        activa = true
        self.agregarElementos()
        
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
                pantallaDeJuego.desactivar()
                game.removeTickEvent("chequear estado de la nave")
            }
        })

    }

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
    

}
// object limpiarPantalla{

//     method image() = "transparente.png"

//     var property position = game.at(0,0)

//     method activar(){
//         game.whenCollideDo(self,{objeto => objeto.remover()})
//     }

// }

object controlDePantallas{

    method desactivarTodas(){
        pantallaDeJuego.desactivar()
        gameOver.desactivar()
    }

}