import wollok.game.*
import carpincho.*
import juego.*

class Item {

	var property position = 0
	const property image
	const bonificacion 

	method activarPoder() {
		puntuacion.sumarPuntos(self)
	}

	method chocar() {
		self.activarPoder()
		position = self.posicionInicial()
	}

	method posicionInicial() = game.at(game.width() - self.numeroRandom(), 8 + self.numeroRandom())

	method mover() {
		position = position.down(1)
		if (position.y() == -1) position = self.posicionInicial()
	}

	method iniciar() {
		position = self.posicionInicial()
		game.onTick(300, "mover" + self, {self.mover()})
	}

	method fin() {
		game.removeTickEvent("mover" + self)
	}

	method puntos() = bonificacion
	
	method numeroRandom() {
		const nums = [ 1, 3, 5]
		return nums.anyOne()
	}

}

object naranja inherits Item (image = "naranja.png", bonificacion = 10) {
	override method activarPoder() {
		puntuacion.sumarPuntos(self)
	}
}

object limon inherits Item (image = "limon.png", bonificacion = 100) {
	 
	 override method activarPoder() {
		puntuacion.sumarPuntos(self)
	}
	//da 100 puntos
}

object tomate inherits Item (image = "tomate.png", bonificacion = 0) {
	// te da una vida extra
	override method activarPoder(){
		capy.aniadirVida()
	}
	override method posicionInicial() = game.at(game.width() - self.numeroRandom(), 30 + self.numeroRandom())
}

object arcoiris inherits Item(image = "arcoiris.png", bonificacion = 0){
	
	const items = [naranja, limon, tomate]

	override method activarPoder(){
		puntuacion.sumarPuntos(self.elegirItemACopiar())
	}
	method elegirItemACopiar(){
		return 	items.anyOne()
		
	}
	override method posicionInicial() = game.at(game.width() - self.numeroRandom(), 20 + self.numeroRandom())
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
