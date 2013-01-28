class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.float :factor1
      t.float :factor2
      t.float :factor3
      t.float :factor4

      t.timestamps
    end
  end
end
