class Post < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :image, presence: true

    has_attached_file :image, styles: { :medium => "640x" },
                      :storage => :s3,
                      :s3_credentials => {
                                          :bucket => ENV['AWS_BUCKET'],
                                          :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                                          :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                                          }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    has_many :comments, dependent: :destroy

end
