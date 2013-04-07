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

  context "when basic authenticated" do

    before do
      @agent = Octokit::Client.new(:login => 'sferik', :password => 'il0veruby').agent
      stub_get("https://sferik:il0veruby@api.github.com/").
        to_return(json_response("root.json"))
    end

    it "fetches the root" do
      root = @agent.start.data
      expect(root.rels[:issues].href).to eq "https://api.github.com/issues"
    end

    it "fetches the current user rel" do
      stub_get("https://sferik:il0veruby@api.github.com/user").
        to_return(json_response("user.json"))
      root = @agent.start.data
      user = root.rels[:current_user].get.data

      expect(user.login).to eq 'sferik'

    end
  end

  context "when using an access token" do

    before do
      @agent = Octokit::Client.new(:oauth_token => '1234567890').agent
      stub_get("/").
        with(:headers => {'Authorization' => 'token 1234567890'}).
        to_return(json_response("root.json"))
    end

    it "fetches the root" do
      root = @agent.start.data
      expect(root.rels[:issues].href).to eq "https://api.github.com/issues"
    end

    it "fetches the current user rel" do
      stub_get("/user").
        with(:headers => {'Authorization' => 'token 1234567890'}).
        to_return(json_response("user.json"))
      root = @agent.start.data
      user = root.rels[:current_user].get.data

      expect(user.login).to eq 'sferik'

    end
  end
end
