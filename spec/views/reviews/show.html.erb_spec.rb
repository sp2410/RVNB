require 'rails_helper'

RSpec.describe "reviews/show", type: :view do
  before(:each) do
    @review = assign(:review, Review.create!(
      :accuracy => "Accuracy",
      :communication => "Communication",
      :cleanliness => "Cleanliness",
      :location => "Location",
      :checkin => "Checkin",
      :owners_behaviour => "Owners Behaviour",
      :valueformoney => "Valueformoney",
      :reviewerid => "Reviewerid"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Accuracy/)
    expect(rendered).to match(/Communication/)
    expect(rendered).to match(/Cleanliness/)
    expect(rendered).to match(/Location/)
    expect(rendered).to match(/Checkin/)
    expect(rendered).to match(/Owners Behaviour/)
    expect(rendered).to match(/Valueformoney/)
    expect(rendered).to match(/Reviewerid/)
  end
end
