class DynamicProgramming
  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {1 => [[1]], 2 => [[1,1], [2]], 3 => [[1,1,1], [1,2], [2,1], [3]] }
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    solution = blair_nums(n-1) + blair_nums(n-2) + n*2-1
    @blair_cache[n] = solution
    solution
  end

  def frog_hops(n)
    return if n > 11
    frog_hops_top_down(n)
    @frog_cache[n]
  end

  def frog_cache_builder(n)
    cache = {1 => [[1]], 2 => [[1,1], [2]], 3 => [[1,1,1], [1,2], [2,1], [3]] }
    return [] if n < 1
    return cache[n] if cache[n]
    4.upto(n) do |i|
      solution = []
      solution += cache[i-1].map { |one| one + [1]}
      solution += cache[i-2].map { |two| two + [2]}
      solution += cache[i-3].map { |three| three + [3]}
      cache[i] = solution
      p i
    end
    cache
  end

  def frog_hops_top_down(n)
    return @frog_cache[n] if @frog_cache[n]
    @frog_cache[n] = frog_cache_builder(n)
  end

  def super_frog_hops(n, k)
  end

  def make_change(amt, coins)
    return [] if amt == 0
    return nil if coins.empty?
    return nil if amt < coins.first
    first_coin_copies = coins.first

    solution = nil
    solution_length = 1.0/0.0

    until first_coin_copies > amt
       candidate_soln = make_change(amt - first_coin_copies, coins[1...coins.length])
       break if candidate_soln.nil?
       if candidate_soln && candidate_soln.length < solution_length
         solution = candidate_soln
         solution_length = candidate_soln.length
       end

       first_coin_copies += coins.first
     end

     solution
  end

  def maze_solver(maze, start_pos, end_pos)
  
    return [] if start_pos == end_pos
    x = start_pos[0]
    y = start_pos[1]
    @maze_cache = {}
    unless maze[x+1][y] == 'X' || @maze_cache[[x+1, y]]
      a = maze_solver(maze, [x+1, y], end_pos)
      @maze_cache[[x+1, y]] = true
      path = [x+1, y] + a
    end
    unless maze[x-1][y] == 'X' || @maze_cache[[x-1, y]]
      b = maze_solver(maze, [x+1, y], end_pos)
      @maze_cache[[x-1, y]] = true
      path = [x-1, y] + a
    end
    unless maze[x][y+1] == 'X' || @maze_cache[[x, y+1]]
      c = maze_solver(maze, [x, y+1], end_pos)
      @maze_cache[[x, y+1]] = true
      path = [x, y+1] + a
    end
    unless maze[x][y-1] == 'X' || @maze_cache[[x, y-1]]
      d = maze_solver(maze, [x, y-1], end_pos)
      @maze_cache[[x, y-1]] = true
      path = [x, y-1] + a
    end
    p path
    path
  end
end
