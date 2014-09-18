# JSON Parsing example
require "rubygems"
require "json"

string = '{"desc":{"someKey":"someValue","anotherKey":"value"},"main_item":{"stats":{"a":8,"b":12,"c":10}}}'
parsed = JSON.parse(string) # returns a hash

p parsed["desc"]["someKey"]
p parsed["main_item"]["stats"]["a"]