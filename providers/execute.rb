require 'shellwords'

def whyrun_supported?
  true
end

use_inline_resources

def execute_command
  case new_resource.command
  when Array
    case new_resource.command.first
    when Array
      array_with_argv0_command
    when String
      array_command
    end
  when String
    string_command
  end
end

action :run do
  inline_execute = execute "mikoi_execute inline #{new_resource.name}" do
    command execute_command
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
  ::File.join(node.mikoi.install_dir, 'mikoi')
end

def mikoi_command
  cmd = [mikoi]
  cmd << '--hostname' << new_resource.hostname
  cmd << '--port' << new_resource.port.to_s
  cmd << '--proxyproto' if new_resource.proxy_protocol
  cmd << '--verbose' if new_resource.verbose
  cmd << '--'
end

def string_command
  mikoi_command.map(&:shellescape).join(' ') + ' ' + new_resource.command
end

def array_command
  mikoi_command + new_resource.command
end

def array_with_argv0_command
  cmd = [[mikoi_command.first, new_resource.command.first.last]]
  cmd += mikoi_command.drop(1)
  cmd << new_resource.command.first.first
  cmd += new_resource.command.drop(1)
  cmd
end
