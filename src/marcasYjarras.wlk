import carpas.*

class Cerveza {
	const property lupulo
	const property origen
	const property precioPorLitro
	
	method graduacion()
}

class Rubia inherits Cerveza {
	var property graduacion
}

class Negra inherits Cerveza {
	override method graduacion() = graduacionReglamentaria.graduacion().min(lupulo * 2)
}

class Roja inherits Negra {
	override method graduacion() = super() * 1.25
}

class Jarra {
	const property capacidadJarra
	const property marca
	var property carpa
	
	method contenidoAlcohol() = capacidadJarra * marca.graduacion()
	
	method precioDeLaVenta() = capacidadJarra * marca.precioPorLitro() * carpa.recargo().recargo(carpa)
}

object graduacionReglamentaria {
	var property graduacion = 0.04
}
