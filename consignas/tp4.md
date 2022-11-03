# Consigna TP4: Herencia vs. Composición

## Objetivos

- Elegir las herramientas de modelado más adecuadas para cumplir con la funcionalidad sin repetir lógica.
- Usar tests automáticos para validar la lógica pedida.

## Tareas

- :dna: Resolver la lógica pedida en el archivo `tp4/redSocial.wlk`.
- :hammer_and_pick: Completar los métodos para construir objetos de prueba en el archivo `tp4/fabricaDeObjetosDePrueba.wlk` en base a tu solución. Estos métodos se usarán desde los distintos archivos de prueba, para simplificar el armado de escenarios a testear.
- :test_tube: Completar los **TODO**s en el archivo `tp4/cambiosEnConfiguracionDeContenido.wtest` en base a tu solución.

> :bulb: Recordá que podés ayudarte con la [guía de lenguajes](https://docs.google.com/document/d/e/2PACX-1vTlLkakSbp6ubcIq00PU4-Z96tg8CUSc8bO793_uftmiGjfkSn7Ug-F_y0-ieIWG6aWfuoHLJrRL8Fd/pub) y la [documentación oficial de Wollok](https://www.wollok.org/documentacion/wollokdoc/).

# Red Social :busts_in_silhouette:

Queremos hacer nuestra propia red social en la cual el contenido publicado por los usuarios pueda ser visible por otros usuarios de la red, dependiendo de cómo se haya configurado dicho contenido.

Nos interesará representar distintos tipos de contenidos con diferentes tipos de visibilidad de forma tal que sea posible determinar si un usuario puede ver el contenido en cuestión ante diferentes situaciones.

## Parte 1: Contenido público y privado :unlock: :lock:

Cuando se crea una **publicación** se registra el **usuario** que creó la publicación y la **fecha de publicación**. La misma puede ser **pública** (puede verla cualquier usuario de la red) o **privada**, haciendo que sea visible sólo por los contactos de quien hizo la publicación.

> :bulb: Ya contamos con la definición de una clase Usuario en el archivo `tp4/usuario.wlk` (el cual **no se espera que modifiques**), en la que se define un método `tieneContacto(unUsuario)` que puede usarse para saber si `unUsuario` es un contacto del usuario que publicó el contenido.

Además algunas publicaciones, a las que denominamos **historias**, sólo son visibles **hasta el día siguiente** de su publicación por aquellos usuarios que correspondan de acuerdo a si era pública o no.

Independientemente de todo lo anterior, quien realiza la publicación **siempre puede ver su propio contenido publicado**.

- Se tiene que poder **consultar** si una publicación o historia puede verla un determinado usuario en una fecha mediante el mensaje `esVisible(usuario, fecha)`.
- Debe ser posible en cualquier momento hacer que una publicación o historia se vuelva pública o privada.

> La diferencia en días entre dos fechas (modeladas con instancias de la clase Date) se puede obtener haciendo una resta entre ellas con el mensaje `unaFecha - otraFecha`.
>
> Estos son algunos ejemplos ilustrativos basados en las fechas que se usan desde las pruebas, que se obtienen mediante el objeto `fabrica` que ya entiende estos mensajes:
>
>
> ```wollok
> >>> fabrica.fechaLejanaAPublicacion() - fabrica.fechaPublicacion()
> 10
> >>> fabrica.diaSiguienteAPublicacion() - fabrica.fechaPublicacion()
> 1
> ```

### Pruebas automáticas :test_tube:

Para que el ejercicio esté completo se debe agregar lo necesario para que los tests en `tp4/saberSiEsVisibleElContenidoPublico.wtest` y `tp4/saberSiEsVisibleElContenidoPrivado.wtest` funcionen,
considerando que deben implementarse de forma acorde los siguientes métodos en el objeto **fabrica** (definido en `tp4/fabricaDeObjetosDePrueba.wlk`):

- crearPublicacionPublica
- crearHistoriaPublica
- crearPublicacionPrivada
- crearHistoriaPrivada

Además se deben completar los **TODO**s del grupo de tests "Cambios en la configuración: público / privado" de `tp4/cambiosEnConfiguracionDeContenido.wtest`.

## Parte 2: Contenido secreto :detective:

Necesitamos agregar la posibilidad de que una publicación o historia se cree para que **no sea visible** por ciertos contactos de quien la creó, a modo de **secreto** (sólo aquellos contactos del creador que **no hayan sido restringidos** para ver ese contenido deberían poder verlo).

El objetivo es que sea más restrictivo que las publicaciones o historias privadas, con lo cual las demás limitaciones que aplicaban para el contenido privado también debería aplicar para el contenido secreto.

Al igual que antes, debería ser posible cambiar una publicación o historia creada como secreta para volverla pública o privada, así como el contenido previamente creado como público o privado debería poder cambiarse para volverse secreto, indicando a quiénes se les debe restringir el acceso.

> :warning: Incorporar la funcionalidad nueva asegurando que los requerimientos previos sigan funcionando y **sin repetir lógica**.

### Pruebas automáticas :test_tube:

Para que el ejercicio esté completo se debe agregar lo necesario para que los tests en `tp4/saberSiEsVisibleElContenidoSecreto.wtest` funcionen,
considerando que deben implementarse de forma acorde los siguientes métodos en el objeto **fabrica** (definido en `tp4/fabricaDeObjetosDePrueba.wlk`):

- crearPublicacionSecreta
- crearHistoriaSecreta

Además se deben completar los **TODO**s del grupo de tests "Cambios en la configuración: contenido secreto" de `tp4/cambiosEnConfiguracionDeContenido.wtest`.