module ImageEditor

  class OutOfBoundsError < StandardError; end
  class ArgumentError < StandardError; end
  class Image
    attr_accessor :data

    def initialize(x, y)
      @x = x
      @y = y
      @data = Array.new(y) { Array.new(x) {"O"} }
    end

    def [](x,y)
      check_coords(x,y)

      @data[y - 1][x - 1]
    end

    def []=(x, y, value)
      check_coords(x,y)

      @data[y - 1][x - 1] = value
    end

    def to_s
      @data.collect {|row| row.join(" ")}.join("\n")
    end

    def clear
      (1..@x).each  do |x|
        (1..@y).each do |y|
          self[x, y] = "O"
        end
      end
    end

    def draw_vertical(x, y1, y2, color)
      raise ArgumentError.new("#{y1} should be less than #{y2}") if y1 > y2

      (y1..y2).each do |y|
        self[x, y] = color
      end
    end

    def draw_horizontal(x1, x2, y, color)
      raise ArgumentError.new("#{x1} should be less than #{x2}") if x1 > x2
      (x1..x2).each do |x|
        self[x, y] = color
      end
    end

    def fill_region(x, y, color)
      check_coords(x, y)
      @visited = Array.new(@y) { Array.new(@x) {false} }
      @pixels = [[x, y]]
      initial_color = self[x, y]

      while (pixel = @pixels.pop) do
        # Get the coords
        (i, j) = pixel

        # mark as visited
        @visited[j - 1][i - 1] = true

        # paint the pixel
        self[i, j] = color

        # put the neighbours that might exist, but reject already visited
        # and those with different_colors
        @pixels += self.neighbours(i, j).reject do |(a,b)|
          @visited[b-1][a-1] || (self[a, b] != initial_color)
        end
      end
    end

    def neighbours(x,y)
      check_coords(x,y)
      x_range = (x-1..x+1).to_a
      y_range = (y-1..y+1).to_a

      x_range.product(y_range).reject do |(a,b)|
        (a == x && b == y) || is_out_of_bounds(a,b)
      end
    end

    private
    def check_coords(x,y)
      raise OutOfBoundsError.new("Out of Bounds: #{x}, #{y}") if is_out_of_bounds(x,y)
    end


    def is_out_of_bounds(x,y)
      x <= 0 || y <= 0 || x > @x || y > @y
    end
  end
end
