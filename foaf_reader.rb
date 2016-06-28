require 'rdf'
require 'linkeddata'

graph = RDF::Graph.load("me.rdf")
puts graph.inspect

query = "
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
SELECT * 
WHERE {?s foaf:knows ?o}"

sse = SPARQL.parse(query)
sse.execute(graph) do |result|
  puts result.o
end

