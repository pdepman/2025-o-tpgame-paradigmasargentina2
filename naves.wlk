import powerUps.*
object nave {
  var position = game.at(0,10)
  
  var property vida = 3

  var puntaje = 0

  method puntaje()= puntaje

  var proyectilesActivos = []

  method proyectilesActivos() = proyectilesActivos

  method sumarPuntaje(puntos){
    puntaje= puntaje+puntos
  }

  method image() = "nave.gif"
  
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
    proyectilesActivos.add(nuevoProyectil)
    nuevoProyectil.initialize()
    game.onTick(250, "hacia la derecha", { nuevoProyectil.moverALaDerecha() })
  }
  
  method dispara(proyectil) {
    game.addVisual(proyectil)
  }

  method choqueEnemigo(){
    vida= vida-1
  }

  method disparado(){}

  method initialize() {}
}

class Proyectil {
  var position = game.at(0, 0)
  
  method position() = position
  
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method destruir(){
    game.removeVisual(self)
  }

  method moverALaDerecha() {
    position = position.right(1)
  }
  
  method image() = "proyectil1.gif"

  method initialize(){
        game.whenCollideDo(self, {elemento=> 
        elemento.disparado()})
    }

  method choqueEnemigo(){
    self.destruir()
  }


}