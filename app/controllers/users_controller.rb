class UsersController < ApplicationController

    get '/' do
        erb :index
    end

    get '/signup' do
        if logged_in?
            redirect '/tweets'
        end
        erb :'/users/create_user'
    end

    post '/signup' do
        user = User.new(params)
        if user.save
            session[:user_id] = user.id
            redirect '/tweets'
        end
        redirect '/signup'
    end

    get '/login' do
        if logged_in?
            redirect '/tweets'
        end
        erb :'/users/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        end
        redirect '/signup'
    end

    get '/logout' do
        if logged_in?
            session.delete(:user_id)
        end
        redirect '/login'
    end

    get '/users/:id' do
        @user = User.find(params[:id])
        erb :'users/show_user'
    end
end
