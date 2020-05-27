class StaticController < ApplicationController
  def index
  end

  def about
  end

  def teams
  end

  def documents
  end

  def registration_letter
    send_file (File.join("#{Rails.root}", "docs", "2019_Marketing_Flyer.pdf"))
  end

  def grievance_document
    send_file (File.join("#{Rails.root}", "docs", "ECShamrocksGrievenceDocument5.13.2013.doc"))
  end

  def volunteer_code_of_conduct
    send_file (File.join("#{Rails.root}", "docs", "ECShamrocksVolunteerCodeofConduct2013.doc"))
  end

  def policy_parents
    send_file (File.join("#{Rails.root}", "docs", "PolicyforParentsofAthletes5.13.2013.doc"))
  end

  def athlete_code_of_conduct
    send_file (File.join("#{Rails.root}", "docs", "ShamrocksBasketballAthleteCodeofConduct5.13.2013.doc"))
  end

  def mailing_list
  end

  def admin
  end
end

