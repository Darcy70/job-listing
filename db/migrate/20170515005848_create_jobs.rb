class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.string :contact_email
      t.integer :wage_lower_bound
      t.integer :wage_upper_bound
      t.boolean :is_hidden

      t.timestamps
    end
  end
end
