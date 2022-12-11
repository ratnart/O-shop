class ApplicationController < ActionController::Base
    add_flash_types :from, :to
    private
		def is_login?
			return	session[:logged_in]==true
		end
		def must_be_logged_in
			if is_login?
				return true
			else
				redirect_to '/login', notice: 'You must login before access that page'
			end
		end
        def check_seller
            if session[:user_type]==1
                redirect_to '/main', notice: 'You do not have permission to access that page'
            else
                return true
            end
        end
        def check_buyer
            if session[:user_type]==2
                redirect_to '/main', notice: 'You do not have permission to access that page'
            else
                return true
            end
        end
end
