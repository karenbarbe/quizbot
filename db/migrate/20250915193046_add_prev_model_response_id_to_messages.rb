class AddPrevModelResponseIdToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :prev_model_response_id, :string
  end
end
