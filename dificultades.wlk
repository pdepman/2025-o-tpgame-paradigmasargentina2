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

    method activar() {
        activa = true
        self.spawnearEnemigo(tiempoDeAparicionDeEnemigos)
        }

    method desactivar() {
        activa = false
        game.removeTickEvent("spawnearEnemigo")}

    method subirDificultad(){
        self.desactivar()
        dificultadSuperior.activar()
    }

    method bajarDificultad(){
        self.desactivar()
        dificultadInferior.activar()
    }

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

const dificultadFacil = new Dificultad(
    tiempoDeAparicionDeEnemigos = 5,
    chanceEnemigosFaciles = 80,
    chanceEnemigosMedios = 10,
    dificultadSuperior = dificultadMedia,
    dificultadInferior = self)

const dificultadMedia = new Dificultad(
    tiempoDeAparicionDeEnemigos = 4,
    chanceEnemigosFaciles = 50,
    chanceEnemigosMedios = 40,
    dificultadSuperior = dificultadDificil,
    dificultadInferior = dificultadFacil)

const dificultadDificil = new Dificultad(
    tiempoDeAparicionDeEnemigos = 4,
    chanceEnemigosFaciles = 30,
    chanceEnemigosMedios = 40,
    dificultadSuperior = self,
    dificultadInferior = dificultadMedia)
