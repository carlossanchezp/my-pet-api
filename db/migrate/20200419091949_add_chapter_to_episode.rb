class AddChapterToEpisode < ActiveRecord::Migration[6.0]
  def change
    add_column :episodes, :num_episode, :integer
  end
end
