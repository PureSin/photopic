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

  def self.get_submissions_for_contest(contestID)
    conn = Contests.get_conn

    query = "SELECT * FROM photopic.\"getContestSubmissions\"(\'#{contestID}\');"
    res = conn.exec(query)
    conn.close()
    submissions = []
    res.each do |row|
      submissions.push(row)
    end
    submissions
  end

  def self.create(submission)
    conn = Contests.get_conn
    query = "SELECT * FROM photopic.\"submitPhoto\"(\'#{submission[:userID]}\', \'#{submission[:contestID]}\', \'#{submission[:mediaURL]}\', \'#{submission[:latitude]}\', \'#{submission[:longitude]}\');"
    puts query
    res = conn.exec(query)
    conn.close()
    submission = []
    res.each do |row|
      submission.push(row)
    end
    puts submission
    submission
  end

  def self.get_my_submissions(userID)
    conn = Contests.get_conn
    query = "SELECT * FROM photopic.\"submissions\" AS a INNER JOIN photopic.\"contests\" AS b ON a.\"contestID\" = b.id WHERE \"userID\"=#{userID};"
    puts query
    res = conn.exec(query)
    conn.close()
    subs = []
    res.each do |row|
      subs.push(row)
    end
    puts subs
    subs
  end

  private
  def self.get_conn
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
  end
end
