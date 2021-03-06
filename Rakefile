#
# vim:ft=ruby
#
# To remember: Ruby/Rake shell commands
#    Ruby
#       %x{ cmd } or `cmd`  - executes 'cmd' and gives cmd OUTPUT
#       system 'cmd'        - executes 'cmd' and gives OS level return code.
#       exec 'cmd'          - executes 'cmd' in the current process and finalizes it.
#    Rake
#       sh 'cmd'            - prints 'cmd' before executing it and gives cmd OUTPUT#       sh 'cmd'            - prints 'cmd' before executing it and gives cmd OUTPUT
#       sh 'cmd' do |return,output| - executes 'cmd' and gets its OUTPUT and OS return code.
#
# To remeber (2): string quotes
#   '', %q{}, %q[], %q//, %q|| - single quotes
#   "", %Q{}, %Q[], %Q//, %Q|| - double quotes
#   "", %{} , %[] , %// , %||  - double quotes
#
# To remeber (3): heredocs
#   # heredoc, idented, interpolation
#   sh <<-CMD
#       cmd
#       cmd #{var}
#   CMD
#
#   # heredoc, idented, interpolation, remove identation
#   sh <<-'CMD.gsub(/^[ ]*/,'') -
#       cmd
#       cmd #{var}
#   CMD
#
#   # heredoc, idented, no interpolation (as single quotes)
#   sh <<-'CMD'
#       cmd
#       cmd #{var}
#   CMD
#

require_relative "lib/rake/cf-utils"
require_relative "lib/rake/cf-tasks"
require_relative "lib/rake/ami"
require_relative "lib/rake/for-all"

###
### Settings
###
@template = "1.json"
@stack    = "test-1"
@config   = ENV['config'] || "config/cf.yml"
@erb = ''

desc "cloudformation: validate-template"
task :'cf-validate' do
  sh %Q{
    aws cloudformation validate-template --output table \
        --template-body file://#{@template}
  }
end

desc "cloudformation: create-stack"
task :'cf-create' do
  sh %Q{
    aws cloudformation create-stack \
        --template-body file://#{@template} \
        --stack-name #{@stack}      \
        --parameters \
          ParameterKey=KeyName,ParameterValue=internal-mv.dev.id_rsa \
        --output json
  }
end

