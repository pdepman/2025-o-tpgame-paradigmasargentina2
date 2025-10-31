import dificultades.*
import naves.*
object puntaje{
    method position()=game.center()
    method text() = "Puntaje: " + nave.puntaje()
    method choqueEnemigo(){}
    method disparado(){}
}

// testeo de vida de la nave
// object vida{
//     method position()=game.at(5,5)
//     method text() = "Puntaje: " + nave.vida()
//     method choqueEnemigo(){}
//     method disparado(){}
// }

object nivel{
    method position() = game.at(1,1)
    method text() = "Nivel: " + controlDeDificultad.contadorDeNivel()
    method choqueEnemigo(){}
    method disparado(){}
}