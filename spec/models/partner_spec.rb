require 'rails_helper'

RSpec.describe Partner, type: :model do
  # Reations
  it { should have_many(:donations) }
end
