# sidekiq_monitoring
A rails engine that provides a JSON endpoint that allows monitoring the current
sidekiq status of the parent app.

## Usage
**TODO:**
Add gem to your project:

    gem 'sidekiq_monitoring'

Schedule job in `whenever`'s `schedule.rb`:

    every 5.minutes do
      runner 'SidekiqMonitoring::Status.refresh'
    end

Be sure that your parent app provides a redis connection via `Redis.current`.
