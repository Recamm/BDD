// 1
db.usuarios.insertMany([
    {
        _id: 0,
        nombre: "Nicolas",
        apellido: "Orgnero",
        edad: 17,
        mail: "nicolasorgnero@gmail.com",
        compras: [
            {
                _id: 0,
                monto: 500,
                productos: [
                    "manza",
                    "carne"
                ]
            }
        ]
    },
    {
        _id: 2,
        nombre: "Manuel",
        apellido: "Fernandez",
        edad: 18,
        mail: "manufer@gmail.com",
        compras: [
            {
                _id: 1,
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
db.usuarios.find({$expr: {$eq: [{$size: "$compras"}, 2]}})

// 4
db.usuarios.find({}, {"compras.monto": 1}, { _id: 0 })

// 5
db.usuarios.find({$expr: {$gt: [{$size: "compras.productos"}, 5]}})

// 6
// db.usuarios.find({"compras._id": 1}, {compras: {$elemMatch: {_id: 1}}, _id: 0})

// 7
db.usuarios.updateOne({_id: 2}, {$push: {compras: {_id: 3, monto: 900, productos: ["harina", "manza"]}}})

// 8
db.usuarios.updateOne({nombre: "Lucas", apellido: "Martínez"}, {$set: {mail: "lucas.m@gmail.com"}})

// 9
db.usuarios.find({}, {"compras.id_compra": 1, "compras.monto": 1, _id: 1}).sort({"compras.monto": -1}).limit(3)

// 10
db.usuarios.find({compras: {$not: {$elemMatch: {productos: "televisor"}}}}, {nombre: 1, _id: 1})
  
// 11
db.usuarios.find({"compras.productos": "laptop"})

// 12
db.usuarios.find({"compras": {$elemMatch: {"productos": "televisor", "monto": {$gt: 250}}}})