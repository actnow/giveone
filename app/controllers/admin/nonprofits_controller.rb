class Admin::NonprofitsController < Admin::BaseController
  before_filter :find_nonprofit, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @nonprofits = Nonprofit.
      order("id ASC")
  end

  def show
    render :edit
  end

  def lookup_ein
    dummy_nonprofit = Nonprofit.new(ein: params[:ein].to_s)
    ein_json = HTML::mediumSanitizer.new.sanitize(dummy_nonprofit.details)

    respond_with ein_json.to_json
  end

  def new
    @date = params[:date].to_s.to_date
    @nonprofit = Nonprofit.new(featured_on: @date)
  end

  def create
    @nonprofit = Nonprofit.new(nonprofit_params)
    @nonprofit.save
    respond_with(@nonprofit, location: admin_nonprofits_url)
  end

  def edit
  end

  def update
    @nonprofit.update_attributes(nonprofit_params)
    respond_with(@nonprofit, location: edit_admin_nonprofit_url(@nonprofit))
  end

  def destroy
    @nonprofit.destroy
    respond_with(@nonprofit, location: admin_nonprofits_url)
  end

  private
  def nonprofit_params
    params.require(:nonprofit).permit(:category_id, :name, :slug, :description, :blurb, :website_url, :twitter, :ein, :logo, :photo, :featured_on, :is_public, :context)
  end

  def find_nonprofit
    @nonprofit = Nonprofit.find_by_param(params[:id])
  end
end
