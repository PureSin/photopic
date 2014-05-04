require 'pg'

class User < ActiveRecord::Base
  def self.GetUsers
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    res  = conn.exec('SELECT * FROM "photopic"."users";')
    users = []
    res.each do |row|
      row.each do |column|
        users.push(column)
        puts users
      end
    end
    users
  end

  def self.find(id)
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    query = "SELECT * FROM \"photopic\".\"users\" WHERE id=#{id};"
    res  = conn.exec(query)
    user = []
    res.each do |row|
      user.push(row)
    end
    user
  end
end
