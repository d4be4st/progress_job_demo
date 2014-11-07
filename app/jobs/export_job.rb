class ExportJob < ProgressJob::Base
  def initialize(users, progress_max)
    super progress_max: progress_max
    @users = users
  end

  def perform
    require 'csv'
    update_stage('Exporting users')
    csv_string = CSV.generate do |csv|
      @users.each do |user|
        csv << [user.name, user.email]
        update_progress
      end
    end
    File.open('public/system/export.csv', 'w') { |f| f.write(csv_string) }
  end
end
