class Vertex
  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
  attr_accessor :value, :in_edges, :out_edges
end

class Edge
  def initialize(from_vertex, to_vertex, cost = 1)
    @cost = cost
    @from_vertex = from_vertex
    @to_vertex = to_vertex
    from_vertex.out_edges << self
    to_vertex.in_edges << self
  end
  attr_accessor :cost, :from_vertex, :to_vertex
  def destroy!
    @from_vertex.out_edges.delete(self)
    @to_vertex.in_edges.delete(self)
    @from_vertex = nil
    @to_vertex = nil
  end
end
