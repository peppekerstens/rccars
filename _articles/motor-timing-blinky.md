---
layout: page
title: "Motor Timing: Static Timing (\"Blinky\")"
summary: Understanding how to set static timing ("blinky") in electric motors.
---

Before reading this article, you should read about the [theory of motor
timing](../motor-timing-theory/) first, or it might be a bit confusing!

# What is Static Timing?

Static timing is simply when your motor has a fixed amount of timing advance.
This is the only option for brushed motors (which are not capable of dynamic
timing), and is what happens when you set your ESC in what is called "blinky
mode". Why is it called "blinky"? Simply because dynamic timing is forbidden in
some racing classes, and most ESCs will have a light blinking when in that
mode, so that scrutineers can easily confirm the ESC settings.

Although a lot of people do not understand how timing works, static timing is
easy to set up, being usually set by loosening some screws on the motor, and
rotating the end bell (some motors, like the LRP X12, need special inserts, see
the instructions for your motor).

# Torque Curve and Timing

The torque curve for a motor with fixed timing couldn't be simpler: it's a
straight line! It's at its highest at zero RPM, which is sometimes referred to
as a motor's "stall torque". It then goes down in a straight line, until it
reaches zero torque, at what is called the "free-running RPM". Here's what the
torque curve looks like for a (fictional!) motor at three different timing
settings:

[<img width="100%" src="../../resources/timing-torque.svg" />](../../resources/timing-torque.svg)

You can see that the lower timing gives a higher stall torque (which should
translate in a higher acceleration from stopped), but it goes down quicker,
limiting the free-running RPM (which top speed depends on). Why is that?

If you remember from the theory, the commutation should be as close as possible
to the neutral plane for best results, and also, the neutral plane would be
lined up with the magnets at zero RPM, moving further as RPM increases. So it
makes sense that you get more torque with less timing, as the commutation is
done closer to the neutral plane. Effectively, for the maximum stall torque,
you'd set your timing advance to zero.

But unless you crash a lot, you should be starting from stopped very rarely,
ideally only once per race!

If you increase the timing advance, what happens is that while the switching at
zero RPM is now a bit further away from the neutral plane (so a lower stall
torque), now at the spot where the lower timing setup reached the free-running
RPM (where there's no torque left to make the motor go faster) is now switching
closer to the neutral plane, letting it go a bit further before running out of
steam.

# Power

Torque is just one part of power, the other is speed. So what does the power
curves for those same three timing advance settings look like?

[<img width="100%" src="../../resources/timing-power.svg" />](../../resources/timing-power.svg)

With the low timing, there's a bit more power initially, but it also peaks
earlier and lower than the medium timing, which has more power at higher RPMs.
And then, the high timing has a lower peak power than the medium (barely higher
than the low timing, even!), but it only goes down at a higher RPM.

Note how the peak power (which is what full size car manufacturers quote) with
higher timing is not necessarily higher than at lower timing. I sometimes hear
that "higher timing gives more power", but it's not as clear cut as that. At
lower RPMs, the high timing even has *less power*!

Exploiting the benefits of the additional power with the medium timing, one
might have to adjust the timing to bring that power peak where it is most
useful. For example, if you are using the medium timing, and the motor is in
the 5000 to 8000 RPM range while coming out of most corners of the infield, you
would be over-geared (rollout too high, FDR too low) and you should lower your
gearing so that in those places where you need the most power, the motor would
be in the 10000 to 15000 RPM range, where the power is!

# Efficiency

Remember from the theory that the whole point of timing advance is to try to
compensate for how the normal plane moves as RPM increases? And the closest to
the normal plane, the better? Well, let's look at what happens with the same
(fictional!) motor, with 20° and 50° of timing:

[<img width="49%" src="../../resources/timing-diff-blinky-low.svg" />](../../resources/timing-diff-blinky-low.svg)
[<img width="49%" src="../../resources/timing-diff-blinky-high.svg" />](../../resources/timing-diff-blinky-high.svg)

That "difference" line is how far the commutation is from the neutral plane, so
we want to keep it as small as possible, when it's big, it means inefficiency
and running hotter.

At 20°, the biggest difference between the normal plane and the switching is
20°. It might look like at high RPMs there would be a bigger difference, but
the trick is that the motor doesn't get to go that fast, so it never happens.

At 50°, on the other hand, the motor could actually reach those higher speeds,
and the switching time would be off by over 70°! Not only that, but at most of
the lower RPMs, the difference is much higher (which is why at higher timing,
the torque at lower RPM is not as good).

All of this means that at various times during the rotation, the motor is
working against itself, which makes it work harder, consume more current, and
gets hotter. This is why you can't just crank timing up all the way.

But interestingly, if you ran the motor at a steady 22000-23000 RPM, 50° of
timing advance would run *more efficiently than with only 20°, with more
power*! It might run about as hot, because the current would still be higher,
but you'd get more output power for the same current. For racing cars on
circuits, it's not that useful, but on big enough ovals, the RPMs are steadier.
This is also useful for model planes.

# How Do I Use This?

For blinky, it's a compromise: lower timing will move the power band to lower
RPMs, letting you push out of low speed corners harder, but with the power band
higher, it allows a higher maximum RPM, which translate into higher top speed.

The [Power](#power) section above explains how gearing might have to be
adjusted to best benefit from the peak power.

One problem in blinky is heat management. With a fixed higher timing, the motor
spends more time running at less efficient RPMs, which translates to more heat
being generated. And not only can extremely high heat actually melt solder
joints inside the motor, or otherwise damage components, but it takes even less
to cause the rotor magnets to lose their field strength. That's right,
overheating your motor will make it weaker! Ideally, it should not exceed 80°C,
100°C might lose some of the magnet strength, and 120°C will turn it into a
paperweight.

So, when tuning timing, pay close attention to motor temperatures!

## Practical Notes

One slightly less theoretical note: motor manufacturers put markings on their
motors, and while they are usually correct in terms of their size, their
starting point is notoriously variable from one brand to the next, and
sometimes between different models within a brand! For example, the Reedy Sonic
Mach 2 has been found to have approximately 10-12° of timing advance compared
to the Sonic Mach (previous model). This means that 20° on the new model would
be the equivalent of 30-32° on the old model! This means that comparing
different models of motors and seeing that "the timing advance goes further",
for example, up to 40° on a Reedy, but up to 60° on a Trinity, is meaningless.
The Trinity might just have its zero setting 20° earlier than the Reedy, making
their "maximum timing" equal (maybe)...

Also, the sensor boards sometimes have a bit of variation in their
manufacturing, from one motor (of the same model) to the other. So if you have
two "identical" motors, set to the same timing mark on the endbell, their real
timing advance might be fairly different! Instruments such as a [G-Force motor
analyzer](http://www.gforce-hobby.jp/products-en/G0107.html) can be used to
measure the real timing advance.

### Next Part

Go on to see how [boosted timing works](../motor-timing-boost/)!
