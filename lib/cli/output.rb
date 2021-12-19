# frozen_string_literal: true

module Snake
  module Cli
    class Output
      def initialize(area, snake, input, steps)
        @area = area
        @snake = snake
        @input = input
        @steps = steps
      end

      def draw
        output = info_string + game_string

        input.stop
        print(CLEAR_SEQUENCE) unless steps.zero?
        print(output)
        input.start
      end

      private

      OUTPUT_LINES_COUNT = Settings.app.size.height + 4
      ONE_LINE_CLEAR_SEQUENCE = "\r#{' ' * `tput cols`.chomp.to_i}\e[F"
      CLEAR_SEQUENCE = (ONE_LINE_CLEAR_SEQUENCE * OUTPUT_LINES_COUNT).freeze
      SEPARATOR_LINE = ('==' * Settings.app.size.width).freeze

      attr_reader :snake, :area, :input, :steps

      def info_string
        <<~INFO
          #{SEPARATOR_LINE}
          STEPS = #{steps}
          LENGTH = #{snake.length}
          #{SEPARATOR_LINE}
        INFO
      end

      def game_string
        string = ''

        area.height.times do |y|
          area.width.times do |x|
            string +=
              if area.wall?(x, y)
                pixel(colors.wall)
              elsif snake.head?(x, y)
                pixel(colors.snake.head)
              elsif snake.body?(x, y)
                pixel(colors.snake.body)
              elsif area.apple?(x, y)
                pixel(colors.apple)
              else
                pixel(colors.area)
              end
          end
          string += "\n"
        end

        string
      end

      def pixel(color)
        '  '.bg(color)
      end

      def colors
        Settings.app.colors
      end
    end
  end
end
