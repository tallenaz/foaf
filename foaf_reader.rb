require 'rdf'
require 'linkeddata'

graph = RDF::Graph.load("me.rdf")
puts graph.inspect

query = "SELECT * WHERE {?s ?p ?o}"

sse = SPARQL.parse(query)
sse.execute(graph) do |result|
  puts result.o
end

