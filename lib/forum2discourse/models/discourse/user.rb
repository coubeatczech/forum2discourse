class Forum2Discourse::Models::Discourse::User < Forum2Discourse::Models::Discourse::Base

  def self.anonymous
    @anonymous ||= new(username: 'Anonymous', email: 'anonymous@example.com', name: 'Anonymous User')
  end
  attr_accessor :username, :email, :name

  def valid?
    !username.nil? &&
      !email.nil? &&
      !username.empty? &&
      !email.empty?
  end

  # Discourse has a username limit of 15 characters.
  def serialize
    super.tap do |data|
      if data[:username].length > 50
        puts "Truncating username '#{data[:username]}' as >50 characters" 
        data[:username] = data[:username][0..14]
      end
    end
  end
end
