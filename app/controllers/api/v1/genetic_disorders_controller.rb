class Api::V1::GeneticDisordersController < ApplicationController
  def identify
    symptoms = params[:symptoms].to_s.downcase.split(',').map(&:strip)
    mutations = params[:mutations].to_s.upcase.split(',').map(&:strip)

    result = GeneticDisorderIdentifierService.new(symptoms, mutations).call

    render json: result
  end
end
