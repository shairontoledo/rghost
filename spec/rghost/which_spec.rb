# frozen_string_literal: true

RSpec.describe RGhost::Which do
  subject(:which) { described_class.new(env: fake_env) }
  let(:fake_env) { {"PATH" => path.join(File::PATH_SEPARATOR)} }
  let(:path) { ["/tmp/fake_dir"] }
  let(:project_root_dir) { Pathname(__dir__).join("../..") }
  let(:fixture_path) { project_root_dir.join("spec/fixtures").to_path }

  it "finds the executable when it exists on the first entry in $PATH" do
    path.prepend(fixture_path)

    expect(which.call("sweet")).to eq(project_root_dir.join("spec/fixtures/sweet").to_path)
  end

  it "does not find the executable when the file does not have execute permissions" do
    path.prepend(fixture_path)

    expect(which.call("sweet_non_exe")).to be_nil
  end

  it "finds the executable when it exists on a middle entry in $PATH" do
    path.prepend(fixture_path)
    path.prepend("/tmp/some/other/path")

    expect(which.call("sweet")).to eq(project_root_dir.join("spec/fixtures/sweet").to_path)
  end

  it "finds the executable when it exists on the last entry in $PATH" do
    path.prepend("/tmp/some/other/path")
    path.append(fixture_path)

    expect(which.call("sweet")).to eq(project_root_dir.join("spec/fixtures/sweet").to_path)
  end

  it "does not find the executable when the file is not in $PATH" do
    expect(which.call("sweet")).to be_nil
  end

  it "finds the executable when an absolute path is given" do
    absolute_path = project_root_dir.join("spec/fixtures/sweet").to_path

    expect(which.call(absolute_path)).to eq(absolute_path)
  end

  context "on Windows" do
    before do
      path.prepend(fixture_path)

      fake_env["PATHEXT"] = ".exe;.bat;.cmd"
    end

    it "finds the executable with the extensions defined by $PATHEXT" do
      expect(which.call("sweet_win")).to eq(project_root_dir.join("spec/fixtures/sweet_win.bat").to_path)
    end
  end
end
