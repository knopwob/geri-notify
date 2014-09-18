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
      @timestamp = Time.now
      @state = :pending
      @display_timestamp = nil

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

    def activate!
      @state == :active
      @display_timestamp = Time.now
    end

    def update
      if @state == :active && @display_timestamp + @expire_time > Time.now
        @state = :expired
      end
    end

    def expired?
      @state == :expired
    end

    def pending?
      @state == :pending
    end

    def active?
      @state == :active
    end

    def closed_by_user?
      @state == :closed_by_user
    end

    def closed_by_remote?
      @state == :closed_by_remote
    end

    def close_by_user!
      @state == :closed_by_user
    end

    def close_by_remote!
      @state == :closed_by_remote
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
