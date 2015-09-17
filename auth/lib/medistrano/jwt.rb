module Medistrano
  class JWT
    
    class ExpiredSignature < StandardError; end
    class Error < StandardError; end

    #include ::Exceptions::Logging

    class << self
      #include ::Exceptions::Logging

      def from_token(token)
        # JWT_SECRET is populated with the value in config/jwt.yml
        payload = ::JWT.decode(token, JWT_SECRET).first
        self.new(payload, false).tap { |t| t.check_expiry! }
      rescue ExpiredSignature
        Medistrano.logger.info("Request made with expired token for user with email: #{payload['email'] || 'unknown'}")
        self.new(payload, true)
      rescue ::JWT::DecodeError => e
        Medistrano.logger.error(stacktrace('Error in jwt gem while decoding token', e))
        self.new({}, true)
      end

      def from_user(user, role)
        
        puts '>>> from_user:', user, role
        
        if user[:role] != 'devops' && role == 'devops'
          raise Error.new('User may not assign self additional privileges')
        end
        
        { 'test' => 'abc' }
        
        #self.new({
        #  'email' => user.email,
        #  'exp' => (Time.now + 1.day).to_i, # TODO: Is this reasonable?
        #  'role' => role,
        #  'version' => user.token_version!(role)
        #}, false)
        
      end
      
    end

    attr_reader :payload

    def initialize(payload, invalid)
      @payload = payload
      @invalid = invalid
    end

    def invalid?
      @invalid ||= (cached_version!(payload['email'], payload['role']) != payload['version'])
    rescue Medistrano::JWT::Error => e
      Medistrano.logger.error(stacktrace('The token being used has an old version number, or is otherwise invalid.', e))
      @invalid = true
    end

    def encoded
      ::JWT.encode(payload, JWT_SECRET)
    end

    def check_expiry!
      raise ::JWT::DecodeError.new('exp is required') unless payload['exp']
      unless payload['exp'].is_a?(Fixnum)
        raise ::JWT::DecodeError.new('exp must be an integer')
      end
      unless Time.now < Time.at(payload['exp'])
        raise ExpiredSignature.new('token has expired')
      end
    end
    
    private

    def cached_version!(email, role)
      Rails.cache.fetch(
        "user:#{email}:#{role}_token_version", expires_in: 10.minutes, race_condition_ttl: 2
      ) do
        user = User.find_by_email(email)
        raise Medistrano::JWT::Error.new('invalid user') if user.nil?
        user.token_version!(role)
      end
    end
  end
end
