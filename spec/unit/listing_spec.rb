require 'listing'

RSpec.describe 'Listing' do
  it 'should have a name, price, description' do
    listing = Listing.new('London', 1000000, "Wonderful one-bedroom apartment with falling ceilings")

    expect(listing.name).to eq 'London'
    expect(listing.price).to eq 1000000
    expect(listing.description).to eq "Wonderful one-bedroom apartment with falling ceilings"
  end
end
