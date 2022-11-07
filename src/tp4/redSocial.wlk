import tp4.usuario.*

class Publicacion {
	const property usuario
	const property fecha
	var property privacidad
	var property contactosRestringidos = #{}
	
	method esVisible(user, unaFecha)=
		self.esCreador(user) || (privacidad.tienePermiso(user, self) && unaFecha >= fecha)
	
	method cambiarPrivacidad(nuevaPrivacidad){
		privacidad = nuevaPrivacidad
	}
	
	method esCreador(unUsuario) = 
		usuario == unUsuario

}

class Historia inherits Publicacion {
	const duracion = 1
	override method esVisible(user, unaFecha) =
		self.esCreador(user) || (super(user, unaFecha) && self.dentroDeFecha(unaFecha))
		//repito un poco la logica
	
	
	method dentroDeFecha(unaFecha)=
		unaFecha <= (fecha.plusDays(duracion))
	
}

object privada{
	method tienePermiso(usuario, publicacion)=
		publicacion.usuario().tieneContacto(usuario)
		
}

object publica{
	method tienePermiso(usuario, publicacion) = true
}

object secreto{
	method tienePermiso(usuario, publicacion) = 
		publicacion.usuario().tieneContacto(usuario) &&  not publicacion.contactosRestringidos().contains(usuario)
}

