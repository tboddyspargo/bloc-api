module Helpers
	# @function																			parse_response
	# @description																	A function to handle HTTP requests that return JSON data.
	# @param					{HTTPartyResponse}	response	The response object returned by the HTTParty gem's HTTP requests.
	# @return 				{Hash|Array}									A hash or array containing the body of the HTTP response (if successful).
	def Helpers.parse_response(response, payload={}, headers={})
    body = JSON.parse(response.body) unless response.body.empty?
    if response.code == 200
    	body || true
    else
    	raise "There was a problem resolving the request. (#{response.code}) '#{body['message']}'. '#{payload}'. '#{headers}'"
    end
	end
	
	# @function																			get_attribute
	# @description																	A function that will return the value of a key within a JSON object. By default it will search recursively, but you may specify if you only want to search the top level.
	# @param					{Hash}							input			The hash object within which you want to search.
	# @param					{String}						key				The key that holds the value you're interested in.
	# @param					{Hash}							options		An options hash. Supports an 'at_root' attribute (whether or not you wish to search only the topmost level of the Hash. By default this is set to 'false') and an 'all' attribute (whether you want all the matches or just the first match).
	# @return					{any}													Returns the value of the desired key, if found, otherwise returns nil.	
	def Helpers.get_attribute(input, query, options = { at_root: false, all: false, parent: false })
		# puts "Getting attributes that match '#{query}'. at_root: #{options[:at_root]}; all: #{options[:all]}; parent: #{options[:parent]}"
		results = []
		input_is_hash = input.is_a? Hash
		if input_is_hash || input.is_a?(Array)
			# either loop over the keys of the array, or the 
			to_loop = input.is_a?(Hash) ? input.keys.each : input.each_index
			to_loop.each_with_object(input) do |key, obj|
				value = input[key]
				this_result = nil
				if input_is_hash && key.to_s.match(query.to_s)
					# if the current hash key matches search pattern, add it to results.
					# puts "'#{key}' is a match!"
					this_result = options[:parent] ? input : value
				elsif (value.is_a?(Hash) || value.is_a?(Array)) && !options[:at_root]
					# not a match, recurse if value is a Hash or an Array and the options require it.
					# puts "'#{key}' requires recursion."
					this_result = Helpers.get_attribute(value, query, options)
				end
				if !this_result.nil?
					if this_result.is_a?(Array) then results += this_result else results.push(this_result) end
				end
				break if results.count > 0 && !options[:all]
			end
		end
		results.delete(nil)
		return results[0] if results.count === 1
		return results if results.count > 1
		return nil
	end
end