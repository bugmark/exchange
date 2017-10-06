require 'rails_helper'

describe "Bugs" do

  let(:user) { FG.create(:user).user           }
  let(:repo) { FG.create(:repo).repo           }
  let(:bug)  { Bug.create(repo_id: repo.id, type: "Bug::GitHub")    }

  it "renders index", USE_VCR do
    hydrate(bug)
    visit "/core/bugs"
    expect(page).to_not be_nil
  end

  it "renders show", USE_VCR do
    hydrate(bug)
    visit "/core/bugs/#{bug.id}"
    expect(page).to_not be_nil
  end

  # TODO: fixme
  # it "takes a bid", USE_VCR do
  #   login_as(user, :scope => :user)
  #   hydrate(bug)
  #   expect(Bid.count).to eq(0)
  #   expect(Bug.count).to eq(1)
  #
  #   visit "/core/bugs"
  #   click_on "Bid"
  #   click_on "Create Create"
  #
  #   expect(Bid.count).to eq(1)
  # end
end
