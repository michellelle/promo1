class Users::RegistrationsController < Devise::RegistrationsController
    before_filter :select_plan, only: :new
    
    def create
        super do |resource|
            if params[:plan]
                resource.plan_id = params[:plan]
                resource.save
            end
        end
    end
end