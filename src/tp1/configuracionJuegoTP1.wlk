import wollok.game.*
import tp1.*

object juegoTP1 {
	method jugar() {
		self.configurarVentana()
		self.agregarObjetos()
		self.configurarTeclas()
		self.configurarColisiones()
		self.configurarEventosAutomaticos()
		game.start()
	}
	
	method configurarEventosAutomaticos() {
		// TODO Hacer que cada 5000 milisegundos crezcan malezas en el jardín
		
	}
	
	method configurarVentana() {
		game.width(8)
		game.height(8)
		game.title("TP1")
	}
	method agregarObjetos() {
		game.addVisualCharacter(personajeControlado) 
		game.addVisualIn(spa, game.at(1, 1))
		game.addVisualIn(jardin, game.at(6, 6))
		
		// Al pasar con el mouse sobre el jardín muestra
		// la cantidad actual de malezas
		game.showAttributes(jardin)
	}
	
	method configurarTeclas() {
		keyboard.space().onPressDo({ personajeControlado.cambiar() })
	}
	
	// Configura qué hacer cuando se pasa por el spa o el jardín
	method configurarColisiones() {		
		game.onCollideDo(spa, {_ => 
			spa.atender(personajeControlado.personajeActual())
		})
		
		game.onCollideDo(jardin, {_ => 
			personajeControlado.personajeActual().trabajarEnJardin(jardin)
		})
	}
	
}

// Objeto que controla si se está manejando a adriano o a olivia
object personajeControlado {
	var property position = game.center()
	var personajeActual = olivia
	var siguientePersonaje = adriano
	
	method image() = self.personajeActual().image()
	method personajeActual() = personajeActual
	
	method cambiar() {
		 const personaje = personajeActual
		 personajeActual = siguientePersonaje
		 siguientePersonaje = personaje
	}
}