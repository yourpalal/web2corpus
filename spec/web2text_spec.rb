require 'web2text'
require 'web2text/version'
require 'shellwords'

ROOT = "http://example.com"

def parse(args)
  Web2Text.parse_cli "#{args} #{ROOT}".shellsplit
end

RSpec.describe Web2Text do
  it 'has a semver VERSION' do
    expect(Web2Text::VERSION =~ /\d+\.\d+\.\d+/).to be 0
  end
end

RSpec.describe Web2Text, '#parse_cli' do
  it 'defaults to 0 sleep' do
    expect(parse('')[:sleep]).to be 0.0
  end

  it 'sleeps for 1s with -s' do
    expect(parse('-s')[:sleep]).to be 1.0
  end

  it 'can specify sleep with -s N or --sleep N' do
    expect(parse('-s 2')[:sleep]).to be 2.0
    expect(parse('--sleep 2')[:sleep]).to be 2.0
  end
end
