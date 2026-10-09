# frozen_string_literal: true

require 'fileutils'
require 'thor'

module Aigency
  class Shell < Thor
    map %i[new] => :enlist
    desc "enlist [DIRECTORY]", "Enable the current user as an aigent"
    def enlist directory = 'aigent'
      puts "Installing aigent at #{directory}"
      if File.exist?(directory)
        if !File.directory?(directory)
          raise "#{directory} is not a directory."
        end
        if !Dir.empty?(directory)
          raise "#{directory} is not empty."
        end
      end
      FileUtils.mkdir(directory) unless File.directory?(directory)
      FileUtils.copy_entry(File.join(GEM_PATH, 'scaffold', 'aigent'), directory)
    end

    # desc "setup PLUGIN [...PLUGIN]", "Initialize plugin files"
    # option :all, type: :boolean, alias: :a, description: "Set up all plugins", default: false
    # option :overwrite, type: :boolean, alias: :o, description: "Overwrite existing files", default: false
    # def setup *plugins
    #   # @todo Assuming all for now
    #   aigent = Aigent.new(aigent)
    #   aigent.setup
    # end
  end
end
