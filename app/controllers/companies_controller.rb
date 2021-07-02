class CompaniesController < ApplicationController
  before_action :find_company, only: [:show, :update, :destroy]

  # GET /companies
  def index
    @companies = Company.all
  end

  # GET /companies/:id
  def show; end

  # PUT /companies/:id
  def update
    unless  @company.update(name: params[:name])
      render json: { errors: @company.errors.messages }, status: :unprocessable_entity
    end
  end

  # DELETE /companies/:id
  def destroy
    @company.destroy
  end

  # POST /companies
  def create
    @company = Company.new(name: params[:name])
    if @company.save
      render  status: :created
    else
      render json: { errors: @company.errors.messages }, status: 422
    end
  end

  private

  def find_company
    @company = Company.find_by_id params[:id]
    head :not_found unless @company
  end
end
