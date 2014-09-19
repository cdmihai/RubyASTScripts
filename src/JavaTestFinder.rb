# JSON Parsing example
require "rubygems"
require "json"

class JavaTestFinder

	def find_tests(filePath)
		json = get_json_from_file(filePath)

		#find all methods
		found_methods = []
		find_methods(json, found_methods)

		#find all test methods
		test_methods = found_methods.find_all{|method| is_test(method)}

		return test_methods.size
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

	def is_test(method)
		annotation = method["children"].find{|child| child["typeLabel"] == "MarkerAnnotation"}

		return false if annotation.nil?

		is_test_annotation(annotation) ? true : false
	end

	def is_test_annotation(annotation)
		annotationString = annotation["children"].find{|child| child["typeLabel"] == "QualifiedName"}

		puts annotationString

		return annotationString["label"].include? "Test"
	end

end