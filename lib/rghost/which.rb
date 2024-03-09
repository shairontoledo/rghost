module RGhost
  # A cross-platform way of finding an executable in the $PATH.
  #
  #   RGhost::Which.('ruby') #=> /usr/bin/ruby
  class Which
    def self.call(cmd)
      new.call(cmd)
    end

    def initialize(env: ENV)
      @env = env
    end

    def call(cmd)
      cmd_path = Pathname(cmd)
      return cmd_path.to_path if cmd_path.absolute? && cmd_path.executable?

      extensions = fetch_executable_extensions
      env.fetch("PATH", "").split(File::PATH_SEPARATOR).each do |path|
        path = Pathname(path)

        extensions.each do |ext|
          exe = path.join("#{cmd}#{ext}")
          return exe.to_path if exe.executable?
        end
      end
      nil
    end

    private

    attr_reader :env

    def fetch_executable_extensions
      # Get list of executable extensions on Windows
      env.fetch("PATHEXT", "").split(";").tap do |extensions|
        # On non-Windows this is empty; add ""to search for extension-less files
        extensions.push("") if extensions.empty?
      end
    end
  end
end
