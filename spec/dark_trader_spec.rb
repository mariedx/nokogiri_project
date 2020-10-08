require_relative '../lib/dark_trader'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))   

describe "c_hash" do
  it "no erreur & no nil" do
      expect(c_hash(page)).not_to be_empty 
  end
end 



















# describe "array consistency" do
#   it "returns 2-3 cryptomonnaies" do
#     expect(add(0,0)).to eq(Bitcon)
#   end
# end 

# describe "array" do
#   it "size ok" do
#     expect(5).to be > 200
#   end
# end 

# describe "hash " do
#   it "runs" do
#   expect(c_hash(Bitcoin, $).with(hash_including(a: 1))