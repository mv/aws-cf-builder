# vim:ft=ruby

require 'json'

def print_ami( output, title = '' )

  json  = JSON.parse(output)
  lines = []
  mask  = '  %-25s  %-12s  %s'
  sep   = sprintf mask, '-' * 25 , '-' * 12 , '-' * 40

  json.each do |j|
    lines.push( sprintf mask, j['created'], j['ami_id'], j['name'] )
  end

  printf "\nAMI: %s\n\n", title
  printf "#{mask}\n", 'Created', 'AMI', 'Name'
  printf "#{sep}\n"
  lines.sort.each{ |line| puts line }
  printf "#{sep}\n\n"

end

###
### AMI tasks
###

desc "Latest AMI's: Amazon Linux"
task :'ami-amzn' do
  output = %x{
    aws ec2 describe-images     \
        --output json           \
        --owner  amazon         \
        --filters "Name=root-device-type,Values=ebs"  \
        --filters "Name=name,Values=amzn-ami-vpc-nat*"  \
        --query 'Images[*].{name: Name, ami_id: ImageId, created: CreationDate}'  \
  }

  print_ami output, "Amazon Linux"
end



