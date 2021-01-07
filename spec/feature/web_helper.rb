require 'pg'

def empty
  con = PG.connect(dbname: 'makersbnb_test')
  rs = con.exec "TRUNCATE users, listings"
end

def add_original_list
  con = PG.connect(dbname: 'makersbnb_test')
  rs = con.exec "INSERT INTO listings (name, price, description, date, available_from, available_to) VALUES ('London', '100', 'Wonderful one-bedroom apartment with falling ceilings', '2021-06-01', '2021-07-01', '2021-08-01')"
end

def persisted_data(id:, table:)
  connection = PG.connect(dbname: 'makersbnb_test')
  result = connection.query("SELECT * FROM #{table} WHERE id = #{id};")
  result.first
end
