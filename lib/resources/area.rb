# frozen_string_literal: true

module Snake
  module Resources
    class Area
      Apple = Struct.new(:x, :y)

      attr_reader :width, :height, :apple

      def initialize(width, height)
        @width = width
        @height = height
        new_apple
      end

      def wall?(x, y)
        return true if x.zero?
        return true if y.zero?

        return true if x == width - 1
        return true if y == height - 1

        false
      end

      def apple?(x, y)
        apple.x == x && apple.y == y
      end

      def new_apple
        @apple = Apple.new(rand(1..width - 2), rand(1..height - 2))
      end
    end
  end
end
