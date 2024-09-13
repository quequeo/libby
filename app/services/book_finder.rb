class BookFinder
  def self.search(query, page: 1, per_page: 25)
    Book.search_by_attributes(query).paginate(page, per_page)
  end
end