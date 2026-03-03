require "test_helper"

class ContactTest < ActiveSupport::TestCase
  setup do
    @contact = contacts(:unread_contact)
  end

  # Validations
  test "valid contact" do
    assert @contact.valid?
  end

  test "requires name" do
    @contact.name = nil
    assert_not @contact.valid?
    assert_includes @contact.errors[:name], "can't be blank"
  end

  test "requires email" do
    @contact.email = nil
    assert_not @contact.valid?
    assert_includes @contact.errors[:email], "can't be blank"
  end

  test "requires message" do
    @contact.message = nil
    assert_not @contact.valid?
    assert_includes @contact.errors[:message], "can't be blank"
  end

  # Scopes
  test "unread scope returns only unread contacts" do
    unread = Contact.unread
    assert_includes unread, contacts(:unread_contact)
    assert_not_includes unread, contacts(:read_contact)
  end

  test "by_status scope filters by given status" do
    read = Contact.by_status("read")
    assert_includes read, contacts(:read_contact)
    assert_not_includes read, contacts(:unread_contact)
  end
end
