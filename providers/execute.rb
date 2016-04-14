require 'shellwords'

def whyrun_supported?
  true
end

use_inline_resources

action :run do
  inline_execute = execute new_resource.name do
    command mikoi_command
    creates new_resource.creates
    cwd new_resource.cwd
    environment new_resource.environment
    group new_resource.group
    returns new_resource.returns
    timeout new_resource.command_timeout
    user new_resource.user
    umask new_resource.umask
  end

  new_resource.updated_by_last_action(inline_execute.updated_by_last_action?)
end

private

def mikoi
  File.join(install_dir, 'mikoi')
end

def mikoi_command
  cmd = "#{mikoi} --hostname=#{new_resource.hostname.shellescape} " \
    "--port=#{new_resource.port.to_s.shellescape} "
  cmd << '--proxyproto ' if new_resource.proxy_protocol
  cmd << '--verbose ' if new_resource.verbose
  cmd << "-- #{new_resource.command}"
end
