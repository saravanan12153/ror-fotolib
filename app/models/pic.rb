class Pic < ActiveRecord::Base
    belongs_to :user
    has_attached_file :image

    validates_attachment_content_type :image,
                                      content_type:  /^image\/(png|gif|jpeg)/,
                                      message: "Only images allowed"

    validates_presence_of :title
    validates_presence_of :user_id
    validates :image, attachment_presence: true
end
