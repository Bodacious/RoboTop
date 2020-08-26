# frozen_string_literal: true

module RoboTop
  # Represents a real-world table-top that a {Robot} might be placed on. Has a grid
  # of {cols}x{rows} where a {Robot} may maneuver.
  #
  class Table

    ##
    # Default number of cells per {Table}
    TABLE_CELLS = 5

    ##
    # Default number of rows per {Table}
    TABLE_ROWS = 5

    ##
    # Number of the cols (x) on the Table
    attr_reader :cols

    ##
    # Number of the rows (y) on the Table
    attr_reader :rows

    def initialize(cols = TABLE_CELLS, rows = TABLE_ROWS)
      @cols = cols.to_i
      @rows = rows.to_i
    end

    # Are the given x and y values within this Table's bounds?
    #
    # x - An Integer representing a cell's X point
    # y - An Integer representing a cell's Y point
    #
    # Returns Boolean
    def in_bounds?(x, y)
      return false if x.to_i < 0
      return false if y.to_i < 0

      x.to_i < cols && y.to_i < rows
    end

    # Display table as a String (e.g. "(4x3)")
    #
    # Returns String
    def to_s
      "(#{cols},#{rows})"
    end
  end
end
