class CreatePlosAuthor < ActiveRecord::Migration
  def change
    create_table :plos_authors_plos_authors do |t|
      t.references :plos_authors_task
      t.string   :middle_initial
      t.string   :email
      t.string   :department
      t.string   :title
      t.boolean  :corresponding,         default: false, null: false
      t.boolean  :deceased,              default: false, null: false
      t.string   :affiliation
      t.string   :secondary_affiliation
      t.timestamps
    end

    change_table :authors do |t|
      t.actable
    end
  end
end
