require_relative "core"

class SpecialBill < Bill
  def add_part(money, part_members)
    # These money only benefits part_members.
    part_members.each do
      |id|
      if not @benes.has_key? id
        raise StandardError.new "Part member '#{id}' is not a beneficiary!"
      end
    end
    money = Float money
    @benes.transform_values! {|v| v - money / @benes.size}
    part_members.each {|id| @benes[id] += money / part_members.size}
  end
end
