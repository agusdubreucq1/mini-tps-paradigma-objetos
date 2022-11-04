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
	
	method esCreador(unUsuario) = 
		usuario == unUsuario

}

class Historia inherits Publicacion {
	const duracion = 1
	override method esVisible(user, unaFecha) =
		super(user, unaFecha) && self.dentroDeFecha(unaFecha)
		//problema cuando es el creador, no hace falta q es dentroDeFecha
	
	
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

