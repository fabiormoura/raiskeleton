module Raiskeleton
  class Section
    attr_accessor :name
    attr_accessor :cells

    INVALID_NAME = "section name cannot be nil or empty"

    def initialize(name)
      raise INVALID_NAME if not Raiskeleton::Section.name_valid?(name)
      self.name = name
      self.cells = []
    end

    def render_cell(name,state,*args)
      raise "cell name cannot be nil or empty" if name.nil? || name.empty?
      raise "cell state cannot be nil" if state.nil? || state.empty?
      self.cells << {:name => name, :state => state, :args => args}
    end

    def self.name_valid?(name)
      !name.nil? && !name.empty?
    end
  end
end
