import wollok.game.*
import carpincho.*
import juego.*

class Item {
	
	var position
	var image 
	var bonificacion
	

	method activarPoder(){}
	
	method chocar(){
		self.activarPoder()
	}
	
	method posicionInicial() 
	
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
	
	method iniciar(){}
	
	method fin(){}
	
	method puntos() = bonificacion 
	
}

object naranja inherits Item (image = "naranja.png", position = 0, bonificacion =100){
	
	override method posicionInicial(){
		
	}
	override method activarPoder(){
		puntuacion.sumarPuntos(bonificacion)
	}
	
	
	
}
 


/*TODO: Crear items
 * Naranja de oro = 100 puntos
 * Naranja doble = Duplica los puntos al finalizar la partida
 * Naranja revividora = Te da una vida extra
 * Naranja random = elige uno de los poderes random!
 * etc
 * 
 * 
 */
