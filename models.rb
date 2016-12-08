class User < ActiveRecord::Base
  has_many :rooms

  has_one :blog
  has_many :posts, through: :blog

  def full_name
    first_name + ' ' + last_name
  end
end

class Post < ActiveRecord::Base
  belongs_to :blog
end

class Room < ActiveRecord::Base
  belongs_to :user
end

class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts
end
