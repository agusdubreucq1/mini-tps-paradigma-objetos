// TODO: Modificá las definiciones de los distintos estilos de cruza y al criadero como consideres apropiado
object cruzaPareja inherits EstilosDeCruza {
	
	method cruzar(perro1, perro2) {
		if(!self.cumpleRequisitos(perro1, perro2))
		self.error("cruza no exitosa")
		
		const velocidadNueva= (perro1.velocidad() + perro2.velocidad()).div(2)
		const fuerzaNueva = (perro1.fuerza() + perro2.fuerza()).div(2)
		return new Perro(velocidad = velocidadNueva, fuerza = fuerzaNueva)
	}
}

object hembraDominante inherits EstilosDeCruza {
	method cruzar(perro1, perro2) {
		if(!self.cumpleRequisitos(perro1, perro2))
		self.error("cruza no exitosa")
		
		const velocidadNew = self.hembra(perro1,perro2).velocidad() +
							(self.macho(perro1, perro2).velocidad())*0.05
		const fuerzaNew = self.hembra(perro1,perro2).fuerza() +
							(self.macho(perro1, perro2).fuerza())*0.05
		
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
	
	override method cumpleRequisitos(perro1, perro2)= super(perro1, perro2) && self.hembraMasFuerte(perro1, perro2)
	
	method hembraMasFuerte(perro1, perro2) =
		self.macho(perro1,perro2).fuerza() < self.hembra(perro1,perro2).fuerza()
			
		
}

object underdog inherits EstilosDeCruza {
	method cruzar(perro1, perro2) {
		if(!self.cumpleRequisitos(perro1, perro2))
		self.error("no cumple los requisitos")
		
		const velocidadNew= (perro1.velocidad().min(perro2.velocidad()))*2
		const fuerzaNew = (perro1.fuerza().min(perro2.fuerza()))*2
		return new Perro(velocidad = velocidadNew, fuerza = fuerzaNew)
	}
}

class EstilosDeCruza {
	method compatibles(perro1, perro2)=
		perro1.tienenSexosDistintos(perro2) && perro1.adulto() && perro2.adulto()
			
	
	method cumpleRequisitos(perro1, perro2)=
		self.compatibles(perro1, perro2)
	
}

class Criadero {
	const property perros
	method cruzar(estiloDeCruza, perroACruzar) {
		try{
		const parejasCompatiblesOrdenadas = self.ordenarPorStatus(self.potencialesParejas(estiloDeCruza, perroACruzar)).take(3)
		return self.realizarIntentos(estiloDeCruza, parejasCompatiblesOrdenadas, perroACruzar)}
		catch e: MessageNotUnderstoodException {
			throw new DomainException(message="Oops!")
		}
	}
	
	method potencialesParejas(estiloDeCruza, perroACruzar){
		return (perros.filter({perro => estiloDeCruza.compatibles(perro, perroACruzar)}))
	}
	
	method ordenarPorStatus(potencialesParejas){
		return potencialesParejas.sortedBy({x, y => x.status() > y.status()})
	}
	
	method realizarIntentos(estiloDeCruza, parejasCompatiblesOrdenadas, perroACruzar){
		const parejasExitosas = parejasCompatiblesOrdenadas.filter({perro => estiloDeCruza.cumpleRequisitos(perro, perroACruzar)})
		self.faltaronPerros(parejasExitosas, parejasCompatiblesOrdenadas)
		self.seAgotaronIntentos(parejasExitosas, parejasCompatiblesOrdenadas)
		
		return estiloDeCruza.cruzar(parejasExitosas.get(0), perroACruzar)
	}
	
	
	method faltaronPerros(parejasExitosas, parejasCompatiblesOrdenadas){
		if(parejasExitosas.isEmpty() && parejasCompatiblesOrdenadas.size() < 3){
			throw new NecesitaMasPerrosException(message="necesita mas perros")
		}
	}
	
	method seAgotaronIntentos(parejasExitosas, parejasCompatiblesOrdenadas){
		if(parejasExitosas.isEmpty() && parejasCompatiblesOrdenadas.size() == 3){
			throw new IntentosDeCruzaAgotadosException(message="se agotaron los intentos")
		}
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

