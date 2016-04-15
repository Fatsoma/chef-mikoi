mikoi Cookbook
==============
Use [mikoi](https://github.com/nabeken/mikoi) to enable making requests to a server with [HAProxy's Proxy Protocol](http://www.haproxy.org/download/1.5/doc/proxy-protocol.txt).

Requirements
------------

#### Chef
Tested with 11.16.4.
Should work with Chef 12

#### cookbooks
- `golang` - installs go programming language (only needed for `['mikoi']['install_method'] == 'go'`)

#### Platform
Tested on Ubuntu 14.04. Other linux distributions should all work out of the box.

Working on freebsd except for go install (as not supported by [golang cookbook](https://github.com/NOX73/chef-golang))

Windows and Mac OS X versions of mikoi have been included but no promises made as to whether they will work. For Windows you will likely need to set `['mikoi']['install_dir']`

#### Ruby
MRI Ruby >= 1.9

Attributes
----------

#### mikoi::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['mikoi']['install_method']</tt></td>
    <td>String</td>
    <td>Install method:
      <ol>
        <li><tt>release</tt> to install from binary release</li>
        <li><tt>go</tt> to install using Go</li>
      </ol>
    </td>
    <td><tt>release</tt></td>
  </tr>
  <tr>
    <td><tt>['mikoi']['version']</tt></td>
    <td>String</td>
    <td>Version (when installing from release)</td>
    <td><tt>release</tt></td>
  </tr>
  <tr>
    <td><tt>['mikoi']['release_file']</tt></td>
    <td>String</td>
    <td>Release URL file name (last segment of URL)</td>
    <td>Calculated based on OS</td>
  </tr>
  <tr>
    <td><tt>['mikoi']['release_url_template']</tt></td>
    <td>String</td>
    <td>Template for release_url. <tt>{version}</tt> and <tt>{release_file}</tt> will be replaced by <tt>mikoi/version</tt> and <tt>mikoi/release_file</tt> respectively.</td>
    <td><tt>https://github.com/nabeken/mikoi/releases/download/{version}/{release_file}</tt></td>
  </tr>
  <tr>
    <td><tt>['mikoi']['release_url']</tt></td>
    <td>String</td>
    <td>Release URL. Set this if <tt>release_url_template</tt> does not fit your needs (note: you will still need to set release_file).
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>['mikoi']['install_dir']</tt></td>
    <td>String</td>
    <td>Directory to install mikoi binary to.</td>
    <td><tt>/usr/local/bin</tt></td>
  </tr>
</table>

Usage
-----
### mikoi::default
Installs mikoi go package.

Just include `mikoi` in your node's `run_list`:

```json
{
  "name": "my_node",
  "run_list": [
    "recipe[mikoi]"
  ]
}
```

Resources
---------

### mikoi_execute
Run a command through mikoi. Make sure your command has at least one port placeholder (`{}`).

```ruby
mikoi_execute 'name' do
  command %q(curl -H 'Host: example.com' 'localhost:{}/status')
  hostname 'example.com'
  port 80
  proxy_protocol true
end
```

#### Actions
Action | Description | Default
------ |------------ |--------
run    | Run command | Yes

#### Attributes

Attribute       | Description | Type | Default
---------       |------------ |----- |--------
hostname        | The hostname for mikoi to connect to | String
port            | The hostname for mikoi to connect to | String, Integer
proxy_timeout   | The timeout for mikoi, including units as understood by Go [`time.Duration`](https://golang.org/pkg/time/#Duration) | String | `10s`
proxy_protocol  | Use Proxy Protocol | Boolean | `false`
verbose         | Make mikoi verbose | Boolean | `false`
command         | The command to be executed. Must contain at least one placeholder `{}` for the ephemeral port | String, Array | (name attribute)
creates         | Prevent command from running if this file exists | String |
cwd             | The current working directory from which a command is run. | String |
environment     | A hash of environment variables. | Hash
group           | The group name or group ID that must be changed before running a command | String, Integer
returns         | The return value for a command. This may be an array of accepted values. An exception is raised when the return value(s) do not match | Integer, Array
command_timeout | The amount of time (in seconds) a command will wait before timing out | Integer
user            | The user name or user ID that should be changed before running a command | String, Integer
umask           | The file mode creation mask, or umask | String, Integer

Testing
-------
### Unit tests and lint
This project uses foodcritic and chefspec, both of which can be run through guard.

Please check for resource coverage by setting `COVERAGE` env variable, e.g.:

```sh
COVERAGE=true bundle exec guard
```
### Integration tests
Integration tests use test-kitchen. Follow the [getting started guide](http://kitchen.ci/docs/getting-started/)

Brief sample usage:

```sh
# Help
bundle exec kitchen help

# List all available test suites / platform variations
bundle exec kitchen list

# Test (destroy, converge and verify) without destroying after testing
bundle exec kitchen test -d never release-ubuntu-*

# manually inspect state of machine
bundle exec kitchen login release-ubuntu-*

# re-converge and verify
bundle exec kitchen converge release-ubuntu-* && \
  bundle exec kitchen verify release-ubuntu-*

# destroy when you are done
bundle exec kitchen destroy
```

#### Debugging

Debugging custom resources seems to be impossible using chef-shell in solo mode. Instead, use chef-shell in client mode with chef-zero as per [this script](https://gist.github.com/biinari/41ddc6eced8f1c42c00a7b0c98b9e868). Provide the run list as first argument to the script or set RUNLIST variable and copy/paste the commands from `cd /tmp/kitchen/` onwards.

Contributing
------------
1. Fork the repository
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
