class AddCauseToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :cause, index: true, foreign_key: true
  end
end
