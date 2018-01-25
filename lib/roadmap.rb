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
	# @description																						This function will submit a checkpoint assignment
	# @param					{Integer}				checkpoint_id						The ID of the checkpoint you wish to submit too.
	# @param					{String}				assignment_branch				The name of the assignment branch you want to submit.		
	# @param					{String}				assignment_commit_url		The URL to the github commit for this assignment submission.
	# @param					{String}				comment									The comment you wish to attach to this Bloc assignment submission.
	def create_submission(checkpoint_id, assignment_branch, assignment_commit_url, comment="")
		enrollment_id = Helpers.get_attribute(get_me, 'enrollment')['id']
		options = { assignment_branch: assignment_branch,
								assignment_commit_link: assignment_commit_url, 
								checkpoint_id: checkpoint_id, 
								comment: comment, 
								enrollment_id: enrollment_id }
		response = self.class.post "/checkpoint_submissions", body: options, headers: { authorization: @auth_token }
		binding.pry
		Helpers.parse_response(response)
	end
	
	# @function																								create_submission
	# @description																						This function will update an assignment submission and associate it with a checkpoint.
	# @param					{Integer}				id											The ID of the assignment submission you wish to modify.
	# @param					{Integer}				checkpoint_id						The ID of the checkpoint this assignment submission should be associated with.
	# @param					{String}				assignment_branch				The name of the assignment branch you want to submit.		
	# @param					{String}				assignment_commit_url		The URL to the github commit for this assignment submission.
	# @param					{String}				comment									The comment you wish to attach to this Bloc assignment submission.
	def update_submission(id, checkpoint_id, assignment_branch, assignment_commit_url, comment="")
		enrollment_id = Helpers.get_attribute(get_me, 'enrollment')['id']
		options = { assignment_branch: assignment_branch,
								assignment_commit_link: assignment_commit_url, 
								checkpoint_id: checkpoint_id, 
								comment: comment, 
								enrollment_id: enrollment_id }
		response = self.class.put "/checkpoint_submissions/#{id}", body: options, headers: { authorization: @auth_token }
		Helpers.parse_response(response)
	end
end