class FigureSerializer < ActiveModel::Serializer
  attributes :id,
             :filename,
             :alt,
             :src,
             :status,
             :title,
             :caption,
             :detail_src,
             :preview_src,
             :created_at

  has_one :paper, embed: :id
end
