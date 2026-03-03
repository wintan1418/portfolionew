module Admin
  class ContactsController < BaseController
    def index
      @contacts = Contact.order(created_at: :desc)
    end

    def show
      @contact = Contact.find(params[:id])
      @contact.update(status: "read") if @contact.status == "unread"
    end

    def update
      @contact = Contact.find(params[:id])
      @contact.update(status: params[:contact][:status])
      redirect_to admin_contacts_path, notice: "Contact updated."
    end

    def destroy
      Contact.find(params[:id]).destroy
      redirect_to admin_contacts_path, notice: "Contact deleted."
    end

    def mark_read
      Contact.find(params[:id]).update(status: "read")
      redirect_to admin_contacts_path, notice: "Marked as read."
    end
  end
end
