require 'httparty'
require 'pry'

class Kele
	include HTTParty
	
	def initialize(email, password)
		@bloc_url = 'https://www.bloc.io/api/v1'
		response = self.class.post 'https://www.bloc.io/api/v1/sessions', body: {email: email, password: password}
		body = JSON.parse response.body
		if response.code == 200
			@auth_token = JSON.parse(response.body)['auth_token']
		else
			raise "There was a problem retrieving an authentication token. '#{body['message']}'"
		end
	end
	
end