# vim:ft=ruby

require 'json'

###
### Hack(?)
###

namespace :'for-all' do

  desc "Usage: rake for-all:regions task='task-name'"
  task :regions do |task|

    if ! ENV.has_key?('task')
      printf "\n  Error: you must define a task name.\n\n"
      exit
    end

    output = %x{
      aws ec2 describe-regions    \
          --output json           \
          --query 'Regions[*].RegionName' # return in a simple array list
    }

    JSON.parse(output).sort.each do |region|

      printf "Region: %s\n", region
      ENV['AWS_DEFAULT_REGION'] = region
      Rake::Task[ ENV['task'] ].execute
      printf "\n"

    end # JSON array

  end # regions

# desc "Usage: rake for-all:azs     task='task-name'"
  task :azs do

    if ! ENV.has_key?('task')
      printf "\n  Error: you must define a task name.\n\n"
      exit
    end

    output = %x{
      aws ec2 describe-availability-zones \
        --output json \
        --query 'AvailabilityZones[*].ZoneName'
    }

    JSON.parse(output).sort.each do |az|

      printf "AZ: %s\n", az
      ENV['az'] = az
      Rake::Task[ ENV['task'] ].execute
      printf "\n"

    end # JSON array

  end # azs


end # namespace


desc "ec2: describe-availability-zones"
task :'list-azs' do
  sh "aws ec2 describe-availability-zones --output text | sort | column -t"
end


desc "ec2: describe-regions"
task :'list-regions' do
  sh "aws ec2 describe-regions --output text | sort | column -t"
end


