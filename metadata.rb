name 'mikoi'
maintainer 'Bill Ruddock'
maintainer_email 'bill.ruddock@fatsoma.com'
license 'MIT'
description 'Uses mikoi to enable connecting to server with Proxy Protocol'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

source_url 'https://github.com/Fatsoma/chef-mikoi'
issues_url 'https://github.com/Fatsoma/chef-mikoi/issues'

attribute 'mikoi/install_method',
          display_name: 'Install method',
          description: 'How to install mikoi.',
          choice: %w(release go),
          type: 'string',
          required: 'recommended',
          default: 'release'
attribute 'mikoi/version',
          display_name: 'Mikoi version',
          description: 'Mikoi version to install',
          type: 'string',
          required: 'optional',
          default: 'v20150613191746'
attribute 'mikoi/release_file',
          display_name: 'Mikoi release filename',
          description: 'Basename of release url',
          type: 'string',
          required: 'optional',
          calculated: true
attribute 'mikoi/release_url_template',
          display_name: 'Mikoi release url template',
          description: 'Template for release_url. `{version}` and `{release_file}` will be replaced by `mikoi/version` and `mikoi/release_file` respectively.',
          type: 'string',
          required: 'optional',
          default: 'https://github.com/nabeken/mikoi/releases/download/{version}/{release_file}'
attribute 'mikoi/release_url',
          display_name: 'Mikoi release url',
          description: 'Set if release_url_template does not fit your needs',
          type: 'string',
          required: 'optional',
          default: nil
attribute 'mikoi/install_dir',
          display_name: 'Mikoi install directory',
          description: 'Directory to install mikoi binary to',
          type: 'string',
          required: 'optional',
          default: '/usr/local/bin'

depends 'golang'
