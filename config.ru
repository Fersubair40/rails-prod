# This file is used by Rack-based servers to start the application.

require_relative "config/environment"



if defined?(PhusionPassenger)
  sq = nil
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    sq = Sidekiq.configure_embed do |config|
      config.queues = ['default']
      config.concurrency = 2
    end
    sq&.run
  end
  PhusionPassenger.on_event(:stopping_worker_process) do |forked|
    sq&.stop
  end
end


run Rails.application
Rails.application.load_server
