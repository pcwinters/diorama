github = require('./github')

module.exports = auth = (app)->
	github(app)

	app.get '/login', (req, res)->
		res.render('login', { user: req.user })

	app.get '/logout', (req, res)->
		req.logout()
		res.redirect('/')
	
auth.ensureAuthenticated = (req, res, next)->
	req.user = 
		profile:
			name: 'hard coded'
			login: 'hard_coded'
	return next()
	
	if req.isAuthenticated()
		github.middleware(req, res)
		return next()
	res.redirect('/login')
