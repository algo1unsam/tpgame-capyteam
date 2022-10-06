import wollok.game.*
import carpincho.*
import objectos.*

object juego {

	method configurar() {
		game.width(5)
		game.height(8)
		game.title("Capy Game")
		game.boardGround("rio.png")
		game.addVisual(capy)
		game.showAttributes(capy)
			// game.addVisual(capy)
		game.addVisual(obstaculo1)
		game.addVisual(tomate)
		game.addVisual(obstaculo2)
		game.addVisual(naranja)
		game.addVisual(limon)
		game.addVisual(arcoiris)
		game.addVisual(obstaculo3)
		game.addVisual(puntuacion)
		game.addVisual(vidas)
		
		keyboard.space().onPressDo{ self.reiniciar()}
	    keyboard.up().onPressDo{capy.moverseArriba()}
	    keyboard.down().onPressDo{capy.moverseAbajo()}
		keyboard.left().onPressDo{ capy.moverseIzquierda()}
		keyboard.right().onPressDo{ capy.moverseDerecha()}
		
		game.onCollideDo(capy, { obstaculo => obstaculo.chocar()})
		game.onCollideDo(naranja, { objeto => naranja.mover()})
		game.onCollideDo(tomate, { objeto => tomate.mover()})
		game.onCollideDo(limon, { objeto => limon.mover()})
		game.onCollideDo(arcoiris, { objeto => arcoiris.mover()})
		game.onCollideDo(obstaculo1, { objeto => obstaculo1.mover()})
		game.onCollideDo(obstaculo2, { objeto => obstaculo2.mover()})
		game.onCollideDo(obstaculo3, { objeto => obstaculo3.mover()})
	}

	method reiniciar() {
		fondo.resetMusica()
		self.jugar()
	}

	method iniciar() {
		self.configurar()
		capy.iniciar()
		puntuacion.iniciar()
		obstaculo1.iniciar()
		obstaculo2.iniciar()
		obstaculo3.iniciar()
		tomate.iniciar()
		naranja.iniciar()
		limon.iniciar()
		arcoiris.iniciar()
		game.schedule(100, { fondo.musica().play()})
			// fondo.musica().play().shouldLoop(true)
		fondo.musica().shouldLoop(true)
	}

	method jugar() {
		game.clear()
		self.iniciar()
	}

	method perder() {
		game.addVisual(gameOver)
		gameOver.musica().play()
		self.terminar()
	}

	method terminar() {
		obstaculo1.fin()
		puntuacion.fin()
		obstaculo2.fin()
		obstaculo3.fin()
		tomate.fin()
		naranja.fin()
		limon.fin()
		arcoiris.fin()
		fondo.musica().stop()
		fondo.resetMusica()
	}

}

object fondo {

	var sonido = game.sound("musica4.mp3")

	method image() = "rio.png"

	method resetMusica() {
		sonido = game.sound("musica4.mp3")
	}

	method musica() = sonido

}

object gameOver {

	method position() = game.center()

	method text() = "GAME OVER"

	method musica() = game.sound("gameover.mp3")

}

object puntuacion {

	var property puntos = 0
	var property guardar = 1000

	method text() = puntos.toString()

	method position() = game.at(1, game.height() - 1)

	method sumarPuntos() {
		puntos = puntos + 1
		self.subirNivel()
	}

	method sumarPuntos(item) {
		puntos = puntos + item.puntos()
	}

	method iniciar() {
		puntos = 0
		game.onTick(600, "puntos", { self.sumarPuntos()})
	}

	method fin() {
		game.removeTickEvent("puntos")
	}

	method subirNivel() {
		const visuales = game.allVisuals().copy()
		visuales.remove(capy)
		visuales.remove(self)
		visuales.remove(vidas)
		if (self.puntos() > guardar ){
			guardar = guardar + 1000
			visuales.forEach({visual => visual.subirVelocidad()})
			}
		}
	}



object vidas {

	method text() = (capy.vidasExtras()).toString()

	method position() = game.at(3, game.height() - 1)

}

