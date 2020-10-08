require_relative '../lib/dark_trader'

describe "program" do
  it "no erreur & no nil" do
    expect(c_names(nil)).to eq("nil detected")
    expect(c_names(Bitcoin)).to eq("ok")
    expect(c_names(Polkadot)).to eq("ok")
    expect(c_names(Cosmos)).to eq("ok")
  end
end 


# describe "array consistency" do
#   it "returns 2-3 cryptomonnaies" do
#     expect(add(0,0)).to eq(Bitcon)
#   end
# end 

# describe "array" do
#   it "size ok" do
#     expect(c_values(0,0)).to eq(200)
#   end
# end 