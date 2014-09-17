module GeriNotify
  require 'time'
  require 'pry'
  class Notification
    def initialize(app_name, app_icon, summary, body, actions, hints, expire_time)
      @app_name = app_name
      @app_icon = app_icon
      @summary = summary
      @body = body
      @actions = actions
      @hints = hints
      if expire_time >= 0
        # expire_time per api is in milliseconds but we use seconds internally
        @expire_time = expire_time / 1000
      else
        @expire_time = 15 # TODO default time should be configurable
      end

      @timestamp = Time::now

      if hints.has_key?("urgency")
        @urgency = case hints["urgency"]
        when 0
          :low
        when 1
          :normal
        when 2
          :critical
        else
          :normal
        end
      else
        @urgency = :normal
      end

      puts "new notification: #{@app_name}: #{@summary} -- #{@body}"
    end

    def expired?
      if expire_time == 0
        false
      else
        @timestamp + @expire_time > Time::now
      end
    end
  end
end
