import wollok.game.*
import carpincho.*
import juego.*

class Cosas {

	var property velocidad = 300
	const property image
	var property position = 0
	const property lista = [ naranja, limon, tomate, arcoiris, obstaculo1, obstaculo2, obstaculo3 ]
	var property velocidadAnterior = 300
	
	
	method chocar() {
	}

	method posicionInicial() = game.at(game.width() - self.numeroRandom(), 8 + self.numeroRandom())

	method mover() {
		position = position.down(1)
		if (position.y() == -1) {
			position = self.posicionInicial()
				if (self.velocidad() > self.velocidadAnterior()) {
					self.reiniciar()
					velocidadAnterior = velocidad}
			}
	}

	method numeroRandom() {
		const nums = [ 1, 3, 5 ]
		return nums.anyOne()
	}
	
	method subirVelocidad(){
		velocidad = velocidad*(1/2)
	}
		method iniciar() {
		position = self.posicionInicial()
		game.onTick(velocidad, "mover" + self, { self.mover()})
	}

	method fin() {
		game.removeTickEvent("mover" + self)
	}
	method reiniciar(){
		self.fin()
		self.iniciar()
	}
}

class Obstaculo inherits Cosas {
	
	method musica() = game.sound("golpe.mp3")

	override method chocar() {
		capy.pierdeUnaVida()
		position = self.posicionInicial()
		self.musica().play()
		if (capy.estaVivo() == false) juego.perder()
	}
}

object obstaculo1 inherits Obstaculo(image = "tronco2.png") {

}

object obstaculo2 inherits Obstaculo(image = "roca2.png") {

}

object obstaculo3 inherits Obstaculo(image = "barril.png") {

}

class Item inherits Cosas {

	const bonificacion

	method musica() = game.sound("puntos.mp3")


	method activarPoder() {
		puntuacion.sumarPuntos(self)
	}

	override method chocar() {
		self.activarPoder()
		position = self.posicionInicial()
	}

	method puntos() = bonificacion

}

object naranja inherits Item (image = "naranja2.png", bonificacion = 10) {

	override method activarPoder() {
		puntuacion.sumarPuntos(self)
		self.musica().play()
	}

}

object limon inherits Item (image = "limon2.png", bonificacion = 100) {

	override method activarPoder() {
		puntuacion.sumarPuntos(self)
		self.musica().play()
	}

// da 100 puntos
}

object tomate inherits Item (image = "tomate2.png", bonificacion = 0) {

	// te da una vida extra
	override method musica() = game.sound("vidaextra.mp3")

	override method activarPoder() {
		capy.aniadirVida()
		self.musica().play()
	}

	override method posicionInicial() = game.at(game.width() - self.numeroRandom(), 30 + self.numeroRandom())

}

object arcoiris inherits Item(image = "arcoiris2.png", bonificacion = 0) {

	const items = [ naranja, limon, tomate ]
	var item = items.anyOne()

	override method activarPoder() {
		puntuacion.sumarPuntos(self.elegirItemACopiar())
		item.musica().play()
	}

	method elegirItemACopiar() {
		return item
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
