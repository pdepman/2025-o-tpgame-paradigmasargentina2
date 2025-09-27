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

}