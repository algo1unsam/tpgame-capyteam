import wollok.game.*
import carpincho.*
import juego.*
import items.*

class Obstaculo {

	const property image
	var property position = 0
	
    method musica() = game.sound("golpe.mp3")

	method chocar() {
		capy.pierdeUnaVida()
		position = self.posicionInicial()
		self.musica().play()
		if (capy.estaVivo() == false)
			juego.terminar()
			
			
	}

	method posicionInicial() = game.at(game.width() - self.numeroRandom(), 8 + self.numeroRandom())

	method comprobarPosicion() {
		if(self.posicionInicial() == naranja.posicionInicial())
		{  
			return game.at(game.width() - self.numeroRandom(), 7 + self.numeroRandom())
			
		}
		if(self.posicionInicial() == limon.posicionInicial())
		{
			return game.at(game.width() - self.numeroRandom(), 7 + self.numeroRandom())
		}
		if(self.posicionInicial() == tomate.posicionInicial())
		{
			return game.at(game.width() - self.numeroRandom(), 7 + self.numeroRandom())
		}
	
		if(self.posicionInicial() == arcoiris.posicionInicial())
		{
			return game.at(game.width() - self.numeroRandom(), 7 + self.numeroRandom())
		}
		if(self.posicionInicial() == obstaculo1.posicionInicial())
		{
			return game.at(game.width() - self.numeroRandom(), 7 + self.numeroRandom())
		}
		if(self.posicionInicial() == obstaculo2.posicionInicial())
		{
			return game.at(game.width() - self.numeroRandom(), 7 + self.numeroRandom())
		}
		if(self.posicionInicial() == obstaculo3.posicionInicial())
		{
			return game.at(game.width() - self.numeroRandom(), 7 + self.numeroRandom())
		}
		else(return self.posicionInicial())
	}
		 
	
	method mover() {
	
		position = position.down(1)
		if (position.y() == -1) position = self.comprobarPosicion()
	}

	method iniciar() {
		position = self.posicionInicial()
		game.onTick(300, "moverObs" + self, {self.mover()})
	}

	method fin() {
		game.removeTickEvent("moverObs" + self)
	}

	method numeroRandom() {
		const nums = [ 1, 3, 5]
		return nums.anyOne()
	}

}

object obstaculo1 inherits Obstaculo(image = "tronco2.png") {}

object obstaculo2 inherits Obstaculo(image= "roca2.png"){}

object obstaculo3 inherits Obstaculo(image= "barril.png"){}
