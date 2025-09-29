import naves.*
class Enemigo {
  var property image = "imagenEjemplo.png"
  var property position = game.at(
    29,
    0.randomUpTo(20).truncate(0) // y random
  )
  var property vida = 1
  var property valor = 2
  
  method disparado() {
    vida -= 1
    nave.sumarPuntaje(valor)
    if (vida < 1) self.destruir()
  }
  // Lo destruye un proyectil
  method destruir() {
    nave.sumarPuntaje(valor * 2)
    game.removeVisual(self)
  }
  /*
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
  */
  method initialize() {

    game.whenCollideDo(self, { elemento => elemento.choqueEnemigo() })
  /*
    game.onTick(1000, "a la izquierda" , { self.moverALaIzquierda() })

  */  
  }
}