import wollok.game.*
import carpincho.*

class Obstaculo {
	const property image 
	var position
	
	method chocar(){
		juego.terminar()
	}
	
	method posicionInicial() 
	
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
	
	method iniciar(){
		position = self.posicionInicial()
		
	}
	
	method fin()
	
	
	
}