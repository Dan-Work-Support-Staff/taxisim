#library(RgoogleMaps)
clat = 40.773455
clon = -73.962880
z = 12

lat_meters = 111194.86461
lon_meters = 84253.1418965


#jet.colors =colorRamp(c("#00007F", "blue", "#007FFF", "cyan",
#                     "#7FFF7F", "yellow", "#FF7F00", "red", "#7F0000"))

jet.colors =colorRamp(rev(c("blue", "#007FFF", "cyan",
                     "#7FFF7F", "yellow", "#FF7F00", "red")))


linearScale = function(x, lo, hi){
	x = (x - lo) / (hi - lo)
	return(pmax(pmin(x, 1), 0))
}



argv = commandArgs(trailingOnly=T)


infile = argv[1]
outfile = argv[2]
my_title = argv[3]

#print(my_title)

#infile = paste("iteration_", i, ".csv", sep="")
#outfile = paste("map_",i,".pdf", sep="")


#print(paste("Reading", infile))

png(outfile, 1024, 1024)
par(mar=c(2,5,3,2), family="sans", bg="black", col.axis="white",col.lab="white", fg="white")
layout(c(1,2), heights=c(7,1))


t = read.csv(infile)
#t = t[t$speed < 6.915 | t$speed > 6.916,]

t$start_lat = t$start_lat * lat_meters
t$end_lat = t$end_lat * lat_meters
t$start_lon = t$start_lon * lon_meters
t$end_lon = t$end_lon * lon_meters






#print("Computing colors")
#summary(t$speed)
t$speed[is.na(t$speed)] = 0


cvals = linearScale(t$speed, 1, 20)
cols = rgb(jet.colors(cvals)/255)
#cols=rgb(jet.colors(t$speed/31)/255)

#cols = rgb(jet.colors(log(t$speed+1)/3.44)/255)

#mymap = GetMap(center=c(clat, clon), zoom=z)
#print("Plotting")
#PlotOnStaticMap(mymap, clat, clon, col="black", pch=15, cex=400)
#PlotArrowsOnStaticMap(mymap, lat0=t$start_lat, lon0=t$start_lon, lat1=t$end_lat, lon1=t$end_lon, FUN=segments, add=T, col=cols,lwd=3)

size = 8000
plot(clon,clat,type="n",
	xlim=c(clon*lon_meters-size,clon*lon_meters+size),
	ylim=c(clat*lat_meters-size, clat*lat_meters+size),
	xaxt="n", yaxt="n", xlab="", ylab="")
segments(t$start_lon, t$start_lat, x1=t$end_lon, y1=t$end_lat, col=cols, lwd=3)






par(mar=c(1,1,3,1))
title(main=my_title, cex.main=3, col.main="white")


print("Adding legend")
plot(0,0, type="n", xlim=c(0,21), ylim=c(0,1), xaxt="n", yaxt="n", , bty="n", cex.main=.8, main="")
	
        vals = (0:200)/10
        cvals = linearScale(vals, 1, 20)
	mycols = rgb(jet.colors(cvals)/255)
        yvals = rep(.6,length(vals))
	points(vals, yvals, col=mycols, pch=15, cex=2)
	
	a = c((0:4)*50 + 1)
	print(a)
	print(vals[a])
	print(vals[a])
	#axis(1, at=a, labels=round(vals[a], 2))
	#abline(v=a)
	text(x=10,y=.8,labels="Velocity (m/s)", cex=2, col.main="white")
	segments(x0=vals[a],y0=.4,x1=vals[a],y1=.6, col="white", lwd=2)
	text(x=vals[a],y=.2,labels=vals[a], cex=2, col.main="white")

dev.off()

