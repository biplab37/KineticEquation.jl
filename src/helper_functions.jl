function integrate_region(dist, region)
    return quadgk(dist, eachcol(region)[1], eachcol(region)[2])[1]
end
