import interfaz.*
import naves.*               
import enemigos.*            

object powerUpGenerador {
    var property maxSimultaneos = 3
    var property activos = 0
    method posicionRandom() = game.at(
    0.randomUpTo(5),    //30   test 
    0.randomUpTo(20)        //20
    )

    const chanceDeAparicion = 100 // de 0% a 100%
    const segundosDeAparicion = 3
    // cada cuantos segundos puede aparecer un powerUp

    method crearAleatorio(){
        // Principal controlador de generacion de powerUps
        // Cada cuantos segundos podria aparecer un powerUp
        const segundos = segundosDeAparicion * 1000
        game.onTick(segundos,"generar powerUp aleatoriamente",{
            self.generacionMomentoAleatorio()
        })
    }

    method generacionMomentoAleatorio(){
        // Controlador de la chance de generacion
        const chance = 0.randomUpTo(100)
        if (chance >= 0 && chance <= chanceDeAparicion && self.puedeCrear()){
            self.elegirPowerUp()
            activos = activos + 1
        } 
    }

    method elegirPowerUp(){
        // Elige un powerUp aleatorio y lo crea entre los disponibles
        // En la listaGeneradora se encuentra cada generador
        const listaGeneradora = [
            {self.crearVida()},
            {self.crearDisparoTripleUnico()},
            {self.crearInmortal()}
    ]
        const cantidad = listaGeneradora.size()
        const random = 0.randomUpTo(cantidad - 1)
        listaGeneradora.get(random).apply()
    }

    // Generadores de powerUps
    method crearVida(){
        // Crea un powerUp de vida
        const powerUp = new PowerUpVida()
        self.inicializarPowerUp(powerUp)
    }

    method crearDisparoTripleUnico(){
        const powerUp = new PowerUpDisparoTripleUnico()
        self.inicializarPowerUp(powerUp)
    }

    method crearInmortal(){
        const powerUp = new PowerUpInmortal()
        self.inicializarPowerUp(powerUp)

    }

    method inicializarPowerUp(powerUp){
        game.addVisual(powerUp)
        powerUp.initialize()

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
    const nombre
    const tiempoSDeActividad = 0 // Duracion en segundos del powerUp
    const identificadorUnico = 0.randomUpTo(100)

    method tiempoSDeActividad() = tiempoSDeActividad * 1000
    // tiempo en segundos

    method initialize() {
    game.whenCollideDo(self, { otro =>            
      if (!recogido && (otro == nave)) {          // solo la nave lo recoge
        recogido = true
        self.recogidoPor(nave)
        }
    })
    }

    method recogidoPor(nave){ //Lo creo para que peuda psar parámetro nave y poder usarlo en aplciarEfecto, que lo hacen todos los powerups
        self.chequearPowerUpsNave(nave)
        powerUpGenerador.informeRecogido()
        self.activar()
        position = game.at(-2,-7)
        game.removeVisual(self)
    }

    // elimina el error cuando un proyectil lo colisiona
    method disparado(){}

    // elimina el error cuando un enemigo lo colisiona
    method choqueEnemigo(){}

    method efectoUnico(nave){}
    // este metodo define la funcion de cada powerUp
    // el powerUp se desactivara despues del tiempo indicado

    method aplicarEfectoUnico(nave){
        self.efectoUnico(nave)
        self.actualizarEstadoNaveDesactivado(nave)
    }

    method estadoDeDesactivacion(){}
    //alguna condicion extra que se deba cumplir
    //para desactivar un powerUp

    method identificadorUnico() = identificadorUnico

    method actualizarEstadoNaveDesactivado(nave){
        // Actualiza el estado de la nave
        // luego de que se termina el tiempo de actividad del powerUp
        game.schedule(self.tiempoSDeActividad(),{
            self.estadoDeDesactivacion()
            nave.hayPowerUpActivo(false)
        })

    }

    method chequearPowerUpsNave(nave){
        //Revisa y actualiza el estado de powerups de la nave
        //si ya tiene un powerUp activo lo reemplaza
        if(nave.hayPowerUpActivo()){
            nave.powerUpActivo(nombre)
        }
        else if(!nave.hayPowerUpActivo()){
            nave.powerUpActivo(nombre)
            nave.hayPowerUpActivo(true)
        }
    }

    method activar(){
        // self.aplicarEfectoConstante(nave)
        self.aplicarEfectoUnico(nave)
    }

    method deberiaActivarse(nave){
        return (nave.powerUpActivo() == nombre &&
            nave.hayPowerUpActivo())
    }

    method remover(){
        game.removeVisual(self)
    }


}

class PowerUpVida inherits PowerUp(
    nombre = "vida")
{
    method image() = "vida_p.png"

    override method efectoUnico(nave) { //Reescribe los metodos de aplicar efecto y hjace loq ue deba en cada uno
        nave.sumarVida(1)
    }
}

// class PowerUpDisparoTriple inherits PowerUp(
//     nombre = "disparo triple",
//     tiempoSDeActividad = 5
// ) {
//     method image() = "triple_p.png"
//     // powerUp configurado con el controladorDePowerUps
// }

class PowerUpInmortal inherits PowerUp(
    nombre = "inmortal",
    tiempoSDeActividad = 5
) {
    method image() = "inmortal_p.png"

    override method efectoUnico(nave) {
        nave.activarModoInmortal()
        nave.imagen("naveInmortal.gif")
    }

    override method estadoDeDesactivacion(){
        nave.desactivarModoInmortal()
        nave.imagen("nave.gif")
    }
}

class PowerUpDisparoTripleUnico inherits PowerUp(
    // se laguea menos que disparo triple
    nombre = "disparo triple unico"){
    method image() = "triple_p.png"

    method dispararTriple(nave){
        const base = nave.position()
        nave.dispararProyectil(base.up(1))
        nave.dispararProyectil(base.down(1))
        nave.dispararProyectil(base)  
        }

    override method efectoUnico(nave){
        self.dispararTriple(nave)
    }

}


