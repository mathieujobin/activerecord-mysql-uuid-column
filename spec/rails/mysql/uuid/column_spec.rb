require "spec_helper"

describe Rails::Mysql::Uuid::Column do
  it "has a version number" do
    expect(Rails::Mysql::Uuid::Column::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(false).to eq(true)
  end
end
