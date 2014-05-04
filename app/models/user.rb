require 'pg'

class User < ActiveRecord::Base
  def self.GetUsers
    conn = PGconn.connect('user3242.c1umedcvkcua.us-east-1.rds.amazonaws.com',5432,'','','photopic','user3242','user3242password')

    res  = conn.exec('SELECT * FROM "photopic"."getContestSubmissions"(4);')

    res.each do |row|
      row.each do |column|
        puts "OUTPUT:  #{column}"
      end
    end

  end

end
