# frozen_string_literal: true

module Snake
  module Cli
    class Input
      attr_reader :value

      def initialize
        @thread = nil
        @value = nil
      end

      def start
        @thread = Thread.new { @value = $stdin.getch }
      end

      def stop
        @thread&.exit
        @value = nil
      end

      def exit?
        value == "\u0003" # CTRL + C
      end

      def snake_direction
        CONTROLS[value]
      end

      CONTROLS = { 'w' => :up, 'a' => :left, 's' => :down, 'd' => :right }.freeze
    end
  end
end
