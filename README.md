# Mobdevex
Instrucciones
Modificar la aplicación del ejemplo del Login para que tenga lo siguiente:
1) Se debe hacer que el Texto "¿No tienes una cuenta? Registrate" al tocarlo nos lleve a la ventana de Registro.
2) La página de registro debe incluir lo siguiente:
    * Debe tener el mismo fondo que tiene la ventana de Login.
    * Debe incluir mínimo los campos nombre completo, usuario, contraseña y repite contraseña.
    * Debe incluir el botón de guardar.
3) El formulario de los datos debe ser validado(al menos que no esté vacio) mediante Validator del Widget TextFormField.
4) Se debe validar que las dos contraseña ingresadas coincidan, si no coinciden mostrar SnackBar con el texto que no coinciden.
5) Al presionar guardar, se deben guardar los datos ingresados por el usuario mediante SharedPreferences (Usar libreria de pub.dev).
6) La contraseña debe ser encriptada por cualquier algoritmo y guardar la cadena encriptada (No guardar la contraseña en texto plano) pueden usar cualquier algoritmo de encriptación.
7) Después pues de guardar los datos debe regresarse la navegación al Login (ver uso de Navigator)
8) Si el usuario ingresa los datos que guardo y coinciden con lo almacenado (Leer de SharedPreferences) en el registro debe llevarlo a otro widget que se llamada HomePage el cual debe incluir almenos un Scaffold con un container vacio en su body y una AppBar con el titulo "Home Page".
9) Si el usuario y/o contraseña no coinciden con lo almacenado debe mostrarse un SnackBar con el error correspondiente.
10) Puntos Extras
    * Validar que el usuario sea un email bien formado tanto en Registro como en Login (existe libreria en pub.dev) 5 pts.
    * Al hacer un Login correcto la aplicación debe navegar al HomePage pero al presionar <-  o atras no debe regresar al login 5 pts.
