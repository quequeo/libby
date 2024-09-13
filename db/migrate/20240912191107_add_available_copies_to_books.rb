class AddAvailableCopiesToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :available_copies, :integer
  end
end
