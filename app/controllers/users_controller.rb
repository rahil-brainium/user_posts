class UsersController < ApplicationController
  skip_before_filter :require_no_authentication
end
