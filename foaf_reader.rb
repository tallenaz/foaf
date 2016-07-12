# Following tutorial at http://blog.datagraph.org/2010/04/parsing-rdf-with-ruby
require 'rdf'
require 'linkeddata'
require 'sparql'
require 'net/http'
require 'openssl'

graph = RDF::Graph.load("me.rdf")

puts graph.inspect

query = "
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
SELECT DISTINCT ?o
  WHERE { ?s foaf:knows ?o }
"

puts "Before loading"
sse = SPARQL.parse(query)
sse.execute(graph) do |result|
  puts result.o
  triples = RDF::Resource(RDF::URI.new(result.o))
  graph.load(triples)
end

puts "After loading"
sse.execute(graph) do |result|
  puts result.o
end

interest_query = "
PREFIX foaf: <http://xmlns.com/foaf/0.1/>
SELECT DISTINCT ?o
  WHERE { ?s foaf:interest ?o }
"

tmp_query = "PREFIX foaf: <http://xmlns.com/foaf/0.1/>
  PREFIX dbo: <http://dbpedia.org/ontology/>
  SELECT ?abs
    WHERE { ?s dbo:abstract ?abs
      FILTER (lang(?abs) = 'en')}"

tmp_graph = RDF::Graph.load("http://dbpedia.org/resource/Quilting")
sse_abstracts = SPARQL.parse(tmp_query)
sse_abstracts.execute(tmp_graph) do |res|
  puts res.abs
end
