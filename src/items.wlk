import wollok.game.*
import carpincho.*

class Item {
	const property image 
	var position
	
	method activarPoder()
	
	method chocar(){
		capy.agarrarItem(self)
	}
	
	method posicionInicial() 
	
	method mover(){
		position = position.down(1)
		if (position.y() == -1)
			position = self.posicionInicial()
	}
	
	method iniciar()
	
	method fin()
	
}

/*TODO: Crear items
 * Naranja de oro = 100 puntos
 * Naranja doble = Duplica los puntos al finalizar la partida
 * Naranja revividora = Te da una vida extra
 * etc
 * 
 * 
 * 
 */