class PagesController < ApplicationController
    def home
        @basic_plan = Plan.find(1)
    end
    
    def about
    end
    
    def faqs
    end
end