require 'httparty'
require 'json'
require 'pry'

class Kele
	include HTTParty
	
	def initialize(email, password)
		@bloc_url = 'https://www.bloc.io/api/v1'
		response = self.class.post 'https://www.bloc.io/api/v1/sessions', body: {email: email, password: password}
		response_data = parse_response(response)
		@auth_token = response_data['auth_token']
		@user = response_data['user']
	end
	
	def get_me
		if !@user
			response = self.class.get 'https://www.bloc.io/api/v1/users/me', headers: { authorization: @auth_token }
			@user = parse_response(response)
		end
		@user
	end
	
	private
	def parse_response(response)
		body = JSON.parse response.body
		if response.code == 200
			body
		else
			raise "There was a problem retrieving an authentication token. '#{body['message']}'"
		end
	end
end