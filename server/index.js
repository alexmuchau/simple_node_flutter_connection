const mysql = require('mysql')
const express = require('express')
const dotenv = require('dotenv')

dotenv.config()

var app = express()
const bodyparser = require('body-parser')

app.use(bodyparser.json())

var mysqlConnection = mysql.createConnection({
  host: process.env.DATABASE_HOST,
  port: 3306,
  user: process.env.DATABASE_USER,
  password: process.env.DATABASE_PASSWORD,
  database: 'employeedb',
  multipleStatements: true
})

mysqlConnection.connect(err => {
  if (!err) {
    console.log('DB connection succeed')
  } else {
    console.log(
      'ERROR! DB connection error :\n',
      JSON.stringify(err, undefined, 2)
    )
  }
})

app.use((req, res, next) => {
  res.append('Access-Control-Allow-Origin', ['*'])
  res.append('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE')
  res.append('Access-Control-Allow-Headers', 'Content-Type')
  next()
})

app.listen(3000, () => console.log('Express Server is running'))

// GET ALL
app.get('/employees', (req, res) => {
  mysqlConnection.query('SELECT * FROM employee', (err, rows, fields) => {
    if (!err) {
      console.log(rows)
      res.send([rows])
    } else {
      console.log(err)
    }
  })
})

// GET BY ID
app.get('/employees/:id', (req, res) => {
  mysqlConnection.query(
    `SELECT * FROM employee WHERE id = ${req.params.id}`,
    (err, rows, fields) => {
      if (!err) {
        res.send(rows)
      } else {
        console.log(err)
      }
    }
  )
})

// DELETE
app.delete('/employees/:id', (req, res) => {
  mysqlConnection.query(
    `DELETE FROM employee WHERE id = ${req.params.id}`,
    (err, rows, fields) => {
      if (!err) {
        res.send('Deleted Succeed')
      } else {
        console.log(err)
      }
    }
  )
})

// INSERT
app.post('/employees/', (req, res) => {
  mysqlConnection.query(
    `INSERT INTO employee VALUE (${req.body.id},'${req.body.name}', '${req.body.empCode}', ${req.body.salary})`,
    (err, rows, fields) => {
      if (!err) {
        // res.send('Insert Succeed')
        res.send(rows)
      } else {
        res.send(err)
      }
    }
  )
})

// UPDATE
app.put('/employees/:id', (req, res) => {
  mysqlConnection.query(
    `UPDATE employee SET name = '${req.body.name}', empCode = '${req.body.empCode}', salary = ${req.body.salary} WHERE id = ${req.params.id}`,
    (err, rows, fields) => {
      if (!err) {
        // res.send('Insert Succeed')
        res.send(rows)
      } else {
        res.send(err)
      }
    }
  )
})
