class PaperclipExample < ActiveRecord::Migration
  def change
    add_attachment :dogs, :avatar
  end
end
