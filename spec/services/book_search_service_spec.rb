require 'rails_helper'

RSpec.describe BookSearchService do
  describe '.search' do
    before do
      create(:book, title: 'Ruby Programming', author: 'John Doe', genre: 'Technology')
      create(:book, title: 'Python Basics', author: 'Jane Smith', genre: 'Technology')
      create(:book, title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', genre: 'Fiction')
      create(:book, title: 'To Kill a Mockingbird', author: 'Harper Lee', genre: 'Fiction')
    end

    it 'returns books matching the query in title' do
      result = BookSearchService.search('Ruby')
      expect(result.count).to eq(1)
      expect(result.first.title).to eq('Ruby Programming')
    end

    it 'returns books matching the query in author' do
      result = BookSearchService.search('Smith')
      expect(result.count).to eq(1)
      expect(result.first.author).to eq('Jane Smith')
    end

    it 'returns books matching the query in genre' do
      result = BookSearchService.search('Fiction')
      expect(result.count).to eq(2)
      expect(result.map(&:genre)).to all(eq('Fiction'))
    end

    it 'returns empty when no matches found' do
      result = BookSearchService.search('NonExistent')
      expect(result).to be_empty
    end
  end
end
