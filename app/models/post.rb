class Post < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validates :image, presence: true
    has_attached_file :image,
          styles: { :medium => "640x" },
          :storage => :s3,
          :bucket  => ENV['AWS_S3_BUCKET']

    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    paginates_per 10

    has_many :comments, dependent: :destroy

end
