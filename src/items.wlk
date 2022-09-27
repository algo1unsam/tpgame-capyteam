import wollok.game.*
import carpincho.*
import juego.*

class Item {

	var position = 0
	var image
	var bonificacion 

	method activarPoder() {
		puntuacion.sumarPuntos(bonificacion)
	}

	method chocar() {
		self.activarPoder()
		game.removeVisual(self)
	}

	method posicionInicial() = game.at(game.width() - self.numeroRandom(), 8 + self.numeroRandom())

	method mover() {
		position = position.down(1)
		if (position.y() == -1) position = self.posicionInicial()
	}

	method iniciar() {
		position = self.posicionInicial()
		game.onTick(300, "mover", {self.mover()})
	}

	method fin() {
	}

	method puntos() = bonificacion
	
	method numeroRandom() {
		const nums = [ 1, 2, 3 ]
		return nums.anyOne()
	}

}

object naranja inherits Item (image = "naranja.png", bonificacion = 10) {}

object limon inherits Item (image = "limon.png", bonificacion = 100) {
	//da 100 puntos
}

object tomate inherits Item (image = "tomate.png", bonificacion = 0) {
	// te da una vida extra
	override method activarPoder(){
		capy.aniadirVida()
	}
}

object arcoiris inherits Item(image = "arcoiris.png", bonificacion = 0){
	
	const poderesItems = [naranja, limon, tomate]

	override method activarPoder(){
		poderesItems.anyOne( {poder => poderesItems.activarPoder()} )
	}
}



/*TODO: Crear items
 * Naranja de oro (limon) = 100 puntos
 * Naranja doble (arcoiris) = Duplica los puntos 
 * Naranja revividora (tomate) = Te da una vida extra
 * Naranja random () = Te da un poder random
 *  etc
 * 
 * 
 * 
 */
