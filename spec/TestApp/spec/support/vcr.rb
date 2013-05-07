require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = "fixtures/cassettes"
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = { record: :new_episodes }
end