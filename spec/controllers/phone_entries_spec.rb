require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhoneEntriesController, "test new phone entry" do

  before(:each) do
    @phone_entry = mock_model(PhoneEntry, { :old_ddd => nil, :old_number => nil, :new_ddd => nil, :new_number => nil, :name => nil })
    PhoneEntry.stub!(:new).and_return(@phone_entry)
  end

  it "should new phone entry" do
    PhoneEntry.should_receive(:new)
    get :new
  end

  it "should assign phone entry" do
    get :new
    assigns(:phone_entry).should == @phone_entry
  end
end

describe PhoneEntriesController, "test with VALID phone entry" do

  before(:each) do
    @phone_entry = mock_model(PhoneEntry, {
      :save => true,
      :name => "Fulano de Tal",
      :old_ddd => 51,
      :old_number => 81518930,
      :new_ddd => 51,
      :new_number => 81238153
    })

    PhoneEntry.stub!(:new).and_return(@phone_entry)
  end

  def do_create
    post :create, :phone_entry => { "name" => "Fulano de Tal", "old_ddd" => 51, "old_number" => "8151.8930", "new_ddd" => 51, "new_number" => "8123-8153" }
  end

  it "should create the phone entry" do
    PhoneEntry.should_receive(:new).with("name" => "Fulano de Tal", "old_ddd" => 51, "old_number" => "8151.8930", "new_ddd" => 51, "new_number" => "8123-8153").and_return(@phone_entry)
    do_create
  end

  it "should save the phone entry" do
    @phone_entry.should_receive(:save).and_return(true)
    do_create
  end

  it "should flash notice" do
    do_create
    flash[:notice].should == 'Novo número salvo com sucesso'
  end

  it "should redirect to index path" do
    do_create
    response.should be_redirect
  end
end

describe PhoneEntriesController, "test with INVALID phone entry" do

  before(:each) do
    @phone_entry = mock_model(PhoneEntry, { :save => false, :old_number => "8151.8930", :new_number => "8123-8153" })
    PhoneEntry.stub!(:new).and_return(@phone_entry)
  end

  def do_create
    post :create, :phone_entry => { "old_number" => "8151.8930", "new_number" => "8123-8153" }
  end

  it "should create the phone entry" do
    PhoneEntry.should_receive(:new).with("old_number" => "8151.8930", "new_number" => "8123-8153").and_return(@phone_entry)
    do_create
  end

  it "should save the phone entry" do
    @phone_entry.should_receive(:save).and_return(false)
    do_create
  end

  it "should assign phone entry" do
    do_create
    assigns(:phone_entry).should == @phone_entry
  end

  it "should success" do
    do_create
    response.should be_success
  end

  it "should re-render form new" do
    do_create
    response.should render_template(:new)
  end
end

describe PhoneEntriesController, "test search for new number" do

  def do_search
    post :search, :old_ddd => 51, :old_number => 99999999
  end

  it "should found a new number" do
    @phone_entry = mock_model(PhoneEntry)
    PhoneEntry.should_receive(:find_new_number).with("51", "99999999").and_return(@phone_entry)
    do_search
  end

  it "should not found a new number" do
    PhoneEntry.should_receive(:find_new_number).with("51", "99999999").and_return(nil)
    do_search
  end

  it "should redirect to index path" do
    do_search
    response.should be_redirect
  end
end
