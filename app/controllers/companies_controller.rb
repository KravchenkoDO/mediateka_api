class CompaniesController < ApplicationController
  def index
    @companies = Company.all
  end

  def create
    @company = Company.new(company_params)
    render json: { error: @company.errors.messages }, status: 422 unless @company.save
  end

  def edit
    @company = Company.find(params[:id])
  end

  def update
    @company = Company.new(company_params)
    render json: { error: @company.errors.messages }, status: 422 unless @company.save
  end

  def delete
    Company.find(params[:id]).destroy
  end

  def company_params
    params.require(:companies).permit(:name)
  end
end
