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
    query = "SELECT photopic.\"getOpenContests\"(\'#{params[:latitude]}\', \'#{params[:longitude]}\');"
    res = conn.exec(query)
    conn.close()
    contests = []
    res.each do |row|
      contests.push(row["getOpenContests"])
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

  def self.create_contest(contest)
    #TODO
    puts contest
  end

  private
  def self.get_conn
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
  end

end
