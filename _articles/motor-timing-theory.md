---
layout: page
title: "Motor Timing: Theory"
summary: Understanding what timing does in electric motors.
---

To understand how to set motor timing works, first, you need to understand a
bit of the theory. Sorry about that, but I’ll try to make it as simple as
possible!

# Basic Principles

Modern electric motors are driven by electromagnets (coils) pushing or pulling
permanent magnets, as current is sent through them in one direction, then the
other. This animation shows the pushing and pulling forces as
arrows from each of the three fixed coils (called "stator", as opposed to the
moving "rotor" at the centre):

[![Vectors from 3 phase coils](../../resources/3phase-rmf-noadd-60f-airopt.gif)](https://commons.wikimedia.org/wiki/File:3phase-rmf-noadd-60f-airopt.gif)

As is obvious from looking at this, the timing of when each stator should be
pushing or pulling is quite important! Changing the direction of the current is
called the "commutation", and on a brushed motor, this is done by the
"commutator", which has an easy job of getting that timing right, since
attached to the rotor. In a brushless motor, this is all done by the ESC (which
is why sensored ESCs are better and don't have "cogging", because they don't
have to guess where the rotor is, which sensorless ESCs have to do, and it can
even go backward a bit when it gets it wrong!).

So, to get the most power, each stator should pull until the magnet is in front
of them, then switch over to pushing (commute) until it's on the other side of
it. This spot where it's the best moment to switch, is called the "neutral
plane". It's interesting to note that both switching too early and too late are
about equally bad, causing the motor to *waste energy in the form of heat*! And
too much heat (somewhere above 90° Celcius) can cause magnets to lose their
magnetism, making the motor weaker...

So we just need to do the commutation when the rotor passes the neutral plane,
right? Easy! Unfortunately, things are not that simple...

# Winding Time

The first complication is called "winding time". This is the time it takes for
the coils to switch between pushing and pulling. That time is *constant for a
given motor* (it's equal to the inductance of the coils divided by their
resistance, if you have to know).

The problem this causes is that even though it is very quick, it has a bigger
and bigger impact as RPM increases. For example, let's say that it is 0.3
thousandth of a second (very quick!), this would mean that at 1000 RPM, the
rotor would move by 1.8° in that time (barely worth mentioning), but at 10000
RPM, the rotor would have had time to move 18°, and at 20000 RPM, 36°!

> 60 seconds in a minute divided by 1000 revolution per minute is 0.06 seconds
> per revolution. 0.0003 seconds divided by 0.06 seconds is 0.005, times 360°,
> is 1.8°.

This means that if you do the commutation when the rotor is *right* on the
neutral plane, when the motor is running at 20000 RPM, by the time the coils
are energized in the other direction, the rotor will be 36° (1/10th of a
revolution!) past the neutral plane, which isn't very good!

# Field Distortion

When the motor is spinning under the effect of the coils, a funny thing happens
to the magnetic field of the magnets: it become distorted, *moving the neutral
plane around*! See those (simplified!) diagrams (by
"[Borb](https://commons.wikimedia.org/wiki/User:Borb)"), where on the left is
when stopped, and on the right, when spinning:

[<img width="49%" src="../../resources/Dynamo_-_commutating_plane_idealized.svg" />](https://en.wikipedia.org/wiki/File:Dynamo_-_commutating_plane_idealized.svg)
[<img width="49%" src="../../resources/Dynamo_-_commutating_plane_field_distortion.svg" />](https://en.wikipedia.org/wiki/File:Dynamo_-_commutating_plane_field_distortion.svg)

This effectively moves the neutral plane by some arbitrary amount that depends
on the speed the motor is going (more RPM, more distortion), *in addition* to
the effect of the winding time.

As opposed to the winding time, which is fixed, the amount of field distortion
is much more difficult to estimate, and while it increases with speed, it might
not necessarily be linear (twice as fast would not be twice the distortion
effect), and those characteristics would depend on the motor design.

# Timing Advance

To counteract these effects, we apply "timing advance" (often just called
"timing", because the opposite, timing retardation, is rarely used). Timing
advance is simply doing the commutation earlier than when the magnet is in
front of the coils.

If we consider only winding time, from our earlier example which took 36° to
change direction at 20000 RPM, if you wanted to cancel out that effect, you
would set 18° (half of it), so that the commutation would be centered at that
RPM. In reality, you'd want more timing advance than that, to take into account
the field distortion as well, of course.

# Efficiency and Power

So, ideally, the commutation would be aligned with the neutral plane, right?

You remember the winding time? This is the time it takes for the current to
change direction in the coils, and since it takes some time, you can guess that
it's really something progressive: the current fades down to zero, then rises
(in the other direction).

This brings the question, which part of this process do you want to align with
the neutral plane? When it starts, when the current is zero, or when the coils
are re-energized?

The answer is, frustratingly, "it depends". If it's done when at zero, it will
be most efficient, but if it's done in the earlier phase of the process, there
will be more power output. Isn't that the same, power and efficiency? Not
precisely: being efficient might have a bit less output power, but will consume
less supplied power to produce it. For example, the more powerful setting could
have 5% more power output, but consume 10% more input power.

In spec racing, you might want to optimise for higher power, while in modified
racing, you could have a motor that has plenty of power, but you might want to
optimise it for efficiency (improving the runtime, and keeping the motor
cooler).

# Heat and Ripple Current

Speaking of keeping the motor cooler, where does heat come from? Heat is caused
by the resistance of a conductor, which turns some of the current into heat.
The amount of heat released is the resistance multiplied by the current squared
(so *twice* the current will release *four times* the heat), so the amount of
heat for a given motor (since the resistance of its coils doesn't change) is
largely a factor of how much current goes through it.

And that's where timing comes in: when a motor may seem to consume a certain
amount of current, this is really the *average current*, because as the
commutation happens, current goes down, back up, and so on. This is called
ripple current (as it looks like the ripples on water), and the problem is that
the least efficient a motor is, the higher the ripples are.

Since the heat produced is relative to the square of the current, that means
that an increase in ripple current will produce more heat, even though the
average current might be barely higher.

# A Common Misunderstanding

One thing that's interesting to note here: it's **not** high timing that causes
heat, it's doing the commutation *out of alignment* with the neutral plane.
This could equally be **insufficient** timing advance, just as much as it could
be excessive timing advance!

At a high RPM, due to the winding time and field distortion, the neutral plane
has advanced, and low timing could produce *more heat than a high timing*.

I believe the reason high timing usually causes motors to run hot is that they
do not actually spend most of their time near the top of their RPM range, that
only happens at some point on the straight line of a track, say. But the rest
of the time (most of the lap!), in the infield, the RPMs are lower, and the
commutation is done further from the neutral plane, so a lot of heat is
generated. On a large oval track, though, where there is consistently high
RPMs, a higher timing advance could possibly be afforded without much ill
effect.

### Next Part

Go on to see [how this is used in blinky](../motor-timing-blinky/)!
