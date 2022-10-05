import wollok.game.*
import carpincho.*
import objectos.*

object juego{
	


	method configurar(){
		game.width(5)
		game.height(8)
		game.title("Capy Game")
		game.boardGround("rio.png")
		game.addVisualCharacter(capy)
		game.addVisual(obstaculo1)
		game.addVisual(tomate)
		game.addVisual(obstaculo2)
		game.addVisual(naranja)
		game.addVisual(limon)
		game.addVisual(arcoiris)
		game.addVisual(obstaculo3)
		game.addVisual(puntuacion)
		game.addVisual(vidas)
		
		
		
		keyboard.left().onPressDo{capy.moverseIzquierda()}
		keyboard.right().onPressDo{capy.moverseDerecha()}
		game.onCollideDo(capy,{ obstaculo => obstaculo.chocar()})
		keyboard.space().onPressDo{self.jugar()}
	} 
	
	method iniciar(){
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
		
		
		}
	
	method jugar(){
		game.clear()
		
		self.iniciar()
		
	}
	
	method terminar(){	
		game.addVisual(gameOver)
		obstaculo1.fin()
		puntuacion.fin()
		obstaculo2.fin()
		obstaculo3.fin()
		tomate.fin()
		naranja.fin()
		limon.fin()
		arcoiris.fin()
		capy.morir()
		gameOver.musica().play()
		
		
	}
	
}

object fondo {
	
	method image() = "rio.png"
	method musica() = game.sound("musica4.mp3")
	
}

object gameOver {
	method position() = game.center()
	method text() = "GAME OVER"
	method musica() = game.sound("gameover.mp3")

}


object puntuacion {
	
	var puntos = 0
	
	method text() = puntos.toString()
	method position() = game.at(1, game.height()-1)
	
	
	method sumarPuntos() {
		puntos = puntos +1
		
	}
	method sumarPuntos(item) {
		puntos = puntos + item.puntos()
		
	}
	method iniciar(){
		puntos = 0
		game.onTick(600,"puntos",{self.sumarPuntos()})
		
	}
	method fin(){
		game.removeTickEvent("puntos")
	}
}
object vidas {
	
	method text() = (capy.vidasExtras()).toString()
	method position() = game.at(3, game.height()-1)
	
	
	
}
