import wollok.game.*
import carpincho.*
import objectos.*

object juego {
	const items = [tomate,naranja,limon,arcoiris,obstaculo1,obstaculo2,obstaculo3]
	var property itemsProxNivel = [obstaculo4,obstaculo5]
	const obstaculos = [obstaculo1,obstaculo2,obstaculo3,obstaculo4,obstaculo5]
	const visuales = [puntuacion, vidas, record, nivel]
	const itemsAgregados = []
	var indice = -1
	
	
	method configurar() {
		game.width(5)
		game.height(8)
		game.title("Capy Game")
		game.addVisual(fondo)
		game.addVisual(capy)
		items.forEach({item => game.addVisual(item)})
		visuales.forEach({visual => game.addVisual(visual)})
		
		keyboard.space().onPressDo{ self.reiniciar()}
	    keyboard.up().onPressDo{capy.moverseArriba()}
	    keyboard.down().onPressDo{capy.moverseAbajo()}
		keyboard.left().onPressDo{ capy.moverseIzquierda()}
		keyboard.right().onPressDo{ capy.moverseDerecha()}
		
		game.onCollideDo(capy, { obstaculo => obstaculo.chocar()})
		
		items.forEach({item => game.onCollideDo(item, { objeto => item.mover()})})
	}

	method reiniciar() {
		fondo.reiniciar()
		nivel.reiniciarNivel()
		
		self.jugar()
	}

	method iniciar() {
		self.configurar()
		capy.iniciar()
		items.forEach({item => item.iniciar()})
		items.forEach({item => item.reiniciarVelocidad()})
		puntuacion.iniciar()
		fondo.musicaIniciar()
	}

	method jugar() {
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
		itemsAgregados.forEach({item => item.fin()})
		itemsAgregados.clear()
		puntuacion.fin()
		fondo.musica().stop()
		fondo.reiniciarMusica()
	}
	method subirNivel() {
		if (puntuacion.subirNivel()){
			items.forEach({visual => visual.subirVelocidad()})
			puntuacion.aumentarPuntoDeGuardado()
			nivel.subirNivel()
			self.cambiarEscenario()
			}
		
		}
	method cambiarEscenario(){
		if (nivel.subimos()){
			fondo.cambiarImagen()
			obstaculos.forEach({item => item.cambiarImagen()})
			
			if (self.sigoAgregandoObjetos()){
				var objeto = self.agregarObjetos()
				itemsAgregados.add(objeto)
				game.addVisual(objeto)
				game.onCollideDo(capy, { obstaculo => obstaculo.chocar()})
				game.onCollideDo(objeto, {item => objeto.mover()})
				}
			}
	}
	method agregarObjetos(){
		indice += 1
		if (indice == 2){
			indice = -1
		}
		itemsProxNivel.get(indice).iniciar()
	    return itemsProxNivel.get(indice)
	}
	method sigoAgregandoObjetos() = game.allVisuals().size() <  15

}

object fondo {

	var sonido = game.sound("musica4.mp3")
	
	const listaImagenes = ["rio.png", "calle.png", "campo.png"]
	var indice = 1
	var property image = listaImagenes.get(0)
	
	method reiniciar() {image = listaImagenes.get(0)
		self.reiniciarMusica()
		indice = 1
	}
	method position() = game.at(0,0)

	method cambiarImagen() {
		image = listaImagenes.get(indice)
		indice+= 1
		if (indice == 3){
			indice = 0
		}
		
	}
	method reiniciarMusica(){
		sonido = game.sound("musica4.mp3")
	}
	
	method musica() = sonido
	
	method bajarVolumen(){self.musica().volume(0.1)}
	
	method cambiarMusica(){ sonido = game.sound("musica3.mp3")}
	
	method subirNivel(){
		self.cambiarImagen()
		self.cambiarMusica()
	}
	method chocar(){}
	
	method musicaIniciar(){
		game.schedule(100, { self.musica().play()})
		self.musica().shouldLoop(true)
	}
}

object gameOver {

	method position() = game.center()

	method text() = "GAME OVER"

	method musica() = game.sound("gameover.mp3")

}

object puntuacion {

	var property puntos = 0
	var property puntoDeGuardado = 100

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
		puntoDeGuardado= 200
		game.onTick(600, "puntos", { self.sumarPuntos()})
	}

	method fin() {
		game.removeTickEvent("puntos")
		puntoDeGuardado= 200
	}

	method subirNivel() = self.puntos() > puntoDeGuardado
	
	method aumentarPuntoDeGuardado(){
		puntoDeGuardado += 200
		
	}

}

object record {
	const puntuaciones = [0]
	
	method text() = "Record: " + self.recordMaximo().toString()

	method position() = game.at(1, 0)
	
	method guardarPuntuacion(){
		puntuaciones.add(puntuacion.puntos())
	}
	method recordMaximo() = puntuaciones.max()
}


object vidas {

	method text() = "Vidas: " + (capy.vidasExtras()).toString()
	method position() = game.at(3, game.height() - 1)

}

object nivel{
	var property nivel = 1
	var property subirNiveles = [3]
	var indice = 0
	var proximoNivel = 0
	
	method text() = "Nivel:  " + nivel.toString()
	method position() = game.at(3,0)
	method subirNivel(){
		nivel +=1
	}
	method subimos(){
		if (nivel > subirNiveles.get(indice) and nivel <= subirNiveles.get(indice)+3){	
			
			var aComparar = subirNiveles.get(indice)
			proximoNivel = aComparar + 3
			subirNiveles.add(proximoNivel)
			indice += 1
		
			return  aComparar <= nivel
			
	}
	else{return false}
	}
	method reiniciarNivel(){
		nivel = 1
		indice = 0
	}
}