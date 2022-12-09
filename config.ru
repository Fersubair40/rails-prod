# This file is used by Rack-based servers to start the application.

require_relative "config/environment"
require "capistrano/passenger"

if defined?(Capistrano::Passenger)
  sq = nil
  Capistrano::Passenger.on_event(:starting_worker_process) do
    sq = Sidekiq.configure_embed do |config|
      config.queues = ['default']
      config.concurrency = 2
    end
    sq&.run
  end
  Capistrano::Passenger.on_event(:stopping_worker_process)  do
    sq&.stop
  end
end

run Rails.application
Rails.application.load_server
