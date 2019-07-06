def validateRegion(region)
  raise Brawlstars::Error::RegionError if (region != "global" and region.length != 2)
end