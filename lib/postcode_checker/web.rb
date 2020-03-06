# frozen_string_literal: true

module PostcodeChecker
  class Web < Sinatra::Base
    set :root, File.join(__dir__, 'www')
    set :views, (proc { File.join(root, 'views') })

    get '/' do
      erb :form, layout: :layout
    end

    post '/check' do
      result = AccessControlService.call(
        postcode_string: params[:postcode],
        whitelist_file_path: whitelist_file_path
      )
      erb :result, layout: :layout, locals: { result: result }
    end

    private

    def whitelist_file_path
      File.join(__dir__, '../../config', 'whitelist.yml')
    end
  end
end
