require 'rails_helper'

describe "Bugs" do

  let(:user) { FG.create(:user).user           }
  let(:repo) do
    zz = Repo.new(name: "aaa/bbb", type: "Repo::GitHub")
    zz.save(validate: false)
    zz
  end
  let(:bug)  { Bug.create(repo_id: repo.id, type: "Bug::GitHub")    }

  it "renders index" do

    hydrate(bug)
    visit "/bugs"
    expect(page).to_not be_nil
  end

  it "renders show" do
    hydrate(bug)
    visit "/bugs/#{bug.id}"
    expect(page).to_not be_nil
  end

  it "takes a bid" do #.
    login_as(user, :scope => :user)
    hydrate(bug)
    expect(Bid.count).to eq(0)
    expect(Bug.count).to eq(1)

    visit "/bugs"
    click_on "Bid"
    click_on "Create Create"

    expect(Bid.count).to eq(1)
  end
end
