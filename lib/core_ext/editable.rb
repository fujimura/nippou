# -*- encoding: utf-8 -*-
require 'tempfile'

module Editable

  # Edit self by $EDITOR
  #
  def edit!
    temp = Tempfile.new(self.object_id.to_s)
    temp << self unless self.empty?
    temp.read # TODO?

    system(ENV["EDITOR"], temp.path)

    temp.open
    edited = temp.read
    temp.close!

    self.replace edited
  end
end

String.send :include, Editable
