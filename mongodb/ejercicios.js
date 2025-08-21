// 1
db.usuarios.insertMany([
    {
        nombre: "Nicolas",
        apellido: "Orgnero",
        edad: 17,
        mail: "nicolasorgnero@gmail.com",
        compras: [
            {
                monto: 500,
                productos: [
                    "manza",
                    "carne"
                ]
            }
        ]
    },
    {
        nombre: "Manuel",
        apellido: "Fernandez",
        edad: 18,
        mail: "manufer@gmail.com",
        compras: [
            {
                monto: 1000,
                productos: [
                    "fideos",
                    "arroz"
                ]
            }
        ]
    }
])
 
// 2
db.usuarios.find({edad: {$gt: 25}}, {nombre: 1, apellido: 1})
 
// 3
