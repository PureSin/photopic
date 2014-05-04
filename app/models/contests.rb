require 'pg'

class Contests < ActiveRecord::Base
  def self.get_contests
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    query = "SELECT * FROM \"photopic\".\"contests\";"
    res  = conn.exec(query)
    contests = []
    res.each do |row|
      contests.push(row)
    end
    contests
  end

  def self.get_contest(id)
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    query = "SELECT * FROM \"photopic\".\"contests\" WHERE id=#{id};"
    res  = conn.exec(query)
    contest = []
    res.each do |row|
      contest.push(row)
    end
    contest
  end
end
