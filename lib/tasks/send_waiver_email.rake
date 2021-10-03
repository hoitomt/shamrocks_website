desc 'Send an email to the registered email address requesting a waiver signature'
task :send_waiver_email => :environment do
  year = 2021
  # Start the year on July 1
  start_date = Date.new(year, 7, 1)
  puts "Pull all registrations with unsigned waivers since: #{start_date}"

  unsigned_registrations = Registration.with_unsigned_waiver(start_date)

  puts "#{unsigned_registrations.count}"
  unsigned_registrations.each do |unsigned_registration|
    puts "Send a waiver reminder email to #{unsigned_registration.email}"
    WaiverMailer.reminder_email(unsigned_registration).deliver_now
  end
end
