# frozen_string_literal: true

module RoboTop
  # Simple Struct to represent a compass Direction (e.g. North).
  class Direction < Struct.new(:name)
    ##
    # Exception class. Raised when attempting to create an invalid
    # Direction
    class InvalidDirectionError < ArgumentError
    end

    ##
    # List of valid Direction names
    ALL = %w[NORTH EAST SOUTH WEST].freeze

    ##
    # Create a singleton for each Direction
    ALL.each { |dir| const_set(dir, new(dir)) }

    alias to_s name

    # ==============================================================================
    # = Class methods =
    # ==============================================================================

    ##
    # Find the Direction singleton with the given name
    #
    # name - A String with a valid Direction name
    #
    # Returns Direction
    # Raises InvalidDirectionError
    def self.named(name)
      return const_get(name.to_s) if ALL.include?(name.to_s)

      raise InvalidDirectionError, "No such direction '#{name}'"
    end

    private_class_method :new

    # ==============================================================================
    # = Public instance method =
    # ==============================================================================

    ##
    # The Direction one left (90 deg) turn from self
    #
    # Returns Direction
    def left
      new_index = index - 1
      self.class.named(ALL[new_index])
    end

    ##
    # The Direction one right (90 deg) turn from self
    #
    # Returns Direction
    def right
      new_index = index + 1
      new_index_corrected = new_index % ALL.length
      self.class.named(ALL[new_index_corrected])
    end

    ##
    # Compare this Direction with a given value
    #
    # other - One of String, Symbol, or Direction
    #
    # Examples
    #
    #   @north = Direction.named("NORTH")
    #   @north == :north # => true
    #   @north == 'north' # => true
    #   @north == Direction.named("NORTH") # => true
    #   @north == Direction.named("EASt") # => false
    #
    # Returns Boolean
    def ==(other)
      if other.respond_to?(:name)
        name == other.name
      else
        name.to_s.downcase == other.to_s.downcase
      end
    end

    private

    def index
      ALL.index(name)
    end
  end
end
