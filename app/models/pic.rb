class Pic < ActiveRecord::Base
    belongs_to :user
    has_attached_file :image

    validates_presence_of :title
    validates_presence_of :user_id
    validates_presence_of :image
end
