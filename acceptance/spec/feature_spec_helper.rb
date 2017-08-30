require 'sinatra'
require 'yaml'
require 'erb'
require 'rspec/retry'

Bundler.require :default, :test

Sinatra::Application.environment = :test

require_relative 'helpers/code_challange_083017_server'
require_relative 'helpers/simulator_server'
require_relative 'helpers/retry_for'
require_relative 'helpers/read_fixture'
require_relative 'helpers/simulator_helper'

ENV['CODE_CHALLENGE_083017'] ||= '8888'
ENV['CODE_CHALLENGE_083017'] = (ENV['CODE_CHALLENGE_083017'].to_i + ENV['TEST_ENV_NUMBER'].to_i).to_s
ENV['SIMULATOR'] ||= '9999'
ENV['SIMULATOR'] = (ENV['SIMULATOR'].to_i + ENV['TEST_ENV_NUMBER'].to_i).to_s

application_spec_helper = CodeChallenge083017Server.new(ENV['CODE_CHALLENGE_083017'], ENV['SIMULATOR'])
simulator = SimulatorServer.new(ENV['SIMULATOR'])

def by(description)
  yield
end

alias and_by by

RSpec.configure do |config|
  config.verbose_retry = true
  config.display_try_failure_messages = true

  config.before :suite do
    application_spec_helper.start
    simulator.start

    files = []
    Dir.glob('tmp/*.png').each do |f|
      files << f
    end
    FileUtils.rm files
  end

  config.after :suite do
    application_spec_helper.stop
    simulator.stop
  end

  config.after :each do ||
    simulator.assert_no_bad_requests
    simulator.reset
  end
end

def http_get(endpoint)
  HTTParty.get("http://localhost:#{ENV['CODE_CHALLENGE_083017']}/#{endpoint}")
end

def get_fixture_data(fixture, status=200)
  return fixture.to_json unless fixture.is_a? Symbol

  {
    response: read_fixture("/#{fixture}.json"),
    status: status
  }.to_json
end
