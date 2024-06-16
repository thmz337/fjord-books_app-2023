# frozen_string_literal: true

class Books::CommentsController < CommentsController
  def loaded_view = 'books/show'

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
