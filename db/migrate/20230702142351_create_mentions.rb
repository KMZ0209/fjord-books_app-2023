class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.integer :mentioning_report_id
      t.integer :mentioned_report_id
      t.references :mentioning_report, foreign_key:{ to_table: :reports } , null: false
      t.references :mentioned_report, foreign_key:{ to_table: :reports } , null: false
      t.index %i[mentioned_report_id mentioning_report_id], unique: true

      t.timestamps

    end
  end
end
