module GeriNotify
  class Notification
    def initialize(app_name, app_icon, summary, body, actions, hints, expire_time)
      @app_name = app_name
      @app_icon = app_icon
      @summary = summary
      @body = body
      @actions = actions
      @hints = hints
      @expire_time = expire_time

      puts "new notification: #{@app_name}: #{@summary} -- #{@body}"
    end
  end
end
