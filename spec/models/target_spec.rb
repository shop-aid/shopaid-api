require 'rails_helper'

RSpec.describe Target, type: :model do
  # Reations
  it { should belong_to(:user) }
  it { should belong_to(:cause) }
end
