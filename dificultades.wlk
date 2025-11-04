import naves.*
import enemigos.*
class Dificultad{

    var property activa = false
    const dificultadSuperior
    const dificultadInferior
    const tiempoDeAparicionDeEnemigos
    // chances en porcentajes enteros ej: 20 equivale a 20%
    // la chance de un enemigo dificil es la restante de definir las otras 2
    const chanceEnemigosFaciles = 0
    const chanceEnemigosMedios = 0
    //const chanceEnemigosDificiles = 100 - (chanceEnemigosFaciles + chanceEnemigosMedios)
    const puntajeParaSubirDificultad = 0

    method activar() {
        activa = true
        self.spawnearEnemigo(tiempoDeAparicionDeEnemigos)
        }

    method desactivar() {
        activa = false
        game.removeTickEvent("spawnearEnemigo")}

    method estaActiva() = activa

    method subirDificultad(){
        self.desactivar()
        dificultadSuperior.activar()
    }

    method bajarDificultad(){
        self.desactivar()
        dificultadInferior.activar()
    }

    method subirDificultadSegunPuntaje(puntaje){
        if (puntaje >= puntajeParaSubirDificultad){
            self.subirDificultad()
        }
    }
    
    method puntajeParaSubirDificultad() = puntajeParaSubirDificultad

    method dificultadSuperior() = dificultadSuperior

    method dificultadInferior() = dificultadInferior

    method spawnearEnemigo(cadaTsegundos){
        const ticks = cadaTsegundos * 1000
        game.onTick(ticks,"spawnearEnemigo",{
            const chance = 0.randomUpTo(100)
            self.spawnearSegunChance(chance)
        })
    }

    method spawnearSegunChance(chance){
        const limite = chanceEnemigosMedios + chanceEnemigosFaciles

        if ( 0 <= chance && chance <= chanceEnemigosFaciles) {
            const enemigo = new EnemigoDebil()
            game.addVisual(enemigo)
        }
        else if (chanceEnemigosFaciles < chance && chance <= limite){
                const enemigo = new EnemigoMedio()
                game.addVisual(enemigo)
        }
        else {
                const enemigo = new EnemigoFuerte()
                game.addVisual(enemigo)
        }   
    }

}

const nivel0 = new Dificultad(
    tiempoDeAparicionDeEnemigos = 10,
    chanceEnemigosFaciles = 90,
    chanceEnemigosMedios = 10,
    dificultadSuperior = nivel1,
    dificultadInferior = self,
    puntajeParaSubirDificultad = 1)

const nivel1 = new Dificultad(
    tiempoDeAparicionDeEnemigos = 5,
    chanceEnemigosFaciles = 80,
    chanceEnemigosMedios = 10,
    dificultadSuperior = nivel2,
    dificultadInferior = nivel0,
    puntajeParaSubirDificultad = 20)

const nivel2 = new Dificultad(
    tiempoDeAparicionDeEnemigos = 4,
    chanceEnemigosFaciles = 50,
    chanceEnemigosMedios = 40,
    dificultadSuperior = nivel3,
    dificultadInferior = nivel1,
    puntajeParaSubirDificultad = 30)

const nivel3 = new Dificultad(
    tiempoDeAparicionDeEnemigos = 4,
    chanceEnemigosFaciles = 30,
    chanceEnemigosMedios = 40,
    dificultadSuperior = self,
    dificultadInferior = nivel2,
    puntajeParaSubirDificultad = 40)

object controlDeDificultad{

    var puntaje = 0
    var dificultadActual = nivel0
    var contadorDeNivel = 0

    method modificarPuntaje(nuevoPuntaje) {
        puntaje=nuevoPuntaje
    }

    method initialize(){
        dificultadActual.activar()
        self.obtenerPuntaje()
        self.subirAutomaticamenteDificultad()
    }

    method definirDificultad(dificultad){
        dificultadActual = dificultad
    }

    method reiniciarContadores(){
        contadorDeNivel = 0
        puntaje = 0
    }

    method dificultadActual() = dificultadActual

    method contadorDeNivel() = contadorDeNivel

    method obtenerPuntaje(){
        game.onTick(1,"leer puntaje de la nave", {puntaje = nave.puntaje()})
    }

    method subirAutomaticamenteDificultad(){
        game.onTick(1,"subir dificultad segun puntaje",{self.subirYActualizarDificultad()})
    }

    method subirYActualizarDificultad(){
        dificultadActual.subirDificultadSegunPuntaje(puntaje)
        if(!dificultadActual.estaActiva()){
            if(dificultadActual.dificultadSuperior().estaActiva()){
                dificultadActual = dificultadActual.dificultadSuperior()
                contadorDeNivel = contadorDeNivel + 1
            }
            else{
                dificultadActual = dificultadActual.dificultadInferior()
                contadorDeNivel = contadorDeNivel - 1
            }
        }
    }

    method desactivar(){
        //Desactiva todas las dificultades
        //Dejan de spawnear enemigos
        game.removeTickEvent("subir dificultad segun puntaje")
        game.removeTickEvent("leer puntaje de la nave")
        dificultadActual.desactivar()

    }

    method activar(){
        self.definirDificultad(nivel0)
        self.reiniciarContadores()
        self.initialize()

    }

}
