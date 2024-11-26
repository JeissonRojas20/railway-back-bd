const mysql = require("mysql");
const { DB_HOST, DB_USER, DB_PASSWORD, DB_NAME, DB_PORT} = require('../config.js')

const db = mysql.createConnection({
    host:DB_HOST,
    user:DB_USER,
    password:DB_PASSWORD,
    database:DB_NAME,
    port: DB_PORT
});

db.connect(err => {

    if (err) {
        
        console.log(`Error al conectarse con la base de datos: ${err}`);
        
    } else{

        console.log("Base de datos conectada con exito");
        
    }
});

module.exports = db;