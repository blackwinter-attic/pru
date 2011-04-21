module Pru

  module Helper

    extend self

    EXTENSIONS = ['', '.pru', '.rb']

    def load_file(file, type)
      if _file = find_file(file)
        file = _file
      else
        home = begin
          require 'nuggets/env/user_home'
          ENV.user_home
        rescue LoadError
          File.expand_path('~')
        end

        if _file = find_file(File.join(home, '.pru', type.to_s, file))
          file = _file
        end
      end

      begin
        File.read(file)
      rescue => err
        abort "#{$0}: #{err}"
      end
    end

    def find_file(file, extensions = EXTENSIONS)
      extensions.find { |extension|
        _file = file + extension
        return _file if File.exist?(_file)
      }
    end

  end

end
