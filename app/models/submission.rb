require 'pg'

class Submission < ActiveRecord::Base
  def self.get_submissions
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    res  = conn.exec('SELECT * FROM "photopic"."submissions";')
    conn.close()
    submissions = []
    res.each do |row|
        submissions.push(row)
    end
    submissions
  end

  def self.get_submission(id)
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    query = "SELECT * FROM \"photopic\".\"submissions\" WHERE id=#{id};"
    res  = conn.exec(query)
    conn.close()
    submission = []
    res.each do |row|
      submission.push(row)
    end
    submission
  end

  def self.create(submission)
    conn = Contests.get_conn
    query = "SELECT * FROM photopic.\"submitPhoto\"(\'#{params[:userID]}\', \'#{params[:contestID]}\', \'#{params[:mediaURL]}\', \'#{params[:latitude]}\', \'#{params[:longitude]}\');"
    res = conn.exec(query)
    conn.close()
    submission = []
    res.each do |row|
      submission.push(row)
    end
    submission
  end

  private
  def self.get_conn
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
  end
end
