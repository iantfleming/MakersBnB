class Booking
  attr_reader :id, :listing_id, :guest_email, :host_email, :status, :dates_from, :dates_to
  def initialize(id:, listing_id:, guest_email:, host_email:, status: 'PENDING', dates_from:, dates_to:)
    @id = id
    @listing_id = listing_id
    @guest_email = guest_email
    @host_email = host_email
    @status = status
    @dates_from = dates_from
    @dates_to = dates_to
  end

  def self.create(listing_id:, guest_email:, host_email:, status:, dates_from:, dates_to:)
    con = if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'makersbnb_test')
    else
      PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("INSERT INTO bookings (listing_id, guest_email, host_email, status, dates_from, dates_to) VALUES ('#{listing_id}', '#{guest_email}', '#{host_email}', '#{status}', '#{dates_from}', '#{dates_to}') RETURNING id, listing_id, guest_email, host_email, status, dates_from, dates_to;")
    Booking.new(id: result[0]['id'], listing_id: result[0]['listing_id'], guest_email: result[0]['guest_email'], host_email: result[0]['host_email'], status: result[0]['status'], dates_from:result[0]['dates_from'], dates_to:result[0]['dates_to'])
  end

  def self.find(email)
    con = if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'makersbnb_test')
    else
      PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("SELECT * FROM bookings WHERE host_email = '#{email}'")
    return nil if result.count.zero?
    result.map do |booking|
      p Booking.new(id: booking['id'], listing_id: booking['listing_id'], guest_email: booking['guest_email'], host_email: booking['host_email'], status: booking['status'], dates_from: booking['dates_from'], dates_to:booking['dates_to'])
    end
  end

  def self.approve(id)
    con = if ENV['ENVIRONMENT'] == 'test'
      PG.connect(dbname: 'makersbnb_test')
    else
      PG.connect(dbname: 'makersbnb')
    end
    result = con.exec("UPDATE bookings SET status = 'approved' WHERE id = #{id};")
  end
end
