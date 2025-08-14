const lista = document.getElementById("listaCompra");
const inputLista = document.getElementById("inputLista");

function agregarItem() {
    const inputItem = inputLista.value;
    if(inputItem !== ""){
        const listItem = document.createElement("p");
        const buttonItem = document.createElement("button")
        const div = document.createElement("div");

        listItem.innerHTML = inputItem;
        listItem.addEventListener("click", tacharItem);
        listItem.class
        inputLista.value = "";

        buttonItem.innerHTML = "Eliminar";
        buttonItem.addEventListener("click", eliminarItem)

        div.appendChild(listItem);
        div.appendChild(buttonItem);
        lista.appendChild(div);
    }
}

function tacharItem(event){
    event.target.classList.toggle("tachado");
}

function eliminarItem(event) {
    const itemAEliminar = event.target.parentElement;
    itemAEliminar.remove();
}