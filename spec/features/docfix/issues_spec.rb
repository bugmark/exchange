require 'rails_helper'

describe "Issues" do

  let(:user) { FG.create(:user).user                                 }
  let(:repo) { FG.create(:repo).repo                                 }
  let(:bug)  { Bug.create(stm_repo_id: repo.id, type: "Bug::GitHub") }

  it "renders index", USE_VCR do
    hydrate(bug)
    visit "/docfix/issues"
    expect(page).to_not be_nil
  end

  it "renders show", USE_VCR do
    hydrate(bug)
    visit "/docfix/issues/#{bug.id}"
    expect(page).to_not be_nil #.
  end
end
