class Comment < ActiveRecord::Base
  validates :content, :author, :post, presence: true

  belongs_to :post, inverse_of: :comments 

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  belongs_to :parent,
    primary_key: :id,
    foreign_key: :parent_id,
    class_name: :Comment

  has_many :children,
    primary_key: :id,
    foreign_key: :parent_id,
    class_name: :Comment
end
