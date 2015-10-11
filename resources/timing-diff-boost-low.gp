# http://gnuplot.respawned.com/
# Scale font and line width (dpi) by changing the size! It will always display stretched.
set terminal svg size 400,300 enhanced fname 'arial'  fsize 10 butt solid
set output 'out.svg'

# Key means label...
set key top left
set xlabel 'RPM'
set ylabel 'Degrees'
set title '5° motor timing and 45° of dynamic ESC timing'
set grid xtics mxtics ytics mytics
set xrange [0:30000]
set yrange [0:]
#set xtics 10
#set ytics 10

winding(x) = x / 1500
distortion(x) = 2 ** (x / 4500)
normal(x) = distortion(x) + winding(x)

motor = 5
boost = 45
startrpm = 5000
finishrpm = 25000

boost(x) = x < startrpm ? 0 : x >= finishrpm ? boost : boost*((x-startrpm)/(finishrpm-startrpm))

timing(x) = motor + boost(x)

plot normal(x) title "normal plane", timing(x) title "timing advance", abs(timing(x) - normal(x)) title "difference"

