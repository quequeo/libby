class Api::ApplicationController < ApplicationController
  include Api::Pagination
  include Api::Errorable
end
