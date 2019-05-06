require 'rails_helper'

RSpec.describe Article, type: :model do

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:title).is_at_least(5) }
  it { should validate_length_of(:body).is_at_least(5) }
  it { should have_many :images }

end