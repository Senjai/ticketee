class Ticket < ActiveRecord::Base
  searcher do
    label :tag, from: :tags, field: :name
  end

  before_create :associate_tags

  belongs_to :project
  belongs_to :user
  belongs_to :state

  has_many :assets
  has_many :comments

  has_and_belongs_to_many :tags

  validates :title,       presence: true
  validates :description, presence: true, length: { minimum: 10 }

  accepts_nested_attributes_for :assets

  attr_accessor :tag_names

  private

  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end
end
