class SeasonSerializer < ActiveModel::Serializer
  attributes :title, :plot
  
  ##RELATIONS
  has_many :episodes, serializer: EpisodeSerializer


  def episodes
    object.episodes.order_by_num_episode
  end

end
