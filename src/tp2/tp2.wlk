object carrito {
	var property productos = []

	method agregar(producto) {
		productos.add(producto)
	}

	method estaVacio() = productos.isEmpty()
	
	method cantidadDeProductos() = productos.size()
	
	
	method totalAAbonar() =
		productos.sum({producto => producto.precioAAbonar()})
	
	method productoMasCaro() {
		if(self.estaVacio()){
			self.error("no hay productos en el carrito")
		}
		return productos.max({producto => producto.precioAAbonar()})}
		
	method detalleDeCompra() {
		 const detalles = self.productos().asSet().map({producto => producto.descripcion()})
		 
		 return detalles.sortedBy({x, y => x < y})
		 }
}

class ProductoVentaUnitaria {
	
	var property nombre
	var property precio
	
	method precioAAbonar() = precio
	
	method descripcion() {
		return nombre
	}
	
}

class ProductoVentaPorPeso {
	
	var property nombre
	var property precioPorKg
	var property peso
	
	method precioAAbonar() = precioPorKg * peso
	
	method descripcion() {
		return nombre + " x " + peso.toString() + " kg"
	}
	
}


