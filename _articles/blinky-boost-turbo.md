---
layout: page
title: Timing, Blinky, Boost, and Turbo
summary: Static and dynamic timing for brushless motors.
---

To understand how motor timing works, first, you need to understand a bit of
the theory. Sorry about that, but I'll be trying to make it as simple as
possible!

# Theory

Coils are energized to pull/push the magnets in the rotor. As the rotor turns,
there's a point called the *neutral plane*, where the torque goes down to zero
(this is similar to when the piston is at the top or bottom in an internal
combustion engine), and which is the ideal moment for the power to the coils
being switched around.

But when the motor is spinning, there's a funny thing that happens where the
magnetic fields get distorded, moving the neutral plane around. See those
(simplified!) diagrams (by
"[Borb](https://commons.wikimedia.org/wiki/User:Borb)"), where on the left is
when stopped, and on the right, when spinning:

[<img width="49%" src="../../resources/Dynamo_-_commutating_plane_idealized.svg" />](https://en.wikipedia.org/wiki/File:Dynamo_-_commutating_plane_idealized.svg)
[<img width="49%" src="../../resources/Dynamo_-_commutating_plane_field_distortion.svg" />](https://en.wikipedia.org/wiki/File:Dynamo_-_commutating_plane_field_distortion.svg)

Now, switching the power to the coils slightly too early or too late isn't the
end of the world, but it is less efficient, and will not provide as much
instantaneous torque.

The timing advance is by how much the point where the power is switched
compared to the normal neutral plane (where it's stopped). This means that, in
theory, 0° of timing is most efficient at zero RPM (when starting off).

With an ESC in "blinky" mode (or with a brushed motor), timing is static: you
set it, and that's that.

This means that it's fundamentally a compromise, as the revs build up, the
motor will get increasingly more efficient as the neutral plane approaches the
timing setting, and loses efficiency as it goes past it. So what you're trying
to do is to set the timing to be as efficient as possible for most of the lap.

With brushless motors, the switching is done electronically by the ESC, which
allows a "magic" trick: the timing can be changed dynamically while the motor
is running. In theory, this is possible with any brushless motor, but in
practice, it works best with sensored systems. This is called "boost" or
"turbo".

This means that the timing can be adjusted to try to keep the switching point
as close to the neutral plane as possible, keeping the motor operating at a
high efficiency. This doesn't make the motor more powerful (you need different
magnets or winding for that!), but it means that you can get more out of it,
more of the time, as it can run more efficiently.

# Blinky Setup

In blinky mode, the ESC does nothing, it's all set on the motor itself, usually
by loosening some screws on the endbell, turning it about, and re-tightening
the screws (on some motors, the timing is set by replacing an insert that
aligns the sensor board).

In the following graph, you can see the overall power band curve, and while
it's actually a bit more complicated (because power is torque multiplied by
RPM, etc), at 12500 RPM, the neutral plane would be close to the switching
point:

<img width="100%" src="../../resources/motor_power.jpg" />

As you increase or lower the timing, it moves around the RPM at which the motor
is most efficient (where the neutral plane is closest to the switching point):
lower timing moves it to lower RPMs, and higher timing to higher RPMs. So what
you're looking for is trying to match the timing to the RPMs the motor is
spending most time at. For example, in the graph above, if you expect your RPM
to be closer to 10000, you might lower the timing just a bit. On a high speed
track, you might increase it.

Very low timing is usually not very good in blinky, because it would mostly
help at a very low RPM, so unless you crash and need to start off a lot, you'll
want a bit of timing. Likewise, setting the timing very high might push the
RPMs at which it is most efficient at ranges only attained on a long straight,
which wouldn't be too helpful for most of the lap, or even *past the maximum
RPM* of the motor.

The choice of timing is also affected by your gearing. A slower gearing (lower
rollout or higher FDR) will have the motor revving more for the same speed, and
the opposite with a faster gearing.

# Open ESC Setup

Unfortunately for the simplicity of this explanation, there seems to be quite
some diversity in how ESC are set up. One ESC I used even had these five
cheerfully simple (but not very clear) settings: none, low, medium, high, very
high. To this day, I have no idea what they *really* did.

Most seems to have two different ways of applying additional timing, one based
on RPM, and another based on delays. The RPM way is typically called "boost",
and the delay way is often called "turbo".

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
red, there is 20° of timing on the motor endbell, but in addition to that,
boost has been set, with a start RPM of 5000, a finish RPM of 20000, and a
timing advance of 35°:

<img width="100%" src="../../resources/timing.svg" />

From 0 to 5000 RPM, it's just the motor timing at work, a bit similar to
blinky. But from 5000 and on to 20000 RPM, 35° timing is applied progressively.
This timing is in addition to the motor timing, so by the time 20000 RPM is
reached, that amounts to 55° of total timing.

One thing to understand with this time of RPM-based timing advance is that time
or delays have nothing to do with it: if you rev your motor to 10000 RPM *and
keep it there*, the timing will be just under 32°, as long as you keep that RPM.

Some ESCs (notably, the LRP Flow) let you control the boost in a different way,
where you set the maximum timing advance, the start RPM, and the "boost angle".
That last setting lets you choose how much timing to add for each slice of some
RPMs. On the LRP Flow, it's per 1000 RPM. The boost works in exactly the same
way as the start/finish RPM way, it's only a different way of setting it. For
example, 2.5°/kRPM of boost angle starting at 5000 RPM will reach 35° at 19000
RPM (35 divided by 2.5, times 1000, plus the start RPM of 5000), giving nearly
the same thing as what's the in graph above.

## Turbo

That one is a bit peculiar, because it is based on applying extra timing after
certain delays (the confusion between "time" and "timing" is tricky, in
particular!), once certain conditions have been met. Those condition vary
between ESCs, or are even configurable. The exact settings available also vary,
so bear this in mind, and refer to your ESC manual to see what's available.

Turbo is usually activated either when full throttle is applied, when a certain
RPM is reached, or both (when full throttle is applied, but only above a
certain RPM). On some ESC, you can choose, on others there's only one way. For
those that support RPM based activation, it sometimes is the finish RPM of the
boost settings, or it can be a separate setting.

Once the turbo activates, what it does is controlled by three settings: timing
advance, delay, and slew. Timing advance is the simplest, being the maximum
amount of extra timing that will be applied.

The delay is an initial delay, between the activation and the first application
of extra timing. That is, even when the turbo is activated, *it does nothing*
for that set amount of time. This is usually to keep it from kicking in
mid-corner, where additional (or lowered) motor efficiency could change the
balance of the car.

After the delay has passed, the timing advance is applied according to the
slew, which is usually set in "degrees per 0.1 second". For example, if you set
10° of turbo with a slew of 2° per 0.1s, it will take half a second to give
that 10°. Some ESCs can set a deactivation slew, which works the opposite way
(how quickly the extra timing is taken away).

## How They All Combine

One common source of confusion is on how do these all work together, and the
answer is really quite simple: **they add up**. The motor timing (on the
endbell) is always there, boost and turbo work *independently*, and they all
add up together.

For example, if you have 20° on the motor, 35° of boost, and 20° of turbo, by
the time your car is at the end of the straight, assuming the motor is revving
above the boost finish RPM, that the turbo is still active (that you're still
full throttle or above the activation RPM, or both), and that enough time has
passed for the slew to have given all the turbo timing advance, you'll have a
full 75° of timing!

What's great about this compared to blinky is that while you'd have 75° toward
the end of the straight, you could have as little as 20° while driving the
infield. If you'd set 75° on the motor in blinky, the motor would spend most of
its time running very inefficiently (as you'd be so far from the RPM at which
the switching point and the neutral plane are close together)...

# How Do I Use This?

## Blinky

For blinky, it's a compromise: lower timing will move the power band to lower
RPMs, letting you push out of low speed corners harder, but with the power band
higher, it allows a higher maximum RPM, which translate into higher top speed.

One problem in blinky is heat management. With a fixed higher timing, the motor
spends more time running at less efficient RPMs, which translates to more heat
being generated. And not only can extremely high heat actually melt solder
joints inside the motor, or otherwise damage components, but much lower
temperatures will cause the rotor magnets to lose their field strength. So
overheating your motor will make it weaker. Ideally, it should not exceed 80°C,
100°C might lose some of the magnet strength, and 120°C will turn it into a
paperweight.

So when tuning timing, pay close attention to motor temperatures!

## Open ESC ("Boosted")

The challenge in boosted setup is to match the ramping of timing to follow the
change in the neutral plane as RPM goes higher. I'm still researching this, so
watch this space! 😉
