class Poster < ApplicationRecord
  validates :link, presence: true
  validates :link, format:{ with: URL = %r{\A((http|https):\/\/)?[\w]+([\-\.]{1}[\w]+)*\.[\w]{2,25}(:[0-9]{1,5})?(\/.*)?\z}, message: "link not valid" }
end
