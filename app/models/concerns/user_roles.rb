module UserRoles
  extend ActiveSupport::Concern

  included do
    enum :role, {:member=>0, :librarian=>1}
  end

  def librarian?
    role == 'librarian'
  end

  def member?
    role == 'member'
  end
end