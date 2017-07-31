class Post < ActiveRecord::Base
    def self.search(query)
        self.where("title || content LIKE ?","%#{query}%")
    end
end
