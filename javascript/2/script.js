function cambiarColor(){
    const color = document.getElementById("colorInput").value;

    const hexRegex = /^[0-9A-Fa-f]{6}$/;

    if (color.length == 6 && hexRegex.test(color)){
        document.getElementById("circulo").style.backgroundColor = "#" + color;
    } else {
        alert("Ingrese un valor hexadecimal valido!")
    }
}