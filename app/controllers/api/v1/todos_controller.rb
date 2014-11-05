class Api::V1::TodosController < ApplicationController
  def show
    render json: @todo
  end

  def index
    @todos = Todo.all
    render json: @todos, status: :ok
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo.as_json(include_token: false), status: :created
    else
      render json: {errors: @todo.errors}, status: :bad_request
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo, status: :ok
    else
      render json: {errors: @todo.errors}, status: :bad_request
    end
  end

  def destroy
    load_todo
    @todo.delete
  end

  private

  def load_todo
    @todo = Todo.find(params[:id])
  end

  # def restrict_access_to_voter
  #   unless @todo.token == params[:token]
  #     render nothing: true, status: :unauthorized
  #   end
  # end

  def todo_params
    params.permit(:title, :order, :completed, :id)
  end
end
