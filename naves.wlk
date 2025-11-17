import powerUps.*
object nave {
  var position = game.at(0,10)
  var property image = "nave.gif"
  var property vida = 1
  const vidaInicial = 1

  var puntaje = 0

  method modificarPuntaje(valorNuevo) {
    puntaje=valorNuevo
  }

  var activa = true

  var inmortalidad = false

  method puntaje()= puntaje

  method sumarVida(cant) {
    vida += cant 
  }

  method vida() = vida

  method vidaInicial() = vidaInicial 

  method vida(valor){
    vida = valor
  }

  method activar(){
    self.reiniciarPuntuacion()
    self.reiniciarVida()
    activa = true
  }

  method desactivar(){
    activa = false
  }

  method imagen(imagenNueva){
    image = imagenNueva
  }

  method activa() = activa

  var proyectilesActivos = []

  var velocidadProyectil = 250

  var contDisparos = 0

  var powerUpActivo = null
  
  var hayPowerUpActivo = false

  method proximoIdTick() { //Creo apra que cada disparo tenga su propio id en el tick y no lo compartan
    contDisparos = contDisparos + 1
    return "proy_" + contDisparos.toString()
  }

  method powerUpActivo(powerUp){
    powerUpActivo = powerUp
  }

  method remover() {}

  method powerUpActivo() = powerUpActivo

  method hayPowerUpActivo() = hayPowerUpActivo

  method hayPowerUpActivo(estado){
    hayPowerUpActivo = estado
  }

  method velocidadProyectil() = velocidadProyectil

  method proyectilesActivos() = proyectilesActivos

  method sumarPuntaje(puntos){
    puntaje= puntaje+puntos
  }

  method reiniciarPuntuacion(){
    puntaje = 0
  }
  
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
    // if (tripleActivo) self.disparoTriple()
    //else 
    self.dispararProyectil(self.position())
  } 

  method dispararProyectil(posInicial) {
    const p = new Proyectil(position = posInicial.right(1))   // nace delante de la nave
    self.dispara(p)
    proyectilesActivos.add(p)
    p.initialize()
    const id = self.proximoIdTick() //Crea los ontick en abse al nombre del proyectil
    game.onTick(velocidadProyectil, id, { p.moverALaDerecha() })
  }

  method dispara(proyectil) {
    game.addVisual(proyectil)
  }

  method choqueEnemigo(){
    if (!inmortalidad){
      self.position(game.at(0,10))
      vida = vida - 1
    }
  }

  method disparado(){}

  method initialize() {
    self.activar()
    self.reiniciarPuntuacion()
    self.reiniciarVida()
  }

  method resetPuntaje() { // lo uso en los tests
    puntaje = 0
  }

  method activarModoInmortal(){
    // la nave no puede perder vida
    inmortalidad = true
  }

  method desactivarModoInmortal(){
    inmortalidad = false
  }

  method reiniciarVida(){
    vida = vidaInicial
  }

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
    nave.proyectilesActivos().remove(self)
  }

  method remover(){
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