class PaperclipExample < ActiveRecord::Migration
  def change
    add_attachment :dogs, :avatar
    add_attachment :user, :avatar
  end
end
