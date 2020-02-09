class TweetsController < ApplicationController

    get '/tweets' do
        if !logged_in?
            redirect '/login'
        end
        @user = current_user
        @tweets = Tweet.all
        erb :'/tweets/tweets'
    end

    get '/tweets/new' do
        if !logged_in?
            redirect '/login'
        end
        erb :'/tweets/new_tweet'
    end

    get '/tweets/:id' do
        @tweet = Tweet.find(params[:id])
        if !logged_in?
            redirect '/login'
        end
        erb :'/tweets/show_tweet'
    end

    post '/tweets' do
        tweet = Tweet.new(content: params[:content], user_id: current_user.id)

        if tweet.save
            redirect "/tweets/#{tweet.id}"
        end
        redirect '/tweets/new'
    end

    get '/tweets/:id/edit' do
        if !logged_in?
            redirect '/login'
        end
        @tweet = Tweet.find(params[:id])
        erb :'/tweets/edit_tweet'
    end

    patch '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if tweet.user_id != current_user.id
            redirect "/tweets/#{params[:id]}/edit"
        elsif params[:content] == ""
            redirect "/tweets/#{tweet.id}/edit"
        end
        tweet.update(content: params[:content])
        redirect "/tweets/#{tweet.id}"
    end

    delete '/tweets/:id' do
        tweet = Tweet.find(params[:id])
        if tweet.user_id == current_user.id
            tweet.delete
            redirect '/tweets'
        end
        redirect '/login'
    end
end
