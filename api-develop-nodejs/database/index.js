const mongoose = require ('mongoose')

mongoose.connect('mongodb://localhost/rocketqa')
mongoose.Promise = global.Promise

module.exports = mongoose