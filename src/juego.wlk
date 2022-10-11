import wollok.game.*
import carpincho.*
import objectos.*

object juego {
	const items = [tomate,naranja,limon,arcoiris,obstaculo1,obstaculo2,obstaculo3]
	
	method configurar() {
		game.width(5)
		game.height(8)
		game.title("Capy Game")
		game.boardGround("rio.png")
		game.addVisual(capy)
		game.showAttributes(capy)
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
		items.forEach({item => item.iniciar()})
		puntuacion.iniciar()
		game.schedule(100, { fondo.musica().play()})
		fondo.musica().shouldLoop(true)
		fondo.bajarVolumen()
	}

	method jugar() {
		//items.forEach({item => game.removeVisual(item)})
		record.guardarPuntuacion()
		game.clear()
		self.iniciar()
	}

	method perder() {
		game.addVisual(gameOver)
		gameOver.musica().play()
		self.terminar()
	}

	method terminar() {
		items.forEach({item => item.fin()})
		fondo.musica().stop()
		fondo.resetMusica()
	}
	method subirNivel() {
		if (puntuacion.subirNivel()){
			items.forEach({visual => visual.subirVelocidad()})
			puntuacion.aumentarPuntoDeGuardado()
			}
		}
}

object fondo {

	var sonido = game.sound("musica4.mp3")

	method image() = "rio.png"

	method resetMusica() {
		sonido = game.sound("musica4.mp3")
	}

	method musica() = sonido
	
	method bajarVolumen(){self.musica().volume(0.1)}
}

object gameOver {

	method position() = game.center()

	method text() = "GAME OVER"

	method musica() = game.sound("gameover.mp3")

}

object puntuacion {

	var property puntos = 0
	var property puntoDeGuardado = 1000

	method text() = "Puntos: " + puntos.toString()

	method position() = game.at(1, game.height() - 1)

	method sumarPuntos() {
		puntos = puntos + 1
		juego.subirNivel()
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

	method subirNivel() = self.puntos() > puntoDeGuardado
	
	method aumentarPuntoDeGuardado(){
		puntoDeGuardado = puntoDeGuardado + 1000
	}

}

object record {
	const record = []
	
	method text() = "Record: " + self.recordMaximo().toString()

	method position() = game.at(1, game.height() - 2)
	
	method guardarPuntuacion(){
		record.add(puntuacion.puntos())
	}
	method recordMaximo() = record.max()
}


object vidas {

	method text() = "Vidas: " + (capy.vidasExtras()).toString()

	method position() = game.at(3, game.height() - 1)

}

