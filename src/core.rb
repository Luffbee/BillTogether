class AccountNotInBill < StandardError
  attr_reader :account, :bill
  def initialize(id, bill)
    @id = id
    @bill = bill
  end
end

class AccountNotPayer < StandardError
  attr_reader :account, :bill
  def initialize(id, bill)
    @id = id
    @bill = bill
  end
end

class Account
  attr_reader :id, :money
  def initialize(id)
    @id = id
    @money = 0.0
  end

  def pay(bill)
    if @id != bill.payer
      raise AccountNotPayer.new @id, bill
    else
      @money += bill.money
    end
  end

  def benefit(bill)
    if not bill.benes.has_key?(@id)
      raise AccountNotInBill.new @id, bill
    else
      @money -= bill.benes[@id]
    end
  end

  def clear()
    @money = 0.0
  end
end

class Bill
  attr_reader :payer, :money, :benes
  def initialize(payer, money, benes)
    @payer = payer
    @money = Float money
    @benes = {}
    benes.each do
      |id|
      if @benes.has_key? id
        raise StandardError.new "Duplicate beneficiary '#{id}'!"
      else
        @benes[id] = @money / benes.size
      end
    end
  end
end

class Group
  def initialize()
    @members = {}
  end

  def add(id)
    if @members.has_key? id
      raise StardardError.new "Account already in this group!"
    else
      @members[id] = Account.new id
    end
  end

  def del(id)
    if not @member.has_key? id
      raise StardardError.new "Account not in this group!"
    else
      @member.delete id
    end
  end

  def members()
    @members.keys
  end

  def stats()
    @members.transform_values {|acc| acc.money}
  end

  def clear()
    @members.each {|id, acc| acc.clear}
  end

  def apply_bill(bill)
    # Check bill validation.
    if not @members.has_key? bill.payer
      raise StandardError.new "Payer '#{bill.payer}' is not in this group #{self.members}!"
    else
      bill.benes.keys.each do
        |id|
        if not @members.has_key? id
          raise StandardError.new "Account '#{id}' is not in this group #{self.members}!" 
        end
      end
    end
    # Good bill
    @members[bill.payer].pay bill
    bill.benes.keys.each {|id| @members[id].benefit bill}
  end
end
