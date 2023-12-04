class AddPledgeAmountToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :pledge_amount, :decimal
  end
end
