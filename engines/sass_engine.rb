class SassEngine < Sinatra::Base

  set :views, File.dirname(__FILE__)    + '/../assets/sass'

  get '/stylesheets/*.css' do
    filename = params[:splat].first
    sass filename.to_sym
  end

end
