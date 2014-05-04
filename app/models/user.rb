require 'pg'

class User < ActiveRecord::Base
  def self.GetUsers
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    res  = conn.exec('SELECT * FROM "photopic"."users";')
    users = []
    res.each do |row|
        users.push(row)
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

  def self.create_user(user)
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
    query = User.build_user_query(user)
    if query.nil?
      return nil
    end
    res  = conn.exec(query)
    res
  end

  private
  def self.build_user_query(user)
    puts user
    unless user[:id]..nil? || user[:firstname].nil? || user[:lastname].nil? ||
      user[:facebookID].nil? || user[:facebookAccessToken].nil? || user[:email].nil? ||
      user[:location].nil?
      query = "INSERT INTO \"photopic\".\"users\" (id, firstName, lastName, facebookID, facebookAccessToken, email, location) VALUES (#{user[:id]}, #{user[:firstName]}, #{user[:lastName]}, #{user[:facebookID]}, #{user[:facebookAccessToken]}, #{user[:email]}, #{user[:location]});"
      query
    end
  end
end
