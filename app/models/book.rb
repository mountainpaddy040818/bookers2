class Book < ApplicationRecord
  belongs_to :user

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

  validates :title, presence: true
  validates :body, presence: true,
            length: {maximum: 200}

end
