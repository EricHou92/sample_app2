class Thing < ActiveRecord::Base
    belongs_to :user
    belongs_to :administrator
    has_many :collects
    has_many :comments
    has_and_belongs_to_many :users, :through => :collects
    has_and_belongs_to_many :users, :through => :comments

    validates_presence_of :user_id
    validates_length_of :title, :maximum => 20
    validates_inclusion_of :style, :in => [1, 2, 3, 4, 5, 6, 7]
    validates_inclusion_of :depreciation_rate, :in => [1, 2, 3, 4, 5, 6, 7, 8]
    validates_numericality_of :price

    
    def picture= (temp_picture)
        transaction do
            if temp_picture.size > 0
                picture_data = temp_picture.read
                picture_type = temp_picture.content_type.to_s
                picture_name = ('a'..'z').to_a.shuffle[0..16].join + '.' + picture_type[6..-1]
                picture = File.join(Rails.root.join("public").to_s, picture_name)
                File.open(picture, "wb") do |f|
                    f.write(picture_data)
                end
                self.picture_path = picture_name
                self.picture_type = temp_picture.content_type
            end
        end
    end
end
