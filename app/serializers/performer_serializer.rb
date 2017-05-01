class PerformerSerializer < ActiveModel::Serializer
  attributes :id,
             :artist_id,
             :artist_name,
             :artist_img,
             :show_id
            #  :show
end
