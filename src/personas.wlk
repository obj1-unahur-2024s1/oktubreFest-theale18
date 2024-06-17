import marcasYjarras.*
import carpas.*

class Persona {
	var property jarrasCompradas = []
	var property peso
	var property musicaTradicional
	var property aguante
	
	const property nacionalidad
	
	method comprarCerveza(cerveza) = jarrasCompradas.add(cerveza)
	
	method totalAlcohol() {
		return jarrasCompradas.sum({
			c => c.contenidoAlcohol()
		})
	}
	
	method estaEbria() = self.totalAlcohol() * peso > aguante
	
	method leGusta(cerveza)
	
	method quiereEntrar(carpa) {
		return self.leGusta(carpa.marcaCerveza()) and self.musicaTradicional() == carpa.tieneBanda()
	}
	
	method ingresar(carpa) {
		if (self.puedeEntrar(carpa)) {
			carpa.ingresar(self)
		} else {
			self.error("La persona no puede entrar en la carpa")
		}
	}
	
	method puedeEntrar(carpa) {
		return self.quiereEntrar(carpa) and carpa.dejaIngresar(self) 
	}
	
	 method jarrasConMasDe1Litro() {
    	return jarrasCompradas.all({
    		c => c.capacidadJarra() >= 1
    	})
    }
    
    method esPatriota() {
    	return jarrasCompradas.all({
    		c => c.marca().origen() == nacionalidad
    	})
    }
    
    method marcaDeJarrasCompradas() {
    	return jarrasCompradas.map({
    		c => c.marca()
    	}).asSet()
    }
    
    method esCompatibleCon(persona) {
    	if (self.lasJarrasDeUno(persona) == 0 or self.lasJarrasDeOtro(persona) == 0) {
    		return false
    	} else {
    		return (self.lasJarrasDeUno(persona) / self.lasJarrasDeOtro(persona)) <= 2
    	}
  	}
    
    method lasJarrasDeUno(persona) {
    	return self.marcaDeJarrasCompradas().size()
    }
    
    method lasJarrasDeOtro(persona) {
    	return self.marcaDeJarrasCompradas().intersection(persona.marcaDeJarrasCompradas()).size()
    }
    
    method carpasDondeSeTomo() {
    	return jarrasCompradas.map({
    		c => c.carpa()
    	}).asSet()
    }
    
    method listaDelitrosTomados() {
    	return jarrasCompradas.map({c => c.capacidadJarra()})
    } 
    
    method estaEnVicio() {
		if (self.listaDelitrosTomados().size() == 0 or self.listaDelitrosTomados().size() == 1) {
			return false
		} else {
			return self.listaDelitrosTomados().get(self.listaDelitrosTomados().size() - 2) <= self.listaDelitrosTomados().last() 
		}
	}
	
	method gastoTotalCerveza() {
		return jarrasCompradas.sum({
			c => c.precioDeLaVenta()
		})
	}
	
	method jarraMasCara() {
		return jarrasCompradas.max({
			c => c.precioDeLaVenta()
		})
	}
}

class Belga inherits Persona {
	override method leGusta(cerveza) = cerveza.lupulo() > 0.04
}

class Checo inherits Persona {
	override method leGusta(cerveza) = cerveza.graduacion() > 0.08
}

class Aleman inherits Persona {
	override method leGusta(cerveza) = true
}
