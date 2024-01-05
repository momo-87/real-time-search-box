# This file is used to schedule the cleanup job
# It will run the cleanup method from the QueryAnalyticTableCleanup every 3 seconds

require 'clockwork'
require_relative '../config/boot'
require_relative '../config/environment'

module Clockwork
  every(3.seconds, 'cleanup.job') do
    QueryAnalyticTableCleanup.cleanup
  end
end