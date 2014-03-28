###
Module dependencies.
###
CoolBeans = require 'CoolBeans'
container = new CoolBeans require '../production-module'

lights = container.get('lights').for 407571

express = require("express")
routes = require("./routes")(lights)
http = require("http")
path = require("path")
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", __dirname + "/views"
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join(__dirname, "public"))

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", routes.index
app.post "/lights", routes.lights
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

withResponse = (callback) ->
    (req, res) ->
      callback()
      res.set('Access-Control-Allow-Origin', '*');
      res.set('Access-Control-Allow-Methods', 'GET, POST');
      res.set('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type');
      res.send('OK')

commands = {GRUENAN: -> lights.green on}

app.get '/ampel/GRUENAN', withResponse(-> lights.green on)
app.get '/ampel/ROTAN', withResponse(-> lights.red on)
app.get '/ampel/GELBAN', withResponse(-> lights.yellow on)
app.get '/ampel/GRUENAUS', withResponse(-> lights.green off)
app.get '/ampel/ROTAUS', withResponse(-> lights.red off)
app.get '/ampel/GELBAUS', withResponse(-> lights.yellow off)
app.get '/ampel/ALLEAUS', withResponse(-> lights.all off)
app.get '/ampel/ALLEAN', withResponse(-> lights.all on)
app.get '/traffic/:command', -> (req, res) ->
