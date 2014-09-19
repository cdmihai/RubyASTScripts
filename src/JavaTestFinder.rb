# JSON Parsing example
require "rubygems"
require "json"

class JavaTestFinder
	
	def find_tests(filePath)
		json = get_json_from_file(filePath)

		#find all methods
		found_methods = []
		find_methods(json, found_methods)

		found_methods.each do |method|
			puts method["typeLabel"]
		end	

		# found_methods.each do |method|
		# 	puts method["typeLabel"]
		# end
		

		#find all test methods

		return 0
	end

	def find_methods(root, found_methods)

		if root["typeLabel"] == "MethodDeclaration"
			found_methods << root
		end

		root["children"].each do |child|
			find_methods(child, found_methods)
		end
	end

	def get_json_from_file(filePath)
		file = open(filePath)
		content = file.read

		return JSON.parse(content)
	end

end