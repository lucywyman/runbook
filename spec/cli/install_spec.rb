require "spec_helper"

RSpec.describe "runbook install", type: :aruba do
  let(:command) { "runbook install" }
  let(:installation_output) {
    [
      "create  Runbookfile",
      "create  runbooks",
      "create  lib/runbook",
      "create  lib/runbook/extensions",
      "create  lib/runbook/generators",
      "Runbook was successfully installed",
      "Add runbooks to the `runbooks` directory.",
      "Add shared code to `lib/runbook`.",
      "Execute runbooks using `bundle exec runbook exec <RUNBOOK_PATH>",
      "from your project root.",
    ]
  }

  before(:each) { run_command(command) }

  it "creates the Runbookfile and directory structure" do
    installation_output.each do |output|
      expect(last_command_started).to have_output(/#{output}/)
    end

    expect(file?("Runbookfile")).to be_truthy
    expect(directory?("runbooks")).to be_truthy
    expect(directory?("lib/runbook")).to be_truthy
    expect(directory?("lib/runbook/extensions")).to be_truthy
    expect(directory?("lib/runbook/generators")).to be_truthy
  end

  context "when -p is passed" do
    let(:command) { "runbook install -p" }

    it "does not create the files" do
      installation_output.each do |output|
        expect(last_command_started).to have_output(/#{output}/)
      end

      expect(file?("Runbookfile")).to be_falsey
      expect(directory?("runbooks")).to be_falsey
      expect(directory?("lib/runbook")).to be_falsey
      expect(directory?("lib/runbook/extensions")).to be_falsey
      expect(directory?("lib/runbook/generators")).to be_falsey
    end
  end
end
