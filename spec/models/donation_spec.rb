require 'rails_helper'

RSpec.describe Donation, type: :model do
  # Reations
  it { should belong_to(:user) }
  it { should belong_to(:cause) }
  it { should belong_to(:partner) }
end
