class Ticket < ActiveRecord::Base
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

  scope :with_tags,            ->() {joins(:tags)}
  scope :with_states,          ->() {joins(:state)}
  scope :with_tags_and_states, ->() {with_tags.with_states}

  def self.search(params)
    items = params.split(" ")
    pieces = {}
    items.each do |i|
      next unless i.include?(":")
      x, y = i.split(":")
      pieces[x] ||= []
      pieces[x] << y unless pieces[x].include?(y)
    end

    if pieces.has_key?("tag") && pieces.has_key?("state")
      return self.with_tags_and_states.where("`tags`.`name` in (?)", pieces["tag"])
                                      .where("`states`.`name` in (?)", pieces["state"])
    elsif pieces.has_key?("tag")
      return self.with_tags.where("`tags`.`name` in (?)", pieces["tag"])
    elsif pieces.has_key?("state")
      return self.with_states.where("`states`.`name` in (?)", pieces["state"])
    else
      return self.all
    end
  end

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
