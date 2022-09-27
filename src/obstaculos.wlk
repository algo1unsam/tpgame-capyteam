import wollok.game.*
import carpincho.*
import juego.*
import items.*

class Obstaculo {

	const property image
	var property position = 0

	method chocar() {
		juego.terminar()
	}

	method posicionInicial() = game.at(game.width() - self.numeroRandom(), 8 + self.numeroRandom())

	method mover() {
		position = position.down(1)
		if (position.y() == -1) position = self.posicionInicial()
	}

	method iniciar() {
		position = self.posicionInicial()
		game.onTick(300, "moverObs" + self, {self.mover()})
	}

	method fin() {
		game.removeTickEvent("moverObs" + self)
	}

	method numeroRandom() {
		const nums = [ 1, 2, 3 ]
		return nums.anyOne()
	}

}

object obstaculo1 inherits Obstaculo(image = "obstaculo.png") {}

object obstaculo2 inherits Obstaculo(image= "obstaculo.png"){}
