require 'httparty'
require 'json'
require 'pry'
require_relative 'helpers'
require_relative 'roadmap'
require_relative 'messages'

class Kele
	include HTTParty
	include Roadmap
	include Messages
	
	base_uri 'https://www.bloc.io/api/v1'
	
	# @function									initialize
	# @description							This function will instantiate a Kele object with an authentication token for the Bloc API.
	# @param {String} email 		The email of the user you wish to authenticate as.
	# @param {String} password	The password of the user you wish to authenticate as.
	# @return {Array<Hash>}  
	def initialize(email, password)
		response = self.class.post "/sessions", body: {email: email, password: password}
		@auth_token = Helpers.parse_response(response)['auth_token']
	end
	
	# @function					get_me
	# @description			This function will return the data associated with the current user.
	# @return {Hash}		
	def get_me
		response = self.class.get "/users/me", headers: { 'authorization': @auth_token }
		Helpers.parse_response(response)
	end
	
	# @function
	# @description This function will return the availability of a student's mentor.
	# @param {int} mentor_id The id of the mentor whose availability you want to check.
	# @return {hash}  
	def get_mentor_availability(mentor_id)
		response = self.class.get "/mentors/#{mentor_id}/student_availability", headers: { authorization: @auth_token }
		parse_response(response)
	end
	
end