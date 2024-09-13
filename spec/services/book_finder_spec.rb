require 'rails_helper'

RSpec.describe BookFinder do
  describe '#search' do
    let!(:football_book)      { create(:book, title: 'Book 1 Football', author: 'Pedro', genre: 'Technology') }
    let!(:john_book)          { create(:book, title: 'Book 2', author: 'John', genre: 'Technology') }
    let!(:fiction_book)       { create(:book, title: 'Book 3', author: 'Pablo', genre: 'Fiction') }
    let!(:other_fiction_book) { create(:book, title: 'Book 4', author: 'María', genre: 'Fiction') }

    it 'returns books matching the query in title' do
      result = BookFinder.search('Football')
      expect(result.count).to eq(1)
      expect(result.first).to eq(football_book)
    end

    it 'returns books matching the query in author' do
      result = BookFinder.search('John')
      expect(result.count).to eq(1)
      expect(result.first).to eq(john_book)
    end

    it 'returns books matching the query in genre' do
      result = BookFinder.search('Fiction')
      expect(result.count).to eq(2)
      expect(result).to include(fiction_book, other_fiction_book)
    end

    it 'returns empty when no matches found' do
      result = BookFinder.search('NonExistent')
      expect(result).to be_empty
    end

    it 'paginates the results' do
      result = BookFinder.search('', page: 1, per_page: 2)
      expect(result.count).to eq(2)
      expect(result.total_pages).to eq(2)
    end

    it 'is case insensitive' do
      result = BookFinder.search('foot')
      expect(result.count).to eq(1)
      expect(result.first).to eq(football_book)
    end
  end
end