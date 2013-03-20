require 'helper'

describe Octokit::Agent do

  context "when unauthenticated" do
    before do
      @agent = Octokit.agent
    end

    it "fetches the root" do
      stub_get("/").
        to_return(json_response("root.json"))

      root = @agent.start.data
      expect(root.rels[:issues].href).to eq "https://api.github.com/issues"
    end

  end

end
