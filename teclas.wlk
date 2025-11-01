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