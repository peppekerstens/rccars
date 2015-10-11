---
layout: page
title: "Motor Timing: Dynamic Timing (\"Boost\")"
summary: Understanding how to use dynamic timing (\"boost\") properly.
---

What little sense this article might have will be lost to you if you haven't
read about [how static timing ("blinky") works](../motor-timing-blinky/) first!

# No Compromise

So, setting the timing advance in blinky is a compromise between efficiency and
power, but what if we could have our cake, and eat it too? Remember the graph
of torque with low, medium, and high timing:

[<img width="100%" src="../../resources/timing-torque.svg" />](../../resources/timing-torque.svg)

You see where the lines cross, at about 7000 and 16000 RPM? What if we could
change the timing at these points? We'd get this torque curve instead:

[<img width="100%" src="../../resources/timing-boost-torque-simple.svg" />](../../resources/timing-boost-torque-simple.svg)

The best of all three! How does that reflect on the power curve?

[<img width="100%" src="../../resources/timing-boost-power-simple.svg" />](../../resources/timing-boost-power-simple.svg)

This is what dynamic timing ("boost") is all about: not having to compromise
anymore. As if that wasn't enough, this can be *more efficient* as well,
running the motor cooler! This is because when the RPM is low, the timing
advance is kept low, which is closer to the neutral plane, and when it rises,
it moves higher, "following" the neutral plane.

# Following the Neutral Plane

These few timing switching point is rather simplistic, and is similar to what
was in use in old ESCs which introduced dynamic timing. These older ESCs could
be a bit rough (notice the "notch" in the power curve, just above 15000 RPM),
but current ESCs are more sophisticated, able to apply timing advance
progressively and smoothly, starting and finishing at preset points.

What this gives you is the ability to keep the commutation close to the neutral
plane, even though the maximum amount of timing advance could be very high. For
example, compare these two, on the left is blinky with 50° of timing advance,
and on the right is boosted with 50° of final timing advance:

[<img width="49%" src="../../resources/timing-diff-blinky-high.svg" />](../../resources/timing-diff-blinky-high.svg)
[<img width="49%" src="../../resources/timing-diff-boost-low.svg" />](../../resources/timing-diff-boost-low.svg)

These both will have similar characteristics at high RPMs, but while blinky has
to "pay for it" at low RPMs (running inefficiently/hotter), the boosted setup
can "keep it cool" at low RPMs, while providing more power throughout the RPM
range.

When tuning for maximum power, though, this extra efficiency is taken advantage
of to get more output power for the same (high) power input (rather than less
input for the same output), so in practice, heat could be similar to blinky. As
well, at high timing advance values used, while correct start/finish settings
could run just fine, incorrect settings could generate a lot of heat. For
example, applying 60° at 25000 RPM in the graph above would be near maximum
efficiency, but if that same 60° was applied at 5000 RPM, that would be a very
large difference between commutation and the neutral plane, and would run very
hot! So monitor motor and ESC temperature carefully, especially when using high
timing advance values.

# Complicated or Simple?

In theory, it would be possible to use a dynamometer (called a "dyno", for
short) to fully test a motor, find exactly where the neutral plane is at every
RPMs, and program an ESC to produce the best timing advance throughout the RPM
range. As explained in the [Efficiency and
Power](../motor-timing-theory/#efficiency-and-power), that would still leave a
bit of tuning choices between efficiency and power.

This means that, in theory, once you have the correct settings, you might not
have to tweak them for track conditions or gearing, they would just be optimal!
This is unlike blinky, where different cornering speeds and gearing on
different tracks might require changing where the power peak is (by adjusting
the motor timing).

So, in a way, it's much simpler than blinky: *you set it once, and leave it*!

In practice, though, there's a few obstacles. Most racers don't test their
motors on dynos, we make educated guesses based on lap times and comparing
on-track behaviour to past experience. So you don't *know* what the neutral
plane is doing, you're just *guessing*, and instead of having just one dial
(the motor timing), you've got multiple parameters (start/finish RPM, maximum
timing advance, other settings for "turbo")...

On top of this, even if you have a dyno and know what the neutral plane is
really doing on your motor, the way most ESCs let you set up the timing advance
in a very simplistic way, which can only follow a linear curve (where the
neutral plane curve is something non-linear), so you could only approximate it
anyway.

I think that once a good set-up is found, though, it should be fairly stable,
from one track to another. So, it might be simpler in the long run, but it's
more complicated to get right in the first place.

# How?

Unfortunately for the simplicity of this explanation, there seems to be quite
some diversity in how ESC are set up. One ESC I used even had these five
cheerfully simple (but not very clear) settings: none, low, medium, high, very
high. To this day, I have no idea what it *really* did.

Most seems to have two different ways of applying additional timing, one based
on RPM, and another based on delays. The RPM way is typically called “boost”,
and the delay way is often called “turbo”.

## Boost

This is the simplest setting. On most ESCs, boost is controlled by three
settings: start RPM, finish RPM, and timing advance. The way it works is that
the ESC initially does not apply any additional timing, but when the start RPM
is reached, it starts adding timing progressively, in such a way that when the
finish RPM is reached, the set timing advance will have been added. Past the
finish RPM, no more timing is added (by the "boost", anyway, the "turbo" might
still add some, as we'll see later).

Here's a graph to explain this visually. In green, for comparison, is the
timing achieved by setting 40° of timing on the motor endbell in blinky. In
red, there is 5° of timing on the motor endbell, but in addition to that,
boost has been set, with a start RPM of 5000, a finish RPM of 25000, and a
timing advance of 45°:

[<img width="100%" src="../../resources/timing.svg" />](../../resources/timing.svg)

This is very straightforward, as it's entirely RPM-based (which, conveniently,
is what the neutral plane depends on!), time or delays have nothing to do with
it: if you rev your motor to 15000 RPM *and keep it there*, the timing advance
will be just under 28°, as long as you keep that RPM.

Some ESCs (notably, the LRP Flow) let you control the boost in a different way,
where you set the maximum timing advance, the start RPM, and the "boost angle".
That last setting lets you choose how much timing to add for each slice of some
RPMs. On the LRP Flow, it's per 1000 RPM. The boost works in exactly the same
way as the start/finish RPM way, it's only a different way of setting it. For
example, 2.5°/kRPM of boost angle starting at 5000 RPM will reach 45° at 23000
RPM (45 divided by 2.5, times 1000, plus the start RPM of 5000), giving nearly
the same thing as what's the in graph above.

A few ESC can let you set a completely arbitrary timing advance curve, using a
laptop, which could in fact let you program in the optimal timing advance
curve, if you had tested your motor on a dyno! But I suspect that if you're
guessing (like most of us), that would just be more complications for nothing
much.

## Turbo

I mentioned how the neutral plane advance is non-linear, but the boost on most
ESCs only offers a linear timing advance. This means that if you set it right
for high RPMs, you might have too much timing advance in the mid-range, and if
you cover the low- and mid-range well, the high end does not have enough. On
the left here it is set for low- and mid-range RPMs, on the right, it is set
for high RPMs:

[<img width="49%" src="../../resources/timing-diff-boost-low.svg" />](../../resources/timing-diff-boost-low.svg)
[<img width="49%" src="../../resources/timing-diff-boost-high.svg" />](../../resources/timing-diff-boost-high.svg)

Remember you want the smallest difference between commutation and timing
advance, so you see how on the left, at high RPMs, it all goes wrong, while the
one on the right is good at the top end, it's rather awful in the middle. It's
obvious from the shapes of the red and green lines that they just can't fully
match...

The way ESCs handle this currently is with so-called "turbo" (the name is
completely marketing, of course!). The idea is that the infield of a track is
more important, and having the best timing there is more critical, but on the
straight, it's a "simple matter" of top speed, so you can just "slam" the
timing. The straight being, well, straight, you can be a bit cruder and not as
smooth, as long as you get plenty of top speed!

So we'll set up the more progressive "boost" for the low- and mid-range, and
will rely on a cruder mechanism, "turbo", to get top end for the straight.

Turbo has a "trigger", based on some conditions that depend on the ESC. It can
be when full throttle is applied, when a certain RPM is reached, or both (when
full throttle is applied, but only above a certain RPM). On some ESCs, you can
choose, on others, there's only one way. For those that have an RPM-based
trigger, it sometimes is the finish RPM of the boost settings, or it can be a
separate setting. As long as that trigger isn't, well, triggered, *turbo does
nothing at all*.

Once the trigger condition is reached, what it does (again, on most ESCs) is
controlled by three settings: maximum timing advance, delay, and slew. The
timing advance is the simplest, being the maximum amount of timing advance.

The delay is an initial delay, between the trigger and the first application of
extra timing advance. That is, when turbo is triggered, it will *not do
anything* for that set amount of time. This is used to keep it from kicking in
mid-corner, where additional (or lowered) motor power could change the balance
of the car, but you'd still want to accelerate hard, hitting full throttle.

After the initial delay has passed, the timing advance is applied according to
the slew, which is usually set in "degrees per 0.1 second". For example, if you
set 10° of turbo with a slew of 2° per 0.1s, it will take half a second to get
the maximum 10° of timing advance. Some ESCs can set a "deactivation slew",
which work the opposite way (how quickly the turbo timing advance is taken
away).

# How They All Combine

One common source of confusion is on how do these all work together, and the
answer is really quite simple: **they add up**. The motor timing (on the
endbell) is always there, boost and turbo work *independently*, and they all
add up together to a total timing advance.

For example, if you have 20° on the motor, 35° of boost, and 20° of turbo, by
the time your car is at the end of the straight, assuming the motor is revving
above the boost finish RPM, that the turbo is still active (that you’re still
full throttle or above the activation RPM, or both), and that enough time has
passed for the slew to have given all the turbo timing advance, you’ll have a
full 75° of timing!

What’s great about this compared to blinky is that while you’d have 75° toward
the end of the straight, you could have as little as 20° while driving the
infield. If you’d set 75° on the motor in blinky, the motor would spend most of
its time running very inefficiently (as you’d be so far from the RPM at which
the switching point and the neutral plane are close together)... And smoke
would soon come out of it!

# How Do I Use This?

One thing often missed is that when using boost, the fixed timing advance on
the motor itself should be kept fairly low, and the ESC timing advance (boost
and turbo) should do most of the work. High fixed timing is a compromised
answer, which boost is precisely there to avoid!

As I mentioned earlier, once good boost settings are found for a given motor,
it should work on any track or gearing. In practice, different situations might
expose that a bit of additional fine tuning is necessary, of course, but
settings should carry from track to track without much change at all.

Turbo, on the other hand, is trickier. Picking the trigger settings would
definitely change based on the track, especially around the characteristics of
the straight line, whether there's a slow, tight corner before (with low RPMs
that would need a bit more time to build back up), or whether it's approached
by a fast bend (where less delay could be used, since the RPM would be higher),
and so on.

The slew is also difficult, because you're trying to match the neutral plane
curve, which is based on RPM, with an adjustment based on time. Too quickly
raising timing might provide the power hoped from turbo, but at too much of a
cost in efficiency, causing excess heat. The length of the straight line might
allow for more maximum timing than a shorter one, as well.

Gearing can also come into it, as a higher gearing (higher rollout, lower FDR)
would have RPM rise a bit more slowly, for example, so a gentler slew would be
more appropriate.

While boosted has the potential for running the motor and ESC cooler with
similar power when set up correctly, remember that the higher timing values can
mean a lot more heat, if they are not applied at the right RPM, so monitoring
heat is even more important than in blinky.
