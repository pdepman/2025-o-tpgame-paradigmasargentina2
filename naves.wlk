object nave {
  var position = game.at(0, 0)
  
  method image() = "imagenEjemplo2.png"
  
  method position() = position
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method moverALaDerecha() {
    position = position.right(1)
  }
  
  method moverALaIzquierda() {
    position = position.left(1)
  }
  
  method moverArriba() {
    position = position.up(1)
  }
  
  method moverAbajo() {
    position = position.down(1)
  }
  
  method disparaProyectil() {
    const nuevoProyectil =  new Proyectil(position = self.position().right(1))
    self.dispara(nuevoProyectil)
    game.onTick(250, "hacia la derecha", { nuevoProyectil.moverALaDerecha() })
  }
  
  method dispara(proyectil) {
    game.addVisual(proyectil)
  }
}

class Proyectil {
  var position = game.at(0, 0)
  
  method position() = position
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method moverALaDerecha() {
    position = position.right(1)
  }
  
  method image() = "imagenEjemplo.png"
}