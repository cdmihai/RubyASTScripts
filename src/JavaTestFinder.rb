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

		if is_method(root)
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
		annotation = find_child(method, ->(x){is_annotation(x)})

		return false if annotation.nil?

		is_test_annotation(annotation) ? true : false
	end

	def is_test_annotation(annotation)
		annotationString = find_child(annotation, ->(x){is_qualified_name(x)})

		puts annotationString

		return annotationString["label"].include? "Test"
	end
	
	def is_method(node)
	  node["typeLabel"] == "MethodDeclaration"
	end
	
	def is_annotation(node)
	   node["typeLabel"] == "MarkerAnnotation"
	end

  def is_qualified_name(node)
    node["typeLabel"] == "QualifiedName"
  end
  
  def find_child(node, childOKLambda)
    node["children"].find{|child| childOKLambda.call(child)}
  end
end