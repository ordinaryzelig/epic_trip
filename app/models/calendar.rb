class Calendar < ActiveRecord::Base

  has_many :events, dependent: :destroy, order: :started_on

end
