require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhoneEntry do
  before(:each) do
    @valid_attributes = {
      :old_ddd => 51,
      :old_number => 81238153,
      :new_ddd => 51,
      :new_number => 82222434,
      :name => 'Fulano de Tal'
    }
  end

  it "should create a new instance given valid attributes" do
    PhoneEntry.create!(@valid_attributes)
  end

  it "should validate old number" do
    @valid_attributes.delete(:old_ddd)
    @valid_attributes.delete(:old_number)

    entry = PhoneEntry.new(@valid_attributes)

    entry.save.should be_false
    entry.errors.length.should eql(2)
  end

  it "should validate new number" do
    @valid_attributes.delete(:new_ddd)
    @valid_attributes.delete(:new_number)

    entry = PhoneEntry.new(@valid_attributes)

    entry.save.should be_false
    entry.errors.length.should eql(2)
  end

  it "should validate name" do
    @valid_attributes.delete(:name)

    entry = PhoneEntry.new(@valid_attributes)

    entry.save.should be_false
    entry.errors.length.should eql(1)
  end

  it "should find new number based on old number" do
    PhoneEntry.create!(@valid_attributes)

    entry = PhoneEntry.find_new_number(55, 12345678)
    entry.should be_nil

    entry = PhoneEntry.find_new_number(@valid_attributes[:old_ddd], @valid_attributes[:old_number])
    entry.old_ddd.should eql(@valid_attributes[:old_ddd])
    entry.old_number.should eql(@valid_attributes[:old_number])
    entry.new_ddd.should eql(@valid_attributes[:new_ddd])
    entry.new_number.should eql(@valid_attributes[:new_number])
    entry.name.should eql(@valid_attributes[:name])
  end
end
