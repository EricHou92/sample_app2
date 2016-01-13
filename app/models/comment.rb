class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :thing

    validates_presence_of :user_id
    validates_presence_of :thing_id
    validates_presence_of :rating
    validates_presence_of :content
end
