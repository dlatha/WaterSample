class CreateSamples < ActiveRecord::Migration
  def change
    create_table :samples do |t|
      t.string :location
      t.float :chloroform
      t.float :bromoform
      t.float :chlorodibromide
      t.float :dichlorobromide

      t.timestamps
    end
  end
end
