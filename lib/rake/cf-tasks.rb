# vim:ft=ruby

###
### Yeah, I know: shameful use of 'exec'...
###

desc "default: list rake tasks"
task :default do
  exec "rake --tasks"
end

# vim:ft=ruby

###
### cloudformation tasks
###

desc "cloudformation: list-stacks"
task :'cf-stacks' do
  sh %Q{
    aws cloudformation list-stacks --output json
  }
end

desc "cloudformation: describe-stacks"
task :'cf-desc' do
  sh %Q{
    aws cloudformation describe-stacks --output table --stack-name #{@stack}
  }
end

desc "cloudformation: describe-stack-events"
task :'cf-events' do
  sh %Q{
    aws cloudformation describe-stack-events --output json --stack-name #{@stack}
  }
end

desc "cloudformation: list-stack-resources"
task :'cf-list' do
  sh %Q{
    aws cloudformation list-stack-resources --output table --stack-name #{@stack}
  }
end

desc "cloudformation: describe-stacks"
task :'cf-status' do
  sh %Q{
    aws cloudformation describe-stacks \
      --output table          \
      --stack-name #{@stack}  \
      2>&1 | egrep -i 'status|does not exist'
  }
end

desc "cloudformation: delete-stack"
task :'cf-del' do
  sh %Q{
    aws cloudformation delete-stack --output table --stack-name #{@stack}
  }
end

