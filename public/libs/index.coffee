
app = {}

models = require('./models')

app.vm = new models()

ko.applyBindings(app)
