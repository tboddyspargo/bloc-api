require_relative 'helpers'
module Roadmap

	# @function                     													get_roadmap
	# @description																						This function will return the roadmap data.
	# @param					{Integer} 			roadmap_id 							The id of the roadmap you want to retreive.
	# @return 				{Array<Hash>}
	def get_roadmap(roadmap_id)
		response = self.class.get "/roadmaps/#{roadmap_id}", headers: { 'authorization': @auth_token }
		Helpers.parse_response(response)
	end
	
	# @function                     													get_checkpoint
	# @description																						This function will return the checkpoint data.
	# @param					{Integer} 			checkpoint_id 					The id of the checkpoint you want to retreive.
	# @return 				{Array<Hash>}
	def get_checkpoint(checkpoint_id)
		response = self.class.get "/checkpoints/#{checkpoint_id}", headers: { 'authorization': @auth_token }
		Helpers.parse_response(response)
	end
	
	# @function																								create_submission
	# @description																						This function will submit a checkpoint and assignment
	# @param					{Integer}				checkpoint_id						The ID of the checkpoint you wish to submit too.
	# @param					{String}				assignment_branch				The name of the assignment branch you want to submit.		
	# @param					{String}				assignment_commit_link	The commit identifier.
	# @param					{String}				comment									The comment you wish to attach to this Bloc submission.
	def create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment="")
		enrollment_id = Helpers.get_attribute(get_me, 'enrollment')['id']
		options = { assignment_branch: assignment_branch,
								assignment_commit_link: assignment_commit_link, 
								checkpoint_id: checkpoint_id, 
								comment: comment, 
								enrollment_id: enrollment_id }
		response = self.class.post "/checkpoint_submissions", body: options, headers: { authorization: @auth_token }
		Helpers.parse_response(response)
		return
	end
end