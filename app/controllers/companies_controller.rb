class CompaniesController < ApplicationController
  before_action :find_company, only: [:show, :update, :destroy]
  before_action :permit_company_params, only: %i[create update]
  # GET /companies
  def index
    @companies = Company.filtering(params).page(page).per(per_page)
  end

  # GET /companies/:id
  def show; end

  authorize @companies

  # PUT /companies/:id
  def update
    unless @company.update(@permitted_params)
      authorize @companies
      render json: { errors: @company.errors.messages }, status: :unprocessable_entity
    end
  end

  # DELETE /companies/:id
  def destroy
    @company.destroy
    authorize @companies
  end

  # POST /companies
  def create
    @company = Company.new(@permitted_params)
    authorize @companies
    if @company.save
      render status: :created
    else
      render json: { errors: @company.errors.messages }, status: 422
    end
  end

  private

  def find_company
    @company = Company.find_by_id params[:id]
    head :not_found unless @company
  end

  def permit_company_params
    @permitted_params = params.permit(:name)
  end
end
