RSpec.describe "`ras_pi_config spi` command", type: :cli do
  it "executes `ras_pi_config help spi` command successfully" do
    output = `ras_pi_config help spi`
    expected_output = <<-OUT
Usage:
  ras_pi_config spi ACTION

Options:
  -h, [--help], [--no-help]  # Display usage information

Command description...
    OUT

    expect(output).to eq(expected_output)
  end
end
