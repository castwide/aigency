# frozen_string_literal: true

require 'tmpdir'
require 'fileutils'

module Aigency
  module Tempdir
    require 'aigency/tempdir/list'
    require 'aigency/tempdir/read'
    require 'aigency/tempdir/write'

    PATH = Dir.mktmpdir
    TOOLS = [List, Read, Write]

    at_exit { FileUtils.rm_rf PATH }
  end
end
