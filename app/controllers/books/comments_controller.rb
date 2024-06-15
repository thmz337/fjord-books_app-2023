# frozen_string_literal: true

class Books::CommentsController < CommentsController
  before_action :set_commentable
  before_action :set_comment, only: %i[destroy]

  def create
    super('books/show')
  end
  
  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
