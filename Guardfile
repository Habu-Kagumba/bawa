guard :rspec, cmd: "rspec -f d" do
  require "guard/rspec/dsl"
  dsl = Guard::RSpec::Dsl.new(self)

  # RSpec files
  rspec = dsl.rspec
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Rails files
  rails = dsl.rails(view_extensions: %w(erb))
  dsl.watch_spec_files_for(rails.app_files)
  dsl.watch_spec_files_for(rails.views)

  watch(rails.controllers) do |m|
    [
      rspec.spec.("controllers/#{m[1]}_controller")
    ]
  end

  # Rails config changes
  watch(rails.spec_helper)     { rspec.spec_dir }
  watch(rails.routes)          { "#{rspec.spec_dir}/controllers" }
  watch(rails.app_controller)  { "#{rspec.spec_dir}/controllers" }

  # Capybara features specs
  watch(rails.view_dirs)     { |m| rspec.spec.("features/#{m[1]}") }
  watch(rails.layouts)       { |m| rspec.spec.("features/#{m[1]}") }

	begin
		require 'active_support/inflector'
		watch(%r{^spec/factories/(.+)_factory\.rb$})      { |m| ["app/models/#{m[1].singularize}.rb", "spec/models/#{m[1].singularize}_spec.rb"] }
	rescue LoadError
	end

end

guard 'livereload' do
  watch(%r{app/views/.+\.erb$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|png|jpg|svg))).*}) { |m| "/assets/#{m[3]}" }
  watch(%r{(app|vendor)(/assets/\w+/(.+)\.(scss))}) { |m| "/assets/#{m[3]}.css" }
  watch(%r{(app|vendor)(/assets/\w+/(.+)\.(scss.erb))}) { |m| "/assets/#{m[3]}.css" }
end
