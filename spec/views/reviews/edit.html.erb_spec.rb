require 'rails_helper'

RSpec.describe "reviews/edit", type: :view do
  before(:each) do
    @review = assign(:review, Review.create!(
      :accuracy => "MyString",
      :communication => "MyString",
      :cleanliness => "MyString",
      :location => "MyString",
      :checkin => "MyString",
      :owners_behaviour => "MyString",
      :valueformoney => "MyString",
      :reviewerid => "MyString"
    ))
  end

  it "renders the edit review form" do
    render

    assert_select "form[action=?][method=?]", review_path(@review), "post" do

      assert_select "input[name=?]", "review[accuracy]"

      assert_select "input[name=?]", "review[communication]"

      assert_select "input[name=?]", "review[cleanliness]"

      assert_select "input[name=?]", "review[location]"

      assert_select "input[name=?]", "review[checkin]"

      assert_select "input[name=?]", "review[owners_behaviour]"

      assert_select "input[name=?]", "review[valueformoney]"

      assert_select "input[name=?]", "review[reviewerid]"
    end
  end
end
