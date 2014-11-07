class ExportsController < ApplicationController
  def index
  end

  def export_users
    users = User.all
    @job = Delayed::Job.enqueue ExportJob.new(users, users.count)
  end
end
