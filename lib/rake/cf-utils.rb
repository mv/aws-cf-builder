# vim:ft=ruby

###
### Other stuff
###

desc "print parameters"
task :params do
  puts <<-PUTS

  config file: #{@config}
  erb file: #{@erb}
  final template: #{@template}

  PUTS
end

