require_relative "core"
require_relative "bills"

g = Group.new
g.add "lyf"
g.add "szz"
g.add "zzj"

puts "#{g.members}"

bill = Bill.new "szz", 100, ["lyf", "zzj"]
g.apply_bill bill
puts "#{g.stats}"

bill = Bill.new "zzj", 50, ["lyf", "zzj", "szz"]
g.apply_bill bill
puts "#{g.stats}"

bill = SpecialBill.new "lyf", 30, ["lyf", "zzj", "szz"]
bill.add_part 3, ["lyf", "zzj"]
g.apply_bill bill
puts "#{g.stats}"

