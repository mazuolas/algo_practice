# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require 'byebug'
require_relative 'graph'

def install_order(arr)
  verts = []
  max_id = -1
  arr.each do |el|
    max_id = el[0] if el[0] > max_id
  end

  (1..max_id).each do |id|
    verts << Vertex.new(id)
  end
  arr.each do |el|
    Edge.new(verts[el[1]-1], verts[el[0]-1])
  end
  order = []
  until verts.empty?
    verts.each do |vert|
      if vert.in_edges.empty?
        vert.out_edges.each do |edge|
          edge.destroy!
        end
        vert.out_edges.each do |edge|
          edge.destroy!
        end
        verts.delete(vert)
        order << vert.value
      end
    end
  end
  order
end
