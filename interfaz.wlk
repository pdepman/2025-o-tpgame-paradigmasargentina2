// interfaz.wlk
import powerUps.*
import dificultades.*
import naves.*
import pantallas.*
object puntaje{
    method position()=game.center()
    method text() = "Puntaje: " + nave.puntaje()
    method choqueEnemigo(){}
    method disparado(){}
}

// testeo de vida de la nave
object vida{
    method position()=game.at(5,5)
    method text() = "Vida: " + nave.vida()
    method choqueEnemigo(){}
    method disparado(){}
}

object nivel{
    method position() = game.at(1,1)
    method text() = "Nivel: " + controlDeDificultad.contadorDeNivel()
    method choqueEnemigo(){}
    method disparado(){}
}

class ObjetoPantalla{

    method agregar(){
        game.addVisual(self)
    }

    method remover(){
        game.removeVisual(self)
    }
}
object reintentar inherits ObjetoPantalla{

    method image() = "reintentar_p_go_1.png"
    method position() = game.at(11,9)
    
}

object otraOpcion inherits ObjetoPantalla{

    method image() = "inicio_p_go_1.png"
    method position() = game.at(11,7)

}

object flechita inherits ObjetoPantalla{
    // flechita seleccionadora

    method image() = "flechita.png"
    var property position = game.at(10,9)
    const reintentar = game.at(10,9)
    const inicio = game.at(10,7)

    var activa = false

    override method agregar(){
        game.addVisual(self)
        activa = true
    }

    override method remover(){
        game.removeVisual(self)
        activa = false
    }

    method activa() = activa

    method elegir(){
        // mueve la flechita entre las 2 opciones
        if(self.position() == reintentar){
            position = inicio
        }
        else{
            position = reintentar
        }
    }

    method seleccionar(){
        // seleccionar una de las opciones disponibles
        if(self.position() == reintentar){
            gameOver.reintentar()
        }
        else if(self.position() == inicio){
            gameOver.inicio()
        }
    }

}

object jugar inherits ObjetoPantalla{

    method image() = "jugar_p_i.png"
    method position() = game.at(11,7)

    var activa = false

    method activar(){
        activa = true
    }

    method desactivar(){
        activa = false
    }

    method activa() = activa

}