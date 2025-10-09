import naves.*               
import enemigos.*            

object powerUpGenerador {
    var property maxSimultaneos = 3
    var property activos = 0
    method posicionRandom() = game.at(
    0.randomUpTo(30),        
    0.randomUpTo(20)        
    )

    method crearAleatorio() { //Crea un p, de alguna de las clases power up, y suma uno activo
    const pos = 0.randomUpTo(2).truncate(0) //Elige una posicion en base al random, siendo el 
    const p = //Los crea en base al tipo
        if (pos==0) new PowerUpDisparoTriple()
        else if (pos==1) new PowerUpVida()
        else new PowerUpInmortal() 
    game.addVisual(p)
    p.initialize()
    activos=activos+1
    }

    method puedeCrear() = activos < maxSimultaneos

    method crearCuandoSeNecesite() {
        if (self.puedeCrear()) {self.crearAleatorio()}
    }

    method informeRecogido() {
        activos = activos - 1
    }
}

class PowerUp {
    var property position = powerUpGenerador.posicionRandom()
    var recogido = false

    method initialize() {
    game.whenCollideDo(self, { otro =>            
      if (!recogido && (otro == nave)) {          // solo la nave lo recoge
        recogido = true
        self.recogidoPor(nave)
        }
    })
    }

    method recogidoPor(nave){ //Lo creo para que peuda psar parámetro nave y poder usarlo en aplciarEfecto, que lo hacen todos los powerups
        self.aplicarEfecto(nave)
        powerUpGenerador.informeRecogido()
        game.removeVisual(self)
    }

    // elimina el error cuando un proyectil lo colisiona
    method disparado(){}

    // elimina el error cuando un enemigo lo colisiona
    method choqueEnemigo(){}

    method aplicarEfecto(nave) {}
}

class PowerUpVida inherits PowerUp {
    method image() = "imagenEjemplo2.png"

    override method aplicarEfecto(nave) { //Reescribe los metodos de aplicar efecto y hjace loq ue deba en cada uno
        nave.sumarVida(1)
    }
}

class PowerUpDisparoTriple inherits PowerUp {
    method image() = "imagenEjemplo2.png"

    override method aplicarEfecto(nave) {
        nave.activarPowerUp("triple",5000)
    }
}

class PowerUpInmortal inherits PowerUp {
    method image() = "imagenEjemplo2.png"

    override method aplicarEfecto(nave) {
        nave.activarPowerUp("inmortal",5000)
    }
}
