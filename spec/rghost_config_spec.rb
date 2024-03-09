# frozen_string_literal: true

describe RGhost::Config do
  subject(:config) { described_class }
  let(:fake_which) { class_double("RGhost::Which", call: :ok) }
  let(:options) { {} }

  it "sets GS[:path] when executable is found" do
    allow(fake_which).to receive(:call).with("gs") { "/some/path/to/gs" }

    config.config_platform(which: fake_which, config_options: options)

    expect(options.fetch(:path)).to eq("/some/path/to/gs")
  end

  it "raises and error when executable cannot be found" do
    allow(fake_which).to receive(:call).with("gs") { nil }

    expect {
      config.config_platform(which: fake_which, config_options: options)
    }.to raise_error(/Ghostscript not found on your \$PATH/)
  end
end
