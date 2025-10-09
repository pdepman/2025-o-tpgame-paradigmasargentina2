// naves.wlk
import powerUps.*
object nave {
  var position = game.at(0,10)
  
  var property vida = 3

  var puntaje = 0

  method puntaje()= puntaje

  method sumarVida(cant) {
    vida += cant 
  }

  var proyectilesActivos = []

  var velocidadProyectil = 250

  var contDisparos = 0

//PowerUps Creo para poder administrar estado
  
  var inmortalActivo = false
  var tripleActivo = false

  method activarPowerUp(tipo, tiempons) { //Activa el powerup depdniendo de cual es, activando su estado
    if (tipo == "inmortal") { inmortalActivo = true }
    else if (tipo == "triple") { tripleActivo = true }
    game.onTick(tiempons, "fin_" + tipo, { self.desactivarPowerUp(tipo) })
  }

  method desactivarPowerUp(tipo) {
    if (tipo == "inmortal") { inmortalActivo = false }
    else if (tipo == "triple") { tripleActivo = false }
    game.removeTickEvent("fin_" + tipo)
  }  

  method estaActivo(tipo) {
    if (tipo == "inmortal") inmortalActivo
    else if (tipo == "triple") tripleActivo
    else false
  }

  method proximoIdTick() { //Creo apra que cada disparo tenga su propio id en el tick y no lo compartan
    contDisparos = contDisparos + 1
    return "proy_" + contDisparos.toString()
  }

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
  
  method disparaProyectil() { //Decide como disparar, dependiendo de si tiene powerup o no
    if (tripleActivo) self.disparoTriple()
    else self.dispararProyectil(self.position())
  } 

  method dispararProyectil(posInicial) {
    const p = new Proyectil(position = posInicial.right(1))   // nace delante de la nave
    self.dispara(p)
    proyectilesActivos.add(p)
    p.initialize()
    const id = self.proximoIdTick() //Crea los ontick en abse al nombre del proyectil
    game.onTick(velocidadProyectil, id, { p.moverALaDerecha() })
  }

  

  method disparoTriple() {
    const base = self.position()
    self.dispararProyectil(base.up(1))
    self.dispararProyectil(base)
    self.dispararProyectil(base.down(1))
  }

  method dispara(proyectil) {
    game.addVisual(proyectil)
  }

  method choqueEnemigo(){
    self.position(game.at(0,10))
    vida = vida - 1
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