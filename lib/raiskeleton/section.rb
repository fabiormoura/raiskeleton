module Raiskeleton
  class Section
    attr_accessor :name
    attr_accessor :cells

    def initialize(name)
      raise "section name cannot be nil or empty" if name.nil? || name.empty?
      self.name = name
      self.cells = []
    end

    def render_cell(name,state,*args)
      raise "cell name cannot be nil or empty" if name.nil? || name.empty?
      raise "cell state cannot be nil" if state.nil? || state.empty?
      self.cells << {:name => name, :state => state, :args => args}
    end
  end
end
