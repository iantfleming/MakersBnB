require 'pg'

def empty
  con = PG.connect(dbname: 'makersbnb_test')
  rs = con.exec "TRUNCATE users, listings"
end

def add_original_list
  con = PG.connect(dbname: 'makersbnb_test')
  rs = con.exec "INSERT INTO listings (name, price, description) VALUES ('London', '100', 'Wonderful one-bedroom apartment with falling ceilings')"
end

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'makersbnb_test')
  result = connection.query("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end
