class GeneticDisorderIdentifierService
  def initialize(symptoms, mutations)
    @symptoms = symptoms
    @mutations = mutations
  end

  def call
    matches = []

    GENETIC_DATABASE.each do |disorder|
      symptom_score = (@symptoms & disorder[:symptoms]).size
      mutation_match = (@mutations & disorder[:mutations]).any?

      if symptom_score > 0 || mutation_match
        matches << {
          name: disorder[:name],
          match_score: symptom_score,
          mutation_match: mutation_match,
          risk_level: disorder[:risk_level],
          suggested_tests: disorder[:tests]
        }
      end
    end

    matches.sort_by { |m| [m[:mutation_match] ? -1 : 0, -m[:match_score]] }
  end

  GENETIC_DATABASE = [
    {
      name: "Cystic Fibrosis",
      symptoms: ["persistent cough", "lung infections", "salty skin"],
      mutations: ["CFTR"],
      risk_level: "High",
      tests: ["Sweat chloride test", "CFTR genetic test"]
    },
    {
      name: "Thalassemia",
      symptoms: ["fatigue", "pale skin", "enlarged spleen"],
      mutations: ["HBB"],
      risk_level: "Medium",
      tests: ["CBC", "Hemoglobin electrophoresis", "HBB gene test"]
    },
    {
      name: "Breast Cancer (Hereditary)",
      symptoms: ["lump", "family history"],
      mutations: ["BRCA1", "BRCA2"],
      risk_level: "High",
      tests: ["BRCA1/2 gene test", "Mammogram"]
    }
  ]
end
