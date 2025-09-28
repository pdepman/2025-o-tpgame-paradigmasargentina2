import naves.*
class Enemigo{
    var property image = "imagenEjemplo.png"
    var property position = game.center()
    var property vida = 1
    var property valor = 2
    method disparado(){
        vida= vida-1
        nave.sumarPuntaje(valor)
        if (vida<1){
            self.destruir()
        }
    }
    method destruir(){
        nave.sumarPuntaje(valor*2)
        game.removeVisual(self)
    }

    method initialize(){
        game.whenCollideDo(self, {proyectil=> 
        proyectil.destruir()})
    }
}