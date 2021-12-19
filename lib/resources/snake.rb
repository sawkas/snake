# frozen_string_literal: true

module Snake
  module Resources
    class Snake
      BodyCell = Struct.new(:x, :y)

      attr_accessor :direction
      attr_reader :body, :alive

      DIRECTIONS = %i[up right down left].freeze

      def initialize(x, y)
        @body = [BodyCell.new(x, y)]
        @direction = DIRECTIONS.sample
        @alive = true
      end

      def head?(x, y)
        head.x == x && head.y == y
      end

      def body?(x, y)
        body.any? { |bc| bc.x == x && bc.y == y }
      end

      def step(area)
        new_head = build_new_head

        if area.wall?(new_head.x, new_head.y) || body?(new_head.x, new_head.y)
          @alive = false

          return
        end

        body.pop unless area.apple?(new_head.x, new_head.y)
        body.unshift(new_head)
      end

      def length
        body.size
      end

      private

      def head
        body.first
      end

      def build_new_head
        new_head = head.dup

        case direction
        when :up
          new_head.y -= 1
        when :down
          new_head.y += 1
        when :right
          new_head.x += 1
        when :left
          new_head.x -= 1
        end

        new_head
      end
    end
  end
end
