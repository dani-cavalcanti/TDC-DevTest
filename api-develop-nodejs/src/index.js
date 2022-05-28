const express = require ('express')
const cors = require('cors')

const swaggerUi = require ('swagger-ui-express')

const swaggerDocs = require ('./swagger.json')

const app = express()

app.use((req, res, next) => {
    res.header("Acess-Control-Allow-Origin", "*")
    res.header("Access-Control-Allow-Methods", 'GET,PUT,POST,DELETE')
    app.use(cors())
    next()
})


app.use(express.json())

app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocs))

require('../app/controllers/index')(app)


app.listen(1302)
console.log("Server is Running on port 1302")