require 'rails_helper'

describe PaperConversionsPolicy do
  let(:policy) { described_class.new(current_user: user, paper: paper) }
  let(:user) { FactoryGirl.create(:user) }
  let(:paper) { FactoryGirl.create(:paper) }

  context "relationships" do
    it "belongs to PapersPolicy" do
      expect(described_class < PapersPolicy).to eq true
    end
  end

  context "site admin" do
    let(:user) { FactoryGirl.create(:user, :site_admin) }

    include_examples "can export paper"
  end

  context "authors" do
    let(:paper) { FactoryGirl.create(:paper, creator: user) }

    include_examples "can export paper"
  end

  context "paper admins" do
    before do
      create(:paper_role, :admin, user: user, paper: paper)
    end

    include_examples "can export paper"
  end

  context "paper editors" do
    before do
      create(:paper_role, :editor, user: user, paper: paper)
    end

    include_examples "can export paper"
  end

  context "paper reviewers" do
    before do
      create(:paper_role, :reviewer, user: user, paper: paper)
    end

    include_examples "can export paper"
  end

  context "paper participant" do
    before do
      create(:paper_role, :participant, user: user, paper: paper)
    end

    include_examples "can export paper"
  end

  context "paper collaborators" do
    before do
      create(:paper_role, :collaborator, user: user, paper: paper)
    end

    include_examples "can export paper"
  end

  context "non-associated user" do
    include_examples "cannot export paper"
  end

  context "admin on different journal" do
    let(:journal) { FactoryGirl.create(:journal) }
    let(:user) do
      FactoryGirl.create(:user,
                         roles: [ FactoryGirl.create(:role,
                                                     :admin,
                                                     journal: journal) ],)
    end

    include_examples "cannot export paper"
  end
end
