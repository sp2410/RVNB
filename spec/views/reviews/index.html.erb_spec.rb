require 'rails_helper'

RSpec.describe "reviews/index", type: :view do
  before(:each) do
    assign(:reviews, [
      Review.create!(
        :accuracy => "Accuracy",
        :communication => "Communication",
        :cleanliness => "Cleanliness",
        :location => "Location",
        :checkin => "Checkin",
        :owners_behaviour => "Owners Behaviour",
        :valueformoney => "Valueformoney",
        :reviewerid => "Reviewerid"
      ),
      Review.create!(
        :accuracy => "Accuracy",
        :communication => "Communication",
        :cleanliness => "Cleanliness",
        :location => "Location",
        :checkin => "Checkin",
        :owners_behaviour => "Owners Behaviour",
        :valueformoney => "Valueformoney",
        :reviewerid => "Reviewerid"
      )
    ])
  end

  it "renders a list of reviews" do
    render
    assert_select "tr>td", :text => "Accuracy".to_s, :count => 2
    assert_select "tr>td", :text => "Communication".to_s, :count => 2
    assert_select "tr>td", :text => "Cleanliness".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Checkin".to_s, :count => 2
    assert_select "tr>td", :text => "Owners Behaviour".to_s, :count => 2
    assert_select "tr>td", :text => "Valueformoney".to_s, :count => 2
    assert_select "tr>td", :text => "Reviewerid".to_s, :count => 2
  end
end
