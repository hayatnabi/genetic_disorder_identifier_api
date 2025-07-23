class Api::V1::GeneticDisordersController < ApplicationController
  def identify
    symptoms = params[:symptoms].to_s.downcase.split(',').map(&:strip)
    mutations = params[:mutations].to_s.upcase.split(',').map(&:strip)

    result = GeneticDisorderIdentifierService.new(symptoms, mutations).call

    if params[:format] == "pdf"
      pdf = GeneticDisorderPdfGenerator.generate(symptoms: symptoms, matches: result)
      send_data pdf, filename: "genetic_report_#{Time.now.to_i}.pdf", type: "application/pdf", disposition: "inline"
    else
      render json: {
        symptoms: symptoms,
        result: result
      }
    end

    # render json: result
  end
end
