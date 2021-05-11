module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i[show destroy update] 

      def index
        posts = Post.order(created_at: :desc)
        render json: { data: posts }, status: :ok
      end

      def show
        render json: {data: @post}, status: :ok
      end

      def create
        post = Post.new(post_params)
        if post.save
          render json: { data: post }, status: :ok
        else
          render json: { data: post.errors }, status: :error
        end
      end

      def update
        if @post.update(post_params)
          render json: { data: @post }, status: :ok
        else
          render json: { data: @post.errors}, status: :ok
        end
      end

      def destroy
        @post.destroy!
        render json: { data: @post }
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
