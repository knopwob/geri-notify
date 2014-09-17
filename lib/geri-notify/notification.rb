module GeriNotify
  require 'time'
  require 'pry'
  class Notification

    include Comparable

    attr :urgency
    attr :timestamp

    def initialize(app_name, app_icon, summary, body, actions, hints, expire_time)
      @app_name = app_name
      @app_icon = app_icon
      @summary = summary
      @body = body
      @actions = actions
      @hints = hints
      @timestamp = Time::now

      normalize_expire_time(expire_time)
      resolve_urgency(hints["urgency"])

      puts "new notification: #{@app_name}: #{@summary} -- #{@body}"
    end

    def resolve_urgency(raw_urgency)
      @urgency = case raw_urgency
      when 0
        :low
      when 1
        :normal
      when 2
        :critical
      else
        :normal
      end
    end

    def normalize_expire_time(raw_expire_time)
      if raw_expire_time >= 0
        @expire_time = raw_expire_time / 1000
      else
        @expire_time = 15 # TODO configurable default value
      end
    end

    def expired?
      if expire_time == 0
        false
      else
        @timestamp + @expire_time > Time::now
      end
    end

    def <=>(other)
      if @urgency == other.urgency
          other.timestamp <=> @timestamp
      else
        -1 if @urgency == :low
        1  if @urgency == :critical
        if other.urgency == :low
          1
        else
          -1
        end
      end
    end
  end
end
