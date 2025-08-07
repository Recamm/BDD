function enviarForm(){
    const nombre = document.getElementById("nombre").value;
    const apellido = document.getElementById("apellido").value;
    const contrasenia = document.getElementById("contrasenia").value;
    const edad = document.getElementById("edad").value;
    const telefono = document.getElementById("telefono").value;

    if(nombre.includes(" ") || apellido.includes(" ") || contrasenia.length <= 6 || 
    contrasenia.includes(nombre) || contrasenia.includes(apellido) || edad < 10 ||
    telefono.length < 10){
        alert("Error");
    }
}