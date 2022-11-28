// TODO: Modificá las definiciones de los distintos estilos de cruza y al criadero como consideres apropiado
class EstilosDeCruza {
	
	method cumpleRequisitos(perro1, perro2)=
		perro1.compatibles(perro2)
	
	method cruzar(perro1, perro2){
		if(!self.cumpleRequisitos(perro1, perro2))
			throw new CruzaFallida(message="cruza fallida")
		
		const velocidadNueva= self.velocidadADar(perro1, perro2)
		const fuerzaNueva = self.fuerzaADar(perro1, perro2)
		return new Perro(velocidad = velocidadNueva, fuerza = fuerzaNueva)
	}
	
	method velocidadADar(perro1, perro2)
		
	method fuerzaADar(perro1, perro2)
}

object cruzaPareja inherits EstilosDeCruza {
	override method velocidadADar(perro1, perro2)=
		(perro1.velocidad() + perro2.velocidad()).div(2)
		
	override method fuerzaADar(perro1, perro2)=
		(perro1.fuerza() + perro2.fuerza()).div(2)
}

object hembraDominante inherits EstilosDeCruza {

	override method velocidadADar(perro1, perro2)=
		self.hembra(perro1,perro2).velocidad() +
		(self.macho(perro1, perro2).velocidad())*0.05
							
	override method fuerzaADar(perro1, perro2)=
		self.hembra(perro1,perro2).fuerza() +
		(self.macho(perro1, perro2).fuerza())*0.05
	
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
	
	override method cumpleRequisitos(perro1, perro2)= super(perro1, perro2) && self.hembraEsMasFuerte(perro1, perro2)
	
	method hembraEsMasFuerte(perro1, perro2) =
		self.macho(perro1,perro2).fuerza() < self.hembra(perro1,perro2).fuerza()
}

object underdog inherits EstilosDeCruza {

	override method velocidadADar(perro1, perro2)=
		(perro1.velocidad().min(perro2.velocidad()))*2
		
	override method fuerzaADar(perro1, perro2)=
		(perro1.fuerza().min(perro2.fuerza()))*2
}

//------------------------------------------------------------------------

class Criadero {
	const property perros
	method cruzar(estiloDeCruza, perroACruzar) {
		const intentos = 3
		const parejasCompatiblesOrdenadas = self.ordenarPorStatus(self.potencialesParejas(estiloDeCruza, perroACruzar)).take(intentos)
		
		return self.realizarIntentos(estiloDeCruza, parejasCompatiblesOrdenadas, perroACruzar, intentos)
	}
	
	method potencialesParejas(estiloDeCruza, perroACruzar){
		return (perros.filter({perro => perro.compatibles(perroACruzar)}))
	}
	
	method ordenarPorStatus(potencialesParejas){
		return potencialesParejas.sortedBy({x, y => x.status() > y.status()})
	}
	
	method realizarIntentos(estiloDeCruza, parejasCompatiblesOrdenadas, perroACruzar, cantIntentos){
		self.faltaronPerros(parejasCompatiblesOrdenadas, cantIntentos)
		self.seAgotaronIntentos(parejasCompatiblesOrdenadas, cantIntentos)
		try{
			return estiloDeCruza.cruzar(parejasCompatiblesOrdenadas.get(0), perroACruzar)
			}
		catch e: CruzaFallida {
			parejasCompatiblesOrdenadas.remove(parejasCompatiblesOrdenadas.get(0))
			return self.realizarIntentos(estiloDeCruza, parejasCompatiblesOrdenadas, perroACruzar, cantIntentos -1)
			}
	}
	
	
	
	method faltaronPerros(parejasCompatiblesOrdenadas, intentos){
		if(parejasCompatiblesOrdenadas.isEmpty() && intentos > 0){
			throw new NecesitaMasPerrosException(message="necesita mas perros")
		}
	}
	
	method seAgotaronIntentos(parejasCompatiblesOrdenadas, intentos){
		if(intentos == 0){
			throw new IntentosDeCruzaAgotadosException(message="se agotaron los intentos")
		}
	}
	
}

////////////////////
/// Excepciones
////////////////////

class IntentosDeCruzaAgotadosException inherits DomainException {}
class NecesitaMasPerrosException inherits DomainException {}
class CruzaFallida inherits DomainException {}

/////////////////////////////////////////////////////////////////////////////////////////

class Perro {
	const property esHembra = 0.randomUpTo(2).roundUp() > 1
	var property velocidad
	var property fuerza
	var property adulto = false

	method status() = self.fuerza() + self.velocidad()
	method tienenSexosDistintos(otroPerro) = otroPerro.esHembra() != self.esHembra()
	method compatibles(otroPerro)=
		self.tienenSexosDistintos(otroPerro) && self.adulto() && otroPerro.adulto()
}

