class AddPledgeAmountToAnswers < ActiveRecord::Migration[7.1]
  def change
    add_column :answers, :pledge_amount, :decimal
  end
end
