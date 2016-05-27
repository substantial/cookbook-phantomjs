maintainer       "Substantial Inc."
maintainer_email "shaun@substantial.com"
license          "All rights reserved"
description      "Installs/Configures phantomjs"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.10"

%w{ debian ubuntu }.each do |os|
  supports os
end
