// TODO: Modificá las definiciones de los distintos estilos de cruza y al criadero como consideres apropiado
object cruzaPareja inherits estilosDeCruza{
	method cruzar(perro1, perro2) {
		const velocidadNueva= (perro1.velocidad() + perro2.velocidad()).div(2)
		const fuerzaNueva = (perro1.fuerza() + perro2.fuerza()).div(2)
		return new Perro(velocidad = velocidadNueva, fuerza = fuerzaNueva)
	}
}

object hembraDominante inherits estilosDeCruza {
	method cruzar(perro1, perro2) {
		const velocidadNew = hembra(perro1,perro2).velocidad() +
							macho(perro1, perro2).velocidad()
		const fuerzaNew = hembra(perro1,perro2).fuerza() +
							macho(perro1, perro2).fuerza()
		
		return new Perro(velocidad = velocidadNew, fuerza = fuerzaNew)
	}
	
	method hembra(perro1, perro2){
		if(perro1.esHembra()){
			return perro1
		}else return perro2
	}
	
	method macho(perro1,perro2){
		if(perro1.esHembra()){
			return perro2
		}else return perro1
	}
	
	override method compatibles(perro1, perro2){
		return super(perro1,perro2) &&
		macho(perro1,perro2).fuerza() < hembra(perro1,perro2).fuerza()
	}
}

object underdog inherits estilosDeCruza {
	method cruzar(perro1, perro2) {
		const velocidadNew= (perro1.velocidad().min(perro2.velocidad()))*2
		const fuerzaNew = (perro1.velocidad().min(perro2.velocidad()))*2
		return new Perro(velocidad = velocidadNew, fuerza = fuerzaNew)
	}
}

class estilosDeCruza {
	method compatibles(perro1, perro2){
		return perro1.esHembra() != perro2.esHembra()
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

