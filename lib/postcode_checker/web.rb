# frozen_string_literal: true

module PostcodeChecker
  class Web < Sinatra::Base
    set :root, File.join(__dir__, 'www')
    set :views, (proc { File.join(root, 'views') })

    get '/' do
      erb :index
    end
  end
end
