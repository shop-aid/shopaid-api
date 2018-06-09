require 'rails_helper'

RSpec.describe Cause, type: :model do
  # Reations
  it { should have_many(:donations) }
  it { should have_many(:targets) }
end
