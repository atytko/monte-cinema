# frozen_string_literal: true

return unless Rails.env.development? || Rails.env.test?

Rails.logger = Logger.new($stdout)
Rails.logger.info 'Creating Roles...'
UserRole.create!([
                   { name: 'client' },
                   { name: 'employee' },
                   { name: 'manager' }
                 ])
Rails.logger.info 'Roles created.'

Rails.logger.info 'Creating Users...'
client = User.create!(
  email: 'client@test.com',
  first_name: 'John',
  last_name: 'Doe',
  password: 'password'
)

User.create!(
  email: 'employee@test.com',
  first_name: 'Anna',
  last_name: 'Smith',
  password: 'password'
)
User.last.update(user_role: UserRole.find_by(name: 'employee'))

User.create!(
  email: 'manager@test.com',
  first_name: 'Joanna',
  last_name: 'Nowak',
  password: 'password'
)
User.last.update(user_role: UserRole.find_by(name: 'manager'))
Rails.logger.info 'Users created.'

Rails.logger.info 'Creating Ticket Types...'
TicketType.create!([
                     { name: 'regular', price: 20 },
                     { name: 'family', price: 30 },
                     { name: 'student', price: 15 }
                   ])
Rails.logger.info 'Ticket Types created.'

Rails.logger.info 'Creating Cinema Halls...'
CinemaHall.create!([
                     { name: 'Mars', row_number: 10, row_total_seats: 20 },
                     { name: 'Venus', row_number: 10, row_total_seats: 10 },
                     { name: 'Saturn', row_number: 5, row_total_seats: 10 },
                     { name: 'Jupiter', row_number: 5, row_total_seats: 4 }
                   ])
Rails.logger.info 'Cinema Halls created.'

Rails.logger.info 'Creating Movies...'
Movie.create!([
                { title: 'Titanic',
                  description: 'A seventeen-year-old aristocrat falls in love with a kind but poor artist
                                aboard the luxurious, ill-fated R.M.S. Titanic.',
                  director: 'James Cameron',
                  genre: 'drama',
                  duration: 210 },
                { title: 'Pulp Fiction',
                  description: "In the realm of underworld, a series of incidents intertwines the lives
                                of two Los Angeles mobsters, a gangster's wife, a boxer and two small-time criminals.",
                  director: 'Quentin Tarantino',
                  genre: 'crime',
                  duration: 178 },
                { title: 'Forrest Gump',
                  description: 'The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal
                                and other historical events unfold from the perspective of an Alabama man with
                                an IQ of 75, whose only desire is to be reunited with his childhood sweetheart.',
                  director: 'Robert Zemeckis',
                  genre: 'drama',
                  duration: 142 },
                { title: 'Gladiator',
                  description: 'A former Roman General sets out to exact vengeance against the corrupt
                                emperor who murdered his family and sent him into slavery.',
                  director: 'Ridley Scott',
                  genre: 'historical drama',
                  duration: 171 }
              ])
Rails.logger.info 'Movies created.'

Rails.logger.info 'Creating Ticket Desks...'
ticket_desk = TicketDesk.create!
Rails.logger.info 'Ticket Desks created.'

Rails.logger.info 'Creating Screenings...'
Screening.create!([
                    { cinema_hall: CinemaHall.all.sample, screening_time: Time.current + 1.hour,
                      movie: Movie.all.sample },
                    { cinema_hall: CinemaHall.all.sample, screening_time: Time.current + 2.hour,
                      movie: Movie.all.sample },
                    { cinema_hall: CinemaHall.all.sample, screening_time: Time.current + 3.hour,
                      movie: Movie.all.sample },
                    { cinema_hall: CinemaHall.all.sample, screening_time: Time.current + 4.hour,
                      movie: Movie.all.sample }
                  ])
Rails.logger.info 'Screenings created.'

Rails.logger.info 'Creating Reservations...'
Reservation.create!([
                      { status: 'pending', screening: Screening.all.sample, ticket_desk: ticket_desk, user: client },
                      { status: 'pending', screening: Screening.all.sample, ticket_desk: ticket_desk, user: client  },
                      { status: 'pending', screening: Screening.all.sample, ticket_desk: ticket_desk, user: client  }
                    ])
Rails.logger.info 'Reservations created.'

Rails.logger.info 'Creating Seats Reservations...'
Reservation.all.each do |reservation|
  rows = ('A'..'J').to_a.shuffle
  seats = (1..reservation.screening.cinema_hall.row_total_seats).to_a.shuffle
  rand(1..3).times do |number|
    SeatsReservation.create!([row: rows[number],
                              seat_number: seats[number],
                              cinema_hall: reservation.screening.cinema_hall,
                              reservation: reservation])
  end
end
Rails.logger.info 'Seats Reservations created.'
