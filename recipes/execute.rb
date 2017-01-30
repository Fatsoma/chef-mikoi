# Runs mikoi_execute resource for each item in node['mikoi']['execute']

supported_attributes = %w(
  hostname
  port
  proxy_timeout
  proxy_protocol
  verbose
  command
  creates
  cwd
  environment
  group
  returns
  command_timeout
  umask
  user
).freeze

node['mikoi']['execute'].each do |name, attributes|
  mikoi_execute name do
    supported_attributes.each do |att_name|
      send(att_name, attributes[att_name]) if attributes.key?(att_name)
    end
  end
end
