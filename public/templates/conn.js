var mysql = require('mysql2');
const express = require('express');
const session = require('express-session');
let fs = require('fs');
const path = require('path');
const app=express()
var conn = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "MYSQL",
  database: "ada"
});
var http = require('http');
conn.connect(function(err) {
  if (err) throw err;
  console.log('Database is connected successfully !');
});
