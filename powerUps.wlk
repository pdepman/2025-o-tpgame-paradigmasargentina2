import naves.*               
import enemigos.*            

object powerUpGenerador {
    var property maxSimultaneos = 3
    var property activos = 0
    method posicionRandom() = game.at(
    0.randomUpTo(30),        
    0.randomUpTo(20)        
    )

    method crear() { //Crea un p, de la clase power up, y suma uno activo
    const p = new PowerUp()
    game.addVisual(p)
    p.initialize()
    activos=activos+1
    }

    method puedeCrear() = activos < maxSimultaneos

    method crearCuandoSeNecesite() {
        if (self.puedeCrear()) {self.crear()}
    }

    method informeRecogido() {
        activos = activos - 1
    }
}

class PowerUp {
    var property position = powerUpGenerador.posicionRandom()
    var recogido = false
    method image() = "imagenEjemplo3.png"

    method initialize() {
    game.whenCollideDo(self, { otro =>            
      if (!recogido && (otro == nave)) {          // solo la nave lo recoge
        recogido = true
        powerUpGenerador.informeRecogido()
        game.removeVisual(self)                   // desaparecer simple
        }
    })
    }
}