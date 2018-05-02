
# Author of this script is : Antonio Sánchez Chinchón
# details can be find on his website : https://fronkonstin.com/2017/11/07/drawing-10-million-points-with-ggplot-clifford-attractors/

library(Rcpp)
library(ggplot2)
library(dplyr)


args = commandArgs(trailingOnly=TRUE)

# test if there is 4 argument: if not, return an error
if (length(args) != 4) {
  stop("4 arguments needed : a b c d", call.=FALSE)
}

 
opt = theme(legend.position  = "none",
            panel.background = element_rect(fill="white"),
            axis.ticks       = element_blank(),
            panel.grid       = element_blank(),
            axis.title       = element_blank(),
            axis.text        = element_blank())
 
cppFunction('DataFrame createTrajectory(int n, double x0, double y0, 
            double a, double b, double c, double d) {
            // create the columns
            NumericVector x(n);
            NumericVector y(n);
            x[0]=x0;
            y[0]=y0;
            for(int i = 1; i < n; ++i) {
            x[i] = sin(a*y[i-1])+c*cos(a*x[i-1]);
            y[i] = sin(b*x[i-1])+d*cos(b*y[i-1]);
            }
            // return a new data frame
            return DataFrame::create(_["x"]= x, _["y"]= y);
            }
            ')


options(digits=15)
a=as.double(args[1])
b=as.double(args[2])
c=as.double(args[3])
d=as.double(args[4])
 
df=createTrajectory(9500000, 0, 0, a, b, c, d)
 
png("/iexec/Clifford.png", units="px", width=1600, height=1600, res=300)
ggplot(df, aes(x, y)) + geom_point(color="black", shape=46, alpha=.01) + opt
dev.off()
