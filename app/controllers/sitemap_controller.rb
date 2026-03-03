class SitemapController < ApplicationController
  allow_unauthenticated_access

  def index
    respond_to do |format|
      format.xml { head :ok }
    end
  end
end
