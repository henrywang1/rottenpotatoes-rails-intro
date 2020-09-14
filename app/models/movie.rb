class Movie < ActiveRecord::Base
    def self.all_ratings
        ["G", "R", "PG-13","PG"]
    end
    def self.with_rating(ratings)
        self.where(rating: ratings)
    end
end
