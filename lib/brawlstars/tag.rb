def cleanTag(tag)
  tag.upcase.sub('#', '').gsub('O', '0')
end

def validateTag(tag)
  tag = cleanTag(tag)
  raise "An invalid tag was given!" if !tag.match(/^[0289CGJLPQRUVY]+$/)
  tag
end