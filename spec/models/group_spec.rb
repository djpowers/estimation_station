require 'spec_helper'

describe Group do

  let(:blanks){ [nil, ''] }

  describe 'validation' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :user }

    it { should belong_to :user }
  end

  describe 'database' do
    it { should have_db_column(:title).of_type(:string).with_options(null: false) }
    it { should have_db_column(:user_id).of_type(:integer).with_options(null: false) }
  end

end
