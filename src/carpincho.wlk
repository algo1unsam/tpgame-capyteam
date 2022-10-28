import wollok.game.*
import juego.*

object capy {

	var property estaVivo = true
	var property vidasExtras = 0
	var property position = game.at(2, 1)

	method musica() = game.sound("cambiocarril.mp3")

	method image() = "capy3.png"

	method moverseIzquierda() {
		if (position.x() > 0 )
		position = position.left(2)
		self.musica().play()
		
	}

	method moverseDerecha() {
		if (position.x() < 4)
		position = position.right(2)
		self.musica().play()
	}

	method moverseArriba() {
		if (position.y() < 7)
		position = position.up(1)
		self.musica().play()
	}

	method moverseAbajo() {
		if (position.y() > 0)
		position = position.down(1)
		self.musica().play()
	}

	method morir() {
		if (vidasExtras <= 0) {
			estaVivo = false
			self.fin()
		}
	}

	method iniciar() {
		estaVivo = true
		vidasExtras = 2
		position = game.at(2,1)
	}

	method aniadirVida() {
		vidasExtras += 1
	}

	method pierdeUnaVida() {
		vidasExtras -= 1
		self.morir()
	}

	method fin() {
		game.removeVisual(self)
	
	}
	
	

}

