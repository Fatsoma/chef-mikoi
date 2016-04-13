default.mikoi.install_method = 'release'

default.mikoi.version = 'v20150613191746'
default.mikoi.release_file =
  case node.os
  when 'linux'
    'mikoi_linux_amd64.tar.gz'
  when 'darwin'
    'mikoi_darwin_amd64.zip'
  when 'freebsd'
    'mikoi_freebsd_amd64.zip'
  when 'windows'
    'mikoi_windows_386.zip'
  else
    ''
  end
default.mikoi.release_url_template = 'https://github.com/nabeken/mikoi/releases/download/{version}/{release_file}'
default.mikoi.release_url = nil
default.mikoi.install_dir = '/usr/local/bin'
