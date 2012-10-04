class SchoolClass < ActiveRecord::Base
  attr_accessible :description, :title, :user_id

  def self.search(search, page)
    paginate per_page: 10, page: page,
             conditions: ["title like ? and description LIKE ?", "%#{search}%", "%#{search}%"],
             order: 'title'
  end
end
