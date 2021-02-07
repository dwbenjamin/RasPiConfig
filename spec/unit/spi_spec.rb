require 'RasPiConfig/commands/spi'

RSpec.describe RasPiConfig::Commands::Spi do
  it "executes `spi` command successfully" do
    output = StringIO.new
    action = nil
    options = {}
    command = RasPiConfig::Commands::Spi.new(action, options)

    command.execute(output: output)

    expect(output.string).to eq("OK\n")
  end
end
