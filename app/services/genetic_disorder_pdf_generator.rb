require 'prawn'

class GeneticDisorderPdfGenerator
  def self.generate(symptoms:, matches:)
    pdf = Prawn::Document.new

    pdf.text "Genetic Disorder Identification Report", size: 18, style: :bold, align: :center
    pdf.move_down 20

    pdf.text "Generated At: #{Time.now.strftime('%Y-%m-%d %H:%M:%S')}", size: 10
    pdf.move_down 10

    pdf.text "Symptoms:", style: :bold
    pdf.text symptoms.join(', ')
    pdf.move_down 10

    pdf.text "Matched Disorders:", style: :bold
    if matches.empty?
      pdf.text "No matching disorders found."
    else
      matches.each_with_index do |match, index|
        pdf.move_down 5
        pdf.text "#{index + 1}. #{match[:name]}", style: :bold
        pdf.text "   Match Score: #{match[:match_score]}"
        pdf.text "   Mutation Match: #{match[:mutation_match] ? 'Yes' : 'No'}"
        pdf.text "   Risk Level: #{match[:risk_level]}"
        pdf.move_down 10
        pdf.text "   Suggested Tests:"
        match[:suggested_tests].each_with_index do |test_name, index|
          pdf.text "   #{index + 1}.#{test_name}"
        end
      end
    end

    pdf.render
  end
end
