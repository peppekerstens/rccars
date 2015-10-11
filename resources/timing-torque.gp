# http://gnuplot.respawned.com/
# Scale font and line width (dpi) by changing the size! It will always display stretched.
set terminal svg size 400,300 enhanced fname 'arial'  fsize 10 butt solid
set output 'out.svg'

# Key means label...
set key inside top right
set xlabel 'RPM'
set ylabel 'Torque'
set format y ""
set grid xtics mxtics ytics mytics
set xrange [0:30000]
set yrange [0:]

torque(x, stall, freerun) = stall + x * (-1.0 * stall) / freerun

plot torque(x, 1.0, 20000) title "low timing", \
     torque(x, 0.9, 25000) title "medium timing", \
     torque(x, 0.7, 30000) title "high timing"
