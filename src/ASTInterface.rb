#!/usr/bin/env ruby

require 'java'
require 'gumtree.jar'
require 'gumtreeFacade.jar'

@ast = Java::gumtreeFacade.AST

def treeAST(filepath)
	return @ast.getTreeAST(filepath)
end

def diffAST(src, dst)
	return @ast.getDiffAST(src, dst)
end