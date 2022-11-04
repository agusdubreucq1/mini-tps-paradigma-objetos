import tp4.usuario.*
import tp4.redSocial.*

// Para facilitar la creación de objetos de prueba
object fabrica {
	const property creador = new Usuario(nombre = "Tito")
	
	method fechaPublicacion() = new Date()
	
	/*
	 * TODO crear y retornar el contenido correspondiente
	 * usando self.creador() como usuario creador del contenido y 
	 * self.fechaPublicacion() como fecha de publicación del mismo
	 */ 
	method crearPublicacionPublica() {
		const publicacionPublica = 
			new Publicacion(usuario=creador, fecha=self.fechaPublicacion(), privacidad=publica)
		return publicacionPublica
	}
	method crearPublicacionPrivada() {
		const publicacionPrivada = 
			new Publicacion(usuario=creador, fecha=self.fechaPublicacion(), privacidad=privada)
		return publicacionPrivada
	}
	method crearHistoriaPublica() {
		const historiaPublica = 
			new Historia(usuario=creador, fecha=self.fechaPublicacion(), privacidad=publica)
		return historiaPublica
	}
	method crearHistoriaPrivada() {
		const historiaPrivada = 
			new Historia(usuario=creador, fecha=self.fechaPublicacion(), privacidad=privada)
		return historiaPrivada
	}
	method crearPublicacionSecreta(usuariosRestringidos) {
		self.error("Falta implementar")
		return "cambiame por el objeto que corresponda"
	}
	method crearHistoriaSecreta(usuariosRestringidos) {
		self.error("Falta implementar")
		return "cambiame por el objeto que corresponda"
	}
	
	// Otros métodos convenientes que se usan desde las pruebas
	// No se espera que los cambies
	
	method fechaLejanaAPublicacion() = self.fechaPublicacion().plusDays(10)
	method diaSiguienteAPublicacion() = self.fechaPublicacion().plusDays(1)
	
	method configurarContactos(){
		creador.agregarContacto(new Usuario(nombre = "Ana"))
		creador.agregarContacto(new Usuario(nombre = "Fito"))
	}
	
	method desconocido() = new Usuario(nombre = "Anónimo")
	method contactoDelCreador() = self.creador().contactos().anyOne()
	
	method usuariosDePrueba() 
		= #{creador, self.desconocido()} + creador.contactos()
}