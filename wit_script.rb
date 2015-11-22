require 'wit'

  access_token = 'HN36OGTPIBJYFITLNMTXXPKHW22YTEQD'

  Wit.init
  response = Wit.voice_query_auto(access_token)
  p "Response: #{response}"
  Wit.close