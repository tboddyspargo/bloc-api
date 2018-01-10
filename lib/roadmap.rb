require_relative 'helpers'
module Roadmap

	# @function                     get_roadmap
	# @description									This function will return the roadmap data.
	# @param {Integer} roadmap_id 	The id of the roadmap you want to retreive.
	# @return {Array<Hash>}
	def get_roadmap(roadmap_id=get_me['program']['current_roadmap_id'])
		response = self.class.get "/roadmaps/#{roadmap_id}", headers: { 'authorization': @auth_token }
		Helpers.parse_response(response)
	end
	
	# @function                     get_checkpoint
	# @description									This function will return the checkpoint data.
	# @param {Integer} checkpoint_id 	The id of the checkpoint you want to retreive.
	# @return {Array<Hash>}
	def get_checkpoint(checkpoint_id)
		response = self.class.get "/checkpoints/#{checkpoint_id}", headers: { 'authorization': @auth_token }
		Helpers.parse_response(response)
	end
end