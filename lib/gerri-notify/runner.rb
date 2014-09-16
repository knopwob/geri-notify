module GerriNotify
  require 'dbus'
  require 'pry'
  class Runner
    def initialize
      puts 'initializing'
      begin
        @bus = DBus.session_bus
        service = @bus.request_service("org.freedesktop.Notifications")


        exported_obj = DBusConnector.new("/org/freedesktop/Notifications")
        service.export(exported_obj)
      rescue DBus::Connection::NameRequestError
        puts "another notification daemon is already running. Quitting."
        exit 1
      end
    end

    def run
      puts 'running'
      loop = DBus::Main.new
      loop << @bus
      begin
        loop.run
      rescue DBus::Connection::NameRequestError
        puts "another notification daemon is already running. Quitting."
        exit 1
      end
    end
  end
end


