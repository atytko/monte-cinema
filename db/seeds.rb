return unless Rails.env.development? || Rails.env.test?

Rails.logger = Logger.new($stdout)
Rails.logger.info 'Creating Roles...'
UserRole.create!([
                   { name: 'client' },
                   { name: 'employee' },
                   { name: 'manager' }
                 ])
Rails.logger.info 'Roles created.'
