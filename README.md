mikoi Cookbook
============================
Use [mikoi](https://github.com/nabeken/mikoi) to enable making requests to a server with [HAProxy's Proxy Protocol](http://www.haproxy.org/download/1.5/doc/proxy-protocol.txt).

Requirements
------------
TODO: List your cookbook requirements. Be sure to include any requirements this cookbook has on platforms, libraries, other cookbooks, packages, operating systems, etc.

e.g.
#### cookbooks
- `golang` - installs go programming language

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
        <li><tt>go</tt> to install using <tt>go get</tt></li>
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
#### mikoi::default
Installs mikoi go package.

Just include `mikoi` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[mikoi]"
  ]
}
```

#### Resource
Use the custom resource `mikoi_proxy` to wrap other resources to be run while
the proxy is running.

```ruby
mikoi_proxy 'name' do
  block do
    execute %q(curl 'localhost:{port}')
  end
end
```

Testing
-------
This project uses foodcritic and chefspec, both of which can be run through guard. Integration tests use kitchen.

Contributing
------------
1. Fork the repository
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
