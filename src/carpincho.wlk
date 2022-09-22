import wollok.game.*

object capy {
	var property estaVivo = true
	var property vidasExtras = 0
	var property position = game.at(2,1)
	
	
	method image() = "capy.png"
	
	method moverseIzquierda(){
		position = position.left(1)
	}
	
	method moverseDerecha(){
		position = position.right(1)
	}
	
	method morir(){
		if (vidasExtras > 0){
			vidasExtras -= 1
		}
		else {
			estaVivo = false
		}
	}
	
	method iniciar(){
		estaVivo = true
		
	}
	
}