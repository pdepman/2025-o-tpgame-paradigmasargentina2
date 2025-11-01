import pantallas.*
import naves.*
// configuracion para las teclas segun la pantalla activa

object espacio{
    method init(){
        if (nave.activa()){
            nave.disparaProyectil() 
        }
    }
}