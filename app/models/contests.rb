require 'pg'

class Contests < ActiveRecord::Base
  def self.get_contests
    conn = Contests.get_conn
    query = "SELECT * FROM \"photopic\".\"contests\";"
    res  = conn.exec(query)
    conn.close()
    contests = []
    res.each do |row|
      contests.push(row)
    end
    contests

  end

  def self.get_open_contests(params)
    conn = Contests.get_conn
    query = "SELECT * FROM photopic.\"getOpenContests\"(\'#{params[:latitude]}\', \'#{params[:longitude]}\');"
    res = conn.exec(query)
    conn.close()
    contests = []
    res.each do |row|
      contests.push(row)
    end
    contests
  end

  def self.get_contest(id)
    conn = Contests.get_conn
    query = "SELECT * FROM \"photopic\".\"contests\" WHERE id=#{id};"
    res  = conn.exec(query)
    conn.close()
    contest = []
    res.each do |row|
      contest.push(row)
    end
    contest
  end

  def self.create(contest)
    conn = Contests.get_conn
    contest = contest[:contest]

    query = "SELECT * FROM photopic.\"createContest\"(\'#{contest[:creatorID]}\', \'#{contest[:title]}\', \'#{contest[:description]}\', \'#{contest[:isOutdoor]}\', \'#{contest[:weather]}\', \'#{Time.new + 60}\', \'#{contest[:price]}\',\'#{contest[:latitude]}\', \'#{contest[:longitude]}\');"
    puts query
    res = conn.exec(query)
    conn.close()
    contests = []
    res.each do |row|
      contests.push(row)
    end
    contests.first
  end

  def self.set_winner(contestID, submissionID)
    conn = Contests.get_conn
    query = "SELECT * FROM photopic.\"contestCompletion\"(\'#{contestID}\', \'#{submissionID}\');"
    puts query
    res = conn.exec(query)
    conn.close()
    contests = []
    res.each do |row|
      contests.push(row)
    end
    contests.first
  end

  private
  def self.get_conn
    PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
  end

end
