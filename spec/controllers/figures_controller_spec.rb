require 'spec_helper'

describe FiguresController do
  let(:user) { create :user }
  let(:paper) do
    FactoryGirl.create(:paper, user: user)
  end

  before { sign_in user }

  describe "destroying the figure" do
    subject(:do_request) { delete :destroy, id: paper.figures.last.id, paper_id: paper.id }
    before(:each) do
      paper.figures.create! attachment: fixture_file_upload('yeti.tiff', 'image/tiff')
    end

    it "destroys the figure record" do
      expect {
        do_request
      }.to change{Figure.count}.by -1
    end
  end

  describe "POST 'create'" do
    let(:url) { "http://someawesomeurl.com" }
    it "causes the creation of the figure" do
      expect(DownloadFigure).to receive(:call).with(kind_of(Figure), url).and_return(Figure.new)
      post :create, format: "json", paper_id: paper.to_param, url: url
      expect(response).to be_success
    end
  end

  describe "PUT 'update_attachment'" do
    let(:url) { "http://someawesomeurl.com" }
    let(:figure) { paper.figures.create!(attachment: fixture_file_upload('yeti.tiff', 'image/tiff')) }
    it "calls DownloadFigure" do
      expect(DownloadFigure).to receive(:call).with(figure, url).and_return(figure)
      put :update_attachment, format: "json", id: figure.id, url: url
      expect(response).to be_success
    end
  end

  describe "PUT 'update'" do
    subject(:do_request) { patch :update, id: paper.figures.last.id, paper_id: paper.id, figure: {title: "new title", caption: "new caption"}, format: :json }
    before(:each) do
      paper.figures.create! attachment: fixture_file_upload('yeti.tiff', 'image/tiff')
    end

    it "allows updates for title and caption" do
      do_request

      figure = paper.figures.last
      expect(figure.caption).to eq("new caption")
      expect(figure.title).to eq("new title")
    end
  end
end
