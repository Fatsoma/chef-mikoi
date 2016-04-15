if defined?(ChefSpec)
  def run_mikoi_execute(command)
    ChefSpec::Matchers::ResourceMatcher.new(:mikoi_execute, :run, command)
  end
end
