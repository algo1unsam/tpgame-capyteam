import wollok.game.*
import carpincho.*
import juego.*

class Item {

	var position
	var image
	var bonificacion

	method activarPoder() {
	}

	method chocar() {
		self.activarPoder()
		game.removeVisual(self)
	}

	method posicionInicial()

	method mover() {
		position = position.down(1)
		if (position.y() == -1) position = self.posicionInicial()
	}

	method iniciar() {
	}

	method fin() {
	}

	method puntos() = bonificacion

}

object naranja inherits Item (image = "naranja.png", position = 0, bonificacion = 10) {

	override method posicionInicial() {
	}

	override method activarPoder() {
		puntuacion.sumarPuntos(bonificacion)
	}

}

/*TODO: Crear items
 * Naranja de oro (limon) = 100 puntos
 * Naranja doble (arcoiris) = Duplica los puntos 
 * Naranja revividora (tomate) = Te da una vida extra
 * Naranja inmunizadora () = Te hace inmune por 10 segundos
 *  etc
 * 
 * 
 * 
 */
