actions :run
default_action :run

# Mikoi attributes
attribute :hostname, kind_of: String
attribute :port, kind_of: [String, Integer]
attribute :proxy_timeout, kind_of: String, default: '10s'
attribute :proxy_protocol, kind_of: [TrueClass, FalseClass], default: false
attribute :verbose, kind_of: [TrueClass, FalseClass], default: false

# Execute attributes
attribute :command, kind_of: [String, Array], name_attribute: true
attribute :creates, kind_of: String
attribute :cwd, kind_of: String
attribute :environment, kind_of: Hash
attribute :group, kind_of: [String, Integer]
attribute :returns, kind_of: [Integer, Array]
attribute :command_timeout, kind_of: Integer
attribute :umask, kind_of: [String, Integer]
attribute :user, kind_of: [String, Integer]
