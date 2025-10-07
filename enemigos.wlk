import naves.*
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

  method vida() = vida

  method bajarVida() {
    vida = vida - 1
    if (vida < 1) {self.destruir()}
  }

  method disparado() { 
    self.bajarVida()
  }

  // Lo destruye un proyectil
  method destruir() {
    nave.sumarPuntaje(valor)
    game.removeVisual(self)
  }
  
  method destruirPorEscape() {
    nave.sumarPuntaje(-1) 
    game.removeTickEvent("a la izquierda")
    game.removeVisual(self)
  }
 
  method moverALaIzquierda() {
    if (position.x() > 0) {
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






