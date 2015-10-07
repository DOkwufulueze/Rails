class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.string :option

      t.timestamps null: false
    end
  end
end
