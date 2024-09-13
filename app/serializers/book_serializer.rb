class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :genre, :isbn, :total_copies, :available_copies

  def available_copies
    object.available_copies
  end
end
