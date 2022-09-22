import wollok.game.*

object capy {
	var property estaVivo = true
	var property vidasExtras = 0
	var property position = game.at(2,1)
	const inventario = []
	
	method image() = ""
	
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
			if (inventario.size() > 0){
				inventario.forEach({item => item.activarPoder()})
			}
			self.borrarInventario()
			
		}
	}
	
	method iniciar(){
		estaVivo = true
		self.borrarInventario()
		
	}
	
	method agarrarItem(item){
		inventario.add(item)
	}
	
	method borrarInventario(){
		inventario.removeAll()
	}
}