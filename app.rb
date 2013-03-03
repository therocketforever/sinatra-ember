require 'sinatra/base'
require 'haml'
require 'less'

require File.expand_path(File.dirname(__FILE__) + '/handlebars')

class App < Sinatra::Base
	helpers Sinatra::Handlebars

	set :layout, 'layout'
	set :layout_engine, 'haml'

	get '/css/style.css' do
		less :'less/style'
	end

	get '/templates' do
		content_type 'application/javascript'
		handlebar 'public/templates/**/*.hbs'
	end

	get '/' do
		haml :index
	end

	# start the server if ruby file executed directly
  run! if app_file == $0
end