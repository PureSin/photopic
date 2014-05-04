require 'pg'

class User < ActiveRecord::Base
  def self.GetUsers
    conn = User.get_conn
    res  = conn.exec('SELECT * FROM "photopic"."users";')
    conn.close
    users = []
    res.each do |row|
        users.push(row)
    end
    users
  end

  def self.find(id)
    conn = User.get_conn
    query = "SELECT * FROM \"photopic\".\"users\" WHERE id=#{id};"
    res  = conn.exec(query)
    conn.close
    user = []
    res.each do |row|
      user.push(row)
    end
    user
  end

  def self.create_user(access_token)
    conn = User.get_conn
    # check if user exists
    query = "SELECT * FROM \"photopic\".\"users\" WHERE \"facebookAccessToken\"=\'#{access_token}\';"
    res = conn.exec(query)
    user = nil
    res.each do |row|
      user = row
    end

    unless user.nil?
      return user
    end

    # if not -> query fb
    @graph = Koala::Facebook::API.new(access_token)
    user = @graph.get_object("me")
    if user.nil?
      return nil
    end
    user["access_token"] = access_token
    user["email"] = "" if user["email"].nil?
    user["latitude"] = 0.0 if user["latitude"].nil?
    user["longitude"] = 0.0 if user["longitude"].nil?

    query = User.build_user_query(user)
    if query.nil?
      puts "invalid request"
      return nil
    end
    res  = conn.exec(query)

    query = "SELECT * FROM \"photopic\".\"users\" WHERE \"facebookAccessToken\"=\'#{access_token}\';"
    res = conn.exec(query)
    conn.close()
    res.each do |row|
      return row
    end
  end

  private
  def self.get_conn
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')
  end

  def self.build_user_query(user)
    puts "User: #{user}"
    query = "SELECT photopic.\"upsertFacebookUser\"(\'#{user["id"]}\', \'#{user["access_token"]}\',\'#{user["first_name"]}\', \'#{user["last_name"]}\', \'#{user["email"]}\', \'#{user["latitude"]}\', \'#{user["longitude"]}\');"
    # query = "INSERT INTO \"photopic\".\"users\" (\"firstName\", \"lastName\", \"facebookID\", \"facebookAccessToken\", \"email\") VALUES (\'#{user[:firstName]}\', \'#{user[:lastName]}\', \'#{user[:facebookID]}\', \'#{user[:facebookAccessToken]}\', \'#{user[:email]}\');"
    puts query
    return query
  end
end
