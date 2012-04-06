maintainer       "Substantial Inc."
maintainer_email "YOUR_EMAIL"
license          "All rights reserved"
description      "Installs/Configures phantomjs"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.3"

%w{ debian ubuntu }.each do |os|
  supports os
end
