require 'vcr'

def vcr(cassette, record=:none)
  VCR.use_cassette(cassette, record: record) do
    yield 
  end
end