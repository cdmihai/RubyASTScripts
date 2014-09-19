# JSON Parsing example
require "rubygems"
require "json"

class JavaTestFinder
  def find_tests(filePath)
    json = get_json_from_file(filePath)

    #find all methods
    found_methods = []
    find_nodes(json, found_methods, ->(x){is_method(x)})

    #find all test methods
    test_methods = found_methods.find_all{|method| is_test(method)}

    #for each test method, get its asserts
    test_assert_map = {}
    find_asserts(test_methods, test_assert_map)

    result = {}

    result["tests"] = test_methods.size

    if test_methods.size > 0
    	result["asserts"] = test_assert_map.values.reduce(:+) 
    else
    	result["asserts"] = 0
    end

    return result
  end

  def find_asserts(tests, test_assert_map)
  	tests.each do |test|
  		find_asserts_for_test(test, test_assert_map)
  	end
  end

  def find_asserts_for_test(test, test_assert_map)
  	#find all method invocations
  	method_invocations = []
  	find_nodes(test, method_invocations, ->(x){is_method_invocation(x)})

  	#retain invocations that start with "assert"
  	assert_invocations = method_invocations.find_all{|invocation| is_assert(invocation)}

  	test_assert_map[get_method_name(test)] = assert_invocations.size
  end

  def is_assert(invocation)
  	method_name = get_method_name(invocation)

  	method_name.start_with? "assert"
  end

  def find_nodes(root, found_nodes, propertyLambda)

    if propertyLambda.call(root)
    	found_nodes << root
    end

    root["children"].each do |child|
      find_nodes(child, found_nodes, propertyLambda)
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

    annotationString["label"].include? "Test"
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