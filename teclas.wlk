import pantallas.*
import naves.*
import interfaz.*
// configuracion para las teclas segun la pantalla activa
object espacio{
    method init(){
        if (nave.activa()){
            nave.disparaProyectil() 
        }
        else if(flechita.activa()){
            flechita.seleccionar()
        }
        else if(inicio.activa()){
            inicio.jugar()
        }
    }
}

object flechaAbajo{
    method init(){
        if (nave.activa()){
           nave.moverAbajo() 
        }
        else if(flechita.activa()){
            flechita.elegir()
        }
    }
}

object flechaArriba{
    method init(){
        if (nave.activa()){
            nave.moverArriba()
        }
        else if(flechita.activa()){
            flechita.elegir()
        }
    }
}

object controlDeTeclas{
    
    method initialize(){
        keyboard.right().onPressDo({ nave.moverALaDerecha() })
        keyboard.left().onPressDo({ nave.moverALaIzquierda() })
        keyboard.up().onPressDo({ flechaArriba.init() })
        keyboard.down().onPressDo({ flechaAbajo.init() })

        //Con espacio se lanza proyectil
        keyboard.space().onPressDo({espacio.init()})

    }
}