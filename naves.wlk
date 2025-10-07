import powerUps.*
object nave {
  var position = game.at(0,10)
  
  var property vida = 3

  var puntaje = 0

  method puntaje()= puntaje

  var proyectilesActivos = []

  var velocidadProyectil = 250

  method velocidadProyectil() = velocidadProyectil

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
    game.onTick(velocidadProyectil, "hacia la derecha", { nuevoProyectil.moverALaDerecha() })
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

  var yaImpacto = false
  
  method position() = position
  
  method position(nuevaPosition) {
    position = nuevaPosition
  }
  
  method destruir(){
    game.removeVisual(self)
  }

  // elimina el error cuando un proyectil esta sobre otro
  method disparado() {}

  method moverALaDerecha() {
    position = position.right(1)
  }
  
  method image() = "proyectil1.gif"

  method initialize(){
    //La vida del enemigo baja 1 punto por colision y no una cantidad
    //equivalente al tiempo de contacto con el proyectil

        game.whenCollideDo(self, {elemento=> 
        if (!yaImpacto){
          elemento.disparado()
          }
          yaImpacto = true
        })
    }

  method choqueEnemigo(){
    self.destruir()
  }


}