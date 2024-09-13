require 'rails_helper'

RSpec.describe BookSerializer do
  let(:book) { create(:book, title: 'Test Book', author: 'John Doe', genre: 'Fiction', isbn: '1234567890') }
  let(:serializer) { BookSerializer.new(book) }
  let(:serialization) { JSON.parse(serializer.to_json) }

  it 'includes the expected attributes' do
    expect(serialization.keys).to match_array([ 'id', 'title', 'author', 'genre', 'isbn', 'available_copies', 'total_copies' ])
  end

  it 'serializes the attributes correctly' do
    expect(serialization['id']).to eq(book.id)
    expect(serialization['title']).to eq('Test Book')
    expect(serialization['author']).to eq('John Doe')
    expect(serialization['genre']).to eq('Fiction')
    expect(serialization['isbn']).to eq('1234567890')
  end
end
