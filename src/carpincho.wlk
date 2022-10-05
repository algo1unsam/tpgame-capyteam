import wollok.game.*
import juego.*

object capy {
	var property estaVivo = true
	var property vidasExtras = 0
	var property position = game.at(2,1)
	
	
	method image() = "capy3.png"
	
	method moverseIzquierda(){
		position = position.left(1)
	}
	
	method moverseDerecha(){
		position = position.right(1)
	}
	
	method morir(){
		if (vidasExtras <= 0){
			estaVivo = false
		}
	}
	
	method iniciar(){
		estaVivo = true
		
		
	}
	method aniadirVida(){
		vidasExtras += 1
	}
	method pierdeUnaVida(){
		vidasExtras -= 1
		self.morir()
	}
	
}