require 'sinatra/base'
require 'v8'

module Sinatra
  module Handlebars
    def handlebar(pattern)
    	cxt = V8::Context.new
			cxt.eval('exports = {}')
      cxt.load('public/js/handlebars.js')
			cxt.load('public/js/ember-template-compiler.js')

      @handlebar = Dir.glob(pattern).map do |file|
      	name = File.basename(file, '.hbs')
      	template = cxt.eval("exports.precompile('%s')" % [File.read(file)])
      	"Ember.TEMPLATES['%s'] = Ember.Handlebars.template(%s);" % [name, template]
      end.join('\n')
    end
  end

  helpers Handlebars
end
