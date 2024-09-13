require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should have_many(:borrowings) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:genre) }
  it { should validate_presence_of(:isbn) }
  it { should validate_uniqueness_of(:isbn) }
end
