object jardin {
	var property malezas = 30
	
	method malezas(){
		return malezas
	}
	
	method image()
	  = if(not self.desprolijo()) "arbusto.png"
	    else "arbusto-desprolijo.png"
	
	method crecerMalezas() {
		malezas = malezas +5
	}
	
	method desprolijo() {
		return malezas > 20
	}
	
	method emprolijar(nivel){
		if(nivel>=10){
			malezas=0
		}else if(nivel >3 && nivel <9){
			malezas=malezas/2
		}
	}
}

object spa {
	method image() = "spa.png"
	
	method atender(persona) {
		persona.recibirBanio(5)
		persona.recibirMasajes()
		persona.recibirBanio(15)
	}
}

object olivia {
	var property relax = 4
	
	method relax(){
		return relax
	}
	
	method image() = "jardinera.png"
	
	method trabajarEnJardin(unJardin){
		if(unJardin.desprolijo()) {
			self.estresarse(2)}
			unJardin.emprolijar(relax*2)
			self.estresarse(1)
		
	}
	
	method estresarse(nivel){
		relax= 1.max(relax-nivel)
	}
	
	method recibirMasajes(){
		relax=relax+3
	}
	
	method recibirBanio(minutos){
		relax = relax + minutos/5
	}
}

object adriano {
	var property contracturas = 0
	
	method contracturas(){
		return contracturas
	}
	
	method image() = "jardinero.png"
	
	method trabajarEnJardin(unJardin){
		contracturas = (contracturas+7).min(contracturas + unJardin.malezas())
		if(self.lastimado()){
			unJardin.emprolijar(1)
		}else {
			unJardin.emprolijar(5)
		}
		
	}
	
	method lastimado(){
		return contracturas>10
	}
	
	method recibirMasajes(){
		contracturas = 0.max(contracturas - 5)
	}
	
	method recibirBanio(minutos){
		if(self.lastimado()){
			contracturas = 0.max(contracturas -2)
		}
	}
}