class Account < ApplicationRecord
  validates :username, inclusion: {in: ['rchildress'], message: "Only my mom can login"}
  has_secure_password
end
