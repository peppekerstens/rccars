---
layout: page
title: Chargers
summary: The electricity has to come from somewhere!
---

Supported Battery Types
=======================

The first thing to look for in a charger is whether it supports the type of
battery you're going to be using. If you're buying a brand new charger and
batteries, it's likely to be all LiPo, but if you're buying used equipment, you
might stumble on NiCad/NiMH chargers, for example.

**DO NOT use a NiCad/NiMH charger with a LiPo battery!** These are liable to
over-charge, which can cause the pack to vent flammable electrolyte gas. Here's
a demonstration of what can happen when charging with a NiCad program:

<p><iframe class="youtube" width="420" height="315" src="//www.youtube.com/embed/YCWdnjLqVWw" frameborder="0" allowfullscreen></iframe></p>

If you take care of your batteries, you'll be fine, but I just want to impress
that it is essential to use a charger designed for LiPo. The good news is that
if you still have NiCad/NiMH batteries around, most LiPo chargers have charging
programs for them as well, so you can have one charger to do it all.

"C" Rating
==========

You might see things like 1C, 2C, 60C, and so on, and wonder what that's about.
This isn't Celsius degrees, but in the context of batteries, refers to an
amount of current that's relative to the capacity (hence the "C") of the
battery. So if you have a 5,500 milliamps/hour (5.5 amps/hour) battery, and it
says it is rated at 60C of output, it means that it can put out 330 amps of
current. Or if they say you should charge it at 1C, it means you should set
your charger at 5.5 amps.

Better quality batteries usually have higher "C" ratings for their output, as
it means they can feed more power to your motor when you accelerate hard.

Charging currents are also expressed in a similar way. 1C is the "standard"
charging current, with LiPo experts saying that 2C or even 3C should be okay
with the current hard-cased packs, in good condition (no cracks or other
damage), but the [BRCA](../brca/) dictates that no more than 1C should be used
at their events, for safety (since the danger with LiPo is mainly with
over-charging).

But when looking around for chargers and batteries, you might notice that
batteries now start at about 4,0000 mA/h, and can go all the way up to almost
8,000 mAh, but some cheaper chargers only go to 2.5A or 3A, which wouldn't be
sufficient to even reach the recommended 1C! There is no danger with that, but
charging at a lower current will take proportionally longer, so you might want
to make sure your charger can do at least 5 amps, to keep charging times
reasonable.

Balance Charging
================

On the [batteries page](../batteries/), I explained that battery packs have
some number of cells in them.

If your LiPo pack has more than one cell, it's important to use a "balance
charger". This is because each cell in the pack might not be performing
equally. A charger will send power until the voltage of the battery reaches a
certain level (usually 8.4V, in the case of a 2S LiPo), but since this voltage
is the sum of the cells voltage (because they are in series, "S"), it's
possible that one cell is slow to charge and has only 4V, and the other has
4.4V. Then, during the race, the weaker cell will run out of power earlier, and
your car will run on partial power (not quite fully drained, but clearly
slower), and that's no good!

Also, if you remember the warnings at the top, the main danger with LiPo is
over-charging, so if one of the two cells in your pack really gets out of
balance, it might become dangerous, as you good cell might get over-charged to
tried to make up for the weak one.

A balance charger has extra leads, so that cells can be measured and charged
individually. For example, a 2S pack has three connectors, big ones for each
ends, and a small one in the middle, which is used for balance charging.

There are some variations with those extra connectors, so make sure your
charger has the right leads for the batteries you will be using (ask your hobby
shop).

If you use 1S (single-cell) batteries, then you don't need balance charging, of
course, since there is nothing to balance. :-)

Connectors
==========

There's a few different types of battery connectors, and some that look very
similar (like barrel connectors, which come in 4mm and 5mm sizes!). Check that
you have the right leads for your battery (again, ask your hobby shop!).

Input Power
===========

It wasn't obvious to me at first, but some chargers connect to the mains for
power, and others use 12V, which can run off a car battery, but needs a power
supply to run off mains power.

When I was looking for a charger, I saw one with great specifications and
features that seemed like a great deal, but almost did not notice that it was
12V only! It looked like a "great deal", but I was comparing it to other
chargers with built-in mains power supplies, so really, the discount was
because it was missing a part I needed!

Storage Program
===============

I explained on the [batteries page](../batteries/) how to store batteries so
that they do not lose capacity over time, by leaving them half-charged. Some
chargers have a "storage" program designed to put the battery at the best level
for storage. I explained a technique to do this approximately, so this feature
isn't *required*, but it's definitely nice to have.

It's especially handy if you store batteries for a long time, you can simply
run them through the storage program every three months to make sure they
remain at a good level for storage (batteries slowly leak power, so even if it
was at a good level when you stored it, over time, it can go down to damaging
levels).
