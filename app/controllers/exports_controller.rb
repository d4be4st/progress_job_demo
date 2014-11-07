class ExportsController < ApplicationController
  def index
  end

  def export_users
    @job = Delayed::Job.enqueue ExportJob.new
  end
end
