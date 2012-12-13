f = { "comp" => ["insert", "update"] }
puts f.to_s

f["comp"] << "delete"
puts f.to_s

g = f["comp"]
puts g.include?("delete") unless g.nil?
puts g.include?("append") unless g.nil?