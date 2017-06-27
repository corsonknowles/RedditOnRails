class Post < ActiveRecord::Base
  validates :title, :author, presence: true

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs, inverse_of: :post

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments

  def top_level_comments
    self.comments.where(parent_id: nil)
  end

  def comments_by_parent_id
    hash = Hash.new { Array.new }
    self.comments.each do |comme|
      hash[comme.parent_id] << comme
    end
    @comments_by_parent_id = hash
  end
end
