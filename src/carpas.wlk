import marcasYjarras.*
import personas.*

class Carpa  {
    var property capacidadDeCarpa
    var property tieneBanda
    var property personasDentro = []
    var property recargo
    
    const property marcaCerveza

    method limiteMaxDeCarpa() {
        return capacidadDeCarpa == 40
    }
    
    method ingresar(persona) {
    	personasDentro.add(persona)
    }
    
    method carpaEsPar() {
    	return personasDentro.size().even()
    }
    
    method dejaIngresar(persona) {
    	return capacidadDeCarpa > personasDentro.size() and not persona.estaEbria()
    }
    
    method servirCerveza(persona, litros) {
    	if (personasDentro.contains(persona)) {
    		persona.comprarCerveza(new Jarra(capacidadJarra = litros, marca = marcaCerveza, carpa = self))
    	} else {
    		self.error("La persona no está en la carpa")
    	}
    }
    
    method ebriosEmpedernidos() {
    	return personasDentro.count({
    		p => p.estaEbria() and p.jarrasConMasDe1Litro()
    	})
    }
    
    method esHomogenea() {
    	return personasDentro.map({
    		p => p.nacionalidad()
    	}).asSet().size() == 1
    }
    
    method clientesSinServir() {
    	return personasDentro.filter({
    		p => not p.carpasDondeSeTomo().contains(self)
    	})
    }  
}

object recargoFijo {
	
   	method recargo(carpa) = 1.30
}

object recargoPorCantidad {
	
	method recargo(carpa) {
		if(carpa.capacidadDeCarpa() == 0 or carpa.personasDentro().size() == 0) {
			return 1
		} else if (carpa.capacidadDeCarpa() / carpa.personasDentro().size() <= 2) {
			return 1.40
		} else {
			return 1.25
		}
	}
} 

object recargoPorEbriedad {
	
	method recargo(carpa) {
		const personasEbrias = carpa.personasDentro().count({p => p.estaEbria()})
		
		if (personasEbrias == 0 or carpa.personasDentro().size() == 0) {
			return 1
		} else if (personasEbrias >= carpa.personasDentro().size() * 0.75) {
			return 1.50
		} else {
			return 1.20
		}
	}
} 
