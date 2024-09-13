class BookSearchService
  def initialize(query, page, per_page)
    @query = query
    @page = page
    @per_page = per_page
  end

  def self.search(query, page: 1, per_page: 25)
    new(query, page, per_page).search
  end

  def search
    Book.where("title ILIKE :query OR author ILIKE :query OR genre ILIKE :query", query: "%#{@query}%")
        .page(@page)
        .per(@per_page)
  end
end
