#!/usr/bin/env ruby

require 'ASTInterfaceLib.rb'
require 'java'
require '../lib/gumtree.jar'
require '../lib/gumtreeFacade.jar'

@ast = Java::gumtreeFacade.AST

def treeAST(source, extension)
	return @ast.getTreeAST(source, extension)
end

def treeAST(path)
	return @ast.getTreeAST(path)
end

def diffAST(source, destination, extension)
	return @ast.getDiffAST(source, destination, extension)
end

def diffAST(src_path, dst_path)
	return @ast.getDiffAST(src_path, dst_path)
end


# Optional command-line execution using --tree or --diff options (absolute filepaths required)
options = Optparser.parse(ARGV)
if options.tree
	fname = options.files.fetch(0, "No filepath argument")
	unless File.exist?(fname)
		puts "File not located on path " + File.absolute_path(__FILE__)
	else
		puts treeAST(File.path(fname))
	end
end

if options.diff
	fname1 = options.files.fetch(0, "No filepath argument")
	fname2 = options.files.fetch(1, "No filepath argument")
	unless File.exist?(fname1) || File.exist?(fname2)
		puts "Files not located on path " + File.absolute_path(__FILE__)
	else
		puts diffAST(File.path(fname1), File.path(fname2))
	end
end