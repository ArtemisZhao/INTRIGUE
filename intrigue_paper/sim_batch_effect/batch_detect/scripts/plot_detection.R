pdf(file="results/batch_detect_est.pdf", width=10, height=6.5, bg="white", point=16)
d1 = read.table("results/meta.detect.out")
d2 = read.table("results/cefn.detect.out")
r1 = d1$V3/d1$V4
r2 = d2$V3/d2$V4

plot(d2$V3~d2$V1, pch=16, col="red", xlab= expression(paste("Batch effect magnitude", " (",eta/sigma,")")), ylab = "Estimated proportion")
lines(d2$V3~d2$V1, col="red")

points(d1$V3~d1$V1, pch=18, col="blue")
lines(d1$V3~d1$V1, col="blue", lty =3)

points(d2$V4~d2$V1, col="red", pch = 1)
points(d1$V4~d1$V1, col="blue", pch = 5)
lines(d2$V4~d2$V1, col="red", lty=2)
lines(d1$V4~d1$V1, col="blue", lty=4)

legend("topleft", legend = c(expression(paste(pi[IR], " (CEFN)")), expression(paste(pi[R], " (CEFN)")),expression(paste(pi[IR], " (META)")), expression(paste(pi[R], " (META)"))), col=c("red", "red", "blue", "blue"), lty = c(1,2,3,4), pch=c(16,1,18,5))

dev.off()

#x11()
#plot(r1~d1$V1, log="y", pch=16, col="red")
#points(r2~d2$V1,  pch=16, col="blue")
#lines(r2~d2$V1, col="blue")
#lines(r1~d1$V1, col="red")


