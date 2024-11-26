const mysql = require("mysql");
const db = mysql.createConnection({
    host: "autorack.proxy.rlwy.net",
    user: "root",
    password: "cWgMMDSxXKsbafEqTyMuGvqpopLrVTro",
    database: "railway",
    port: 29106
});

db.connect(err => {

    if (err) {
        
        console.log(`Error al conectarse con la base de datos: ${err}`);
        
    } else{

        console.log("Base de datos conectada con exito");
        
    }
});

module.exports = db;
