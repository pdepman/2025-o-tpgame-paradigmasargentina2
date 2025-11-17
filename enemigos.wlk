import naves.*
import dificultades.*
class Enemigo {
  const image
  method image() = image
  var vida
  const valor
  var velocidadEnemigo = 1000
  var property position = game.at(
    29, 
    0.randomUpTo(20).truncate(0) // y random
  )
  var property seEscapo = false

  method vida() = vida

  method bajarVida() {
    vida = vida - 1
    if (vida < 1) {
      self.posicion(game.at(-1,-2))
      // lo mueve a donde no interactua con otros objetos
      // remueve el "cuadrado invisible" que le quita vida a la nave y detiene proyectiles
      self.destruir()
      }
  }

  method disparado() { 
    self.bajarVida()
  }

  method remover(){
    game.removeVisual(self)
    controlDeDificultad.removerEnemigo(self)
  }

  // Lo destruye un proyectil
  method destruir() {
    nave.sumarPuntaje(valor)
    game.removeVisual(self)
    controlDeDificultad.removerEnemigo(self)
  }
  
  method posicion(posicion){position = posicion}

  method destruirPorEscape() {
    if (!seEscapo){
      self.posicion(game.at(-1,-1)) //lo manda fuera de pantalla
      // donde no colisiona con otros objetos
      seEscapo = true
      nave.sumarPuntaje(-1)
      game.removeVisual(self)
      controlDeDificultad.removerEnemigo(self)
    }
  }
 
  method moverALaIzquierda() {
    if (position.x() != 0) {
        position = position.left(1)
    } else {
        self.destruirPorEscape()
    }
  }

  // elimina el posible error si dos enemigos colisionan
  method choqueEnemigo(){}
  
  method initialize() {
    
    game.whenCollideDo(self, { elemento => elemento.choqueEnemigo() })
  
    game.onTick(velocidadEnemigo, "a la izquierda" , { self.moverALaIzquierda() })

  
  }
}

class EnemigoDebil inherits Enemigo(
  image = "enemigoUno.png",
  vida = 1,
  valor = 1
){}

class EnemigoMedio inherits Enemigo(
  image = "enemigoDos.png",
  vida = 2,
  valor = 2
) {}

class EnemigoFuerte inherits Enemigo(
  image = "enemigoTres.png",
  vida = 3,
  valor = 3
) {}






