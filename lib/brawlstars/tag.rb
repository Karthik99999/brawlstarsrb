def cleanTag(tag)
  tag.upcase.sub('#', '').gsub('O', '0')
end

def validateTag(tag)
  tag = cleanTag(tag)
  raise Brawlstars::Error::TagError if !tag.match(/^[0289CGJLPQRUVY]+$/)
  tag
end