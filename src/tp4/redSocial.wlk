import tp4.usuario.*

class Publicacion {
	const property usuario
	const property fecha
	var property privacidad

	
	method esVisible(user, unaFecha)=
		self.esCreador(user) || (privacidad.tienePermiso(user, self) && unaFecha >= fecha && self.condicionDeFecha(unaFecha))
	
	method cambiarPrivacidad(nuevaPrivacidad){
		privacidad = nuevaPrivacidad
	}
	
	method esCreador(unUsuario) = 
		usuario == unUsuario
		
	method condicionDeFecha(unaFecha) = true

}

class Historia inherits Publicacion {
	const duracion = 1
	
	override method condicionDeFecha(unaFecha)=
		unaFecha <= (fecha.plusDays(duracion))
	
}

object privada inherits Privacidad{
}

object publica inherits Privacidad{
	override method tienePermiso(usuario, publicacion) = true
}

object secreto inherits Privacidad{
	var property contactosRestringidos = #{}
	override method tienePermiso(usuario, publicacion) = 
		super(usuario, publicacion) &&  not contactosRestringidos.contains(usuario)
}

class Privacidad{
	method tienePermiso(usuario, publicacion)=
		publicacion.usuario().tieneContacto(usuario)
}

