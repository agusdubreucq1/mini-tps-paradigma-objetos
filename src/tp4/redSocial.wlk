import tp4.usuario.*

class Publicacion {
	const property usuario
	const property fecha
	var property privacidad
	
	method esVisible(user, unaFecha)=
		privacidad.tienePermiso(user, self) && unaFecha >= fecha
	
	method cambiarPrivacidad(nuevaPrivacidad){
		privacidad = nuevaPrivacidad
	}

}

class Historia inherits Publicacion {
	const duracion = 1
	override method esVisible(user, unaFecha) =
		super(user, unaFecha) && self.dentroDeFecha(unaFecha)
	
	
	method dentroDeFecha(unaFecha)=
		unaFecha <= (fecha.plusDays(duracion))
	
}

object privada inherits Privacidad{
	override method tienePermiso(usuario, publicacion)=
		super(usuario, publicacion) ||
		publicacion.usuario().tieneContacto(usuario)
		
}

object publica{
	method tienePermiso(usuario, publicacion) = true
}

class Privacidad{
	method esCreador(unUsuario, publicacion) = 
		publicacion.usuario() == unUsuario
		
	method tienePermiso(usuario, publicacion) = 
		self.esCreador(usuario, publicacion)
}