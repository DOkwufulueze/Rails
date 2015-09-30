module CountAccess 
  extend ActiveSupport::Concern

  private

    def set_counter
      if session[:counter].nil?
        session[:counter] = 1
      else
        session[:counter] += 1
      end

      @count = session[:counter]
    end
end

