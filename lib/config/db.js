const mysql = require('mysql2');

const db = mysql.createPool({
    host:'127.0.0.1',
    user:'root',
    password:'5546',
    database:'flutter_board',
    dateStrings:"date",
    port:3306
});

module.exports=db;