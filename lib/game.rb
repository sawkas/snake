# frozen_string_literal: true

module Snake
  class Game
    def initialize
      @area = Resources::Area.new(Settings.app.size.width, Settings.app.size.height)
      @snake = Resources::Snake.new(Settings.app.size.width / 2, Settings.app.size.height / 2)
      @steps = 0
    end

    def start
      while snake.alive && !input.exit?
        step

        sleep(0.2)
      end

      finish
    end

    private

    attr_reader :area, :snake, :steps

    def step
      snake.direction = input.snake_direction if input.snake_direction

      snake.step(area)

      area.new_apple if snake.head?(area.apple.x, area.apple.y)

      output.draw

      @steps = steps + 1
    end

    def finish
      input.stop
    end

    def input
      @input ||= Cli::Input.new
    end

    def output
      Cli::Output.new(area, snake, input, steps)
    end
  end
end
