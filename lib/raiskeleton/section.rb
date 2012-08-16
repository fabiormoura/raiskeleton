module Raiskeleton
  class Section
    attr_accessor :name
    attr_accessor :cells

    def initialize(name)
      raise "section name should not be blank" if name.blank?
      self.name = name
      self.cells = []
    end

    def render_cell(name,state)
      self.cells << {:name => name, :state => state}
    end
  end
end