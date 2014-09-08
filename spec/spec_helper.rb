require 'pry'
require 'byebug'
require 'awesome_print'
require 'vcr'

require 'empirical/client'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

