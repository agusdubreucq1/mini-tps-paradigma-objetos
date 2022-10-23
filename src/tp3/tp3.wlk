// TODO: Modificá las definiciones de los distintos estilos de cruza y al criadero como consideres apropiado
object cruzaPareja {
	method cruzar(perro1, perro2) {
		// TODO FALTA IMPLEMENTAR
		return new Perro(velocidad = 0, fuerza = 0)
	}
}

object hembraDominante {
	method cruzar(perro1, perro2) {
		// TODO FALTA IMPLEMENTAR
		return new Perro(velocidad = 0, fuerza = 0)
	}
}

object underdog {
	method cruzar(perro1, perro2) {
		// TODO FALTA IMPLEMENTAR
		return new Perro(velocidad = 0, fuerza = 0)
	}
}

class Criadero {
	const property perros
	method cruzar(estiloDeCruza, perroACruzar) {
		// TODO FALTA IMPLEMENTAR
		return new Perro(velocidad = 0, fuerza = 0)
	}
}

////////////////////
/// Excepciones
////////////////////

class IntentosDeCruzaAgotadosException inherits DomainException {}
class NecesitaMasPerrosException inherits DomainException {}

/////////////////////////////////////////////////////////////////////////////////////////

class Perro {
	const property esHembra = 0.randomUpTo(2).roundUp() > 1
	var property velocidad
	var property fuerza
	var property adulto = false

	method status() = self.fuerza() + self.velocidad()
	method tienenSexosDistintos(otroPerro) = otroPerro.esHembra() != self.esHembra()
}

