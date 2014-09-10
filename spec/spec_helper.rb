require 'pry'
require 'byebug'
require 'awesome_print'
require 'vcr'
require 'webmock'

require 'empirical/client'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr_cassettes'
  c.hook_into :webmock
  # c.debug_logger = STDOUT

  c.ignore_request do |req|
    URI(req.uri).port == 80808
  end
end

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # focus tests
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

end

