class Collect < ActiveRecord::Base
    belongs_to :user
    belongs_to :thing

    validates_presence_of :user_id
    validates_presence_of :thing_id
end
