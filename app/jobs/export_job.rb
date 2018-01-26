class ExportJob < ProgressJob::Base
  def perform
    require 'csv'
    update_stage('Crating users')
    users = (0..100).map { User.new(name: Faker::Name.name, email: Faker::Internet.email) }
    update_stage('Exporting users')
    update_progress_max(users.size * 500)
    csv_string = CSV.generate do |csv|
      500.times do
        users.each do |user|
          csv << [user.name, user.email]
          update_progress
        end
      end
    end
    FileUtils.mkdir_p('public/system')
    File.open('public/system/export.csv', 'w') { |f| f.write(csv_string) }
  end
end
