class AddNameAndSelfIntroductionToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :self_introduction, :text
  end
end