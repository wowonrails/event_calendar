class EventSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :description,
             :periodicity,
             :start,
             :end

  def end
    object.start + object.duration.hour
  end
end
