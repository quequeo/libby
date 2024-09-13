require 'rails_helper'

RSpec.describe Ability, type: :model do
  describe "User abilities" do
    subject(:ability) { Ability.new(user) }
    let(:user) { nil }

    context "when user is a librarian" do
      let(:user) { create(:user, :librarian) }

      it { is_expected.to be_able_to(:manage, Book) }
      it { is_expected.to be_able_to(:manage, Borrowing) }
    end

    context "when user is a member" do
      let(:user) { create(:user, role: :member) }
      let(:book) { create(:book) }
      let(:borrowing) { create(:borrowing, user: user, book: book) }

      it { is_expected.to be_able_to(:read, Book) }
      it { is_expected.to be_able_to(:create, Borrowing) }
      it { is_expected.to be_able_to(:read, borrowing) }
      it { is_expected.to be_able_to(:update, borrowing) }
      it { is_expected.not_to be_able_to(:manage, Book) }
    end
  end
end
