require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  order = []
  count = 0
  until vertices.empty?
    break if count > 100
    count += 1
    vertices.each do |vert|
      if vert.in_edges.empty?
        vert.out_edges.each do |edge|
          edge.destroy!
        end
        vert.out_edges.each do |edge|
          edge.destroy!
        end
        p vert.out_edges
        vertices.delete(vert)
        order << vert.value
      end
    end
  end
  return [] if count > 100
  order
end
