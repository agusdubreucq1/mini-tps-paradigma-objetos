object jardin {
	var property malezas = 30
	
	method image()
	  = if(not self.desprolijo()) "arbusto.png"
	    else "arbusto-desprolijo.png"
	
	method crecerMalezas() {
		// TODO: Completar 
	}
	
	// TODO: Completar 
	method desprolijo() = false
}

object spa {
	method image() = "spa.png"
	
	method atender(persona) {
		//TODO: Completar 
	}
}

object olivia {
	var property relax = 4
	
	method image() = "jardinera.png"
	
	method trabajarEnJardin(unJardin){
		// TODO: Completar 
	}
}

object adriano {
	var property contracturas = 0
	
	method image() = "jardinero.png"
	
	method trabajarEnJardin(unJardin){
		//TODO: Completar 
	}
}