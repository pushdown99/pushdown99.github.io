---
description: >
  This chapter shows how to upgrade Hydejack to a newer version. The method depends on how you've installed Hydejack.
hide_description: true
---

# Analog vs. Digital

{:.no_toc}
1. this unordered seed list will be replaced by toc as unordered list
{:toc}
![Screenshot](/assets/img/docs/analog_digital.png)

## Overview
We live in an analog world. There are an infinite amount of colors to paint an object (even if the difference is indiscernible to our eye), there are an infinite number of tones we can hear, and there are an infinite number of smells we can smell. The common theme among all of these analog signals is their infinite possibilities.

Digital signals and objects deal in the realm of the discrete or finite, meaning there is a limited set of values they can be. That could mean just two total possible values, 255, 4,294,967,296, or anything as long as it's not ∞ (infinity).
![analog_digital_example](/assets/img/docs/analog_digital_example.png)
```
Real-world objects can display data, gather inputs by either analog or digital means. 
(From left to right): Clocks, multimeters, and joysticks can all take either form (analog above, digital below).
```
Working with electronics means dealing with both analog and digital signals, inputs and outputs. Our electronics projects have to interact with the real, analog world in some way, but most of our microprocessors, computers, and logic units are purely digital components. These two types of signals are like different electronic languages; some electronics components are bi-lingual, others can only understand and speak one of the two.

In this tutorial, we'll cover the basics of both digital and analog signals, including examples of each. We'll also talk about analog and digital circuits, and components.

**Suggested Reading**  
The concepts of analog and digital stand on their own, and don't require a lot of previous electronics knowledge. That said, if you haven't already, you should peek through some of these tutorials:

* [Voltage](https://learn.sparkfun.com/tutorials/voltage-current-resistance-and-ohms-law), [Current](https://learn.sparkfun.com/tutorials/voltage-current-resistance-and-ohms-law), [Resistance and Ohm's Law](https://learn.sparkfun.com/tutorials/voltage-current-resistance-and-ohms-law)
* [What is a Circuit](https://learn.sparkfun.com/tutorials/what-is-a-circuit)
* And some mathematics concepts: reading graphs, and understanding the difference between finite and infinite sets.

## Analog Signals
**Define: Signals**  
Before going too much further, we should talk a bit about what a signal actually is, electronic signals specifically (as opposed to traffic signals, albums by the ultimate power-trio, or a general means for communication). The signals we're talking about are time-varying "quantities" which convey some sort of information. In electrical engineering the quantity that's time-varying is usually voltage (if not that, then usually current). So when we talk about signals, just think of them as a voltage that's changing over time.

Signals are passed between devices in order to send and receive information, which might be video, audio, or some sort of encoded data. Usually the signals are transmitted through wires, but they could also pass through the air via radio frequency (RF) waves. Audio signals, for example might be transferred between your computer's audio card and speakers, while data signals might be passed through the air between a tablet and a WiFi router.

### Analog Signal Graphs
Because a signal varies over time, it's helpful to plot it on a graph where time is plotted on the horizontal, x-axis, and voltage on the vertical, y-axis. Looking at a graph of a signal is usually the easiest way to identify if it's analog or digital; a time-versus-voltage graph of an analog signal should be smooth and continuous.
![analog_digital_example](/assets/img/docs/analog_signal.png)
While these signals may be limited to a range of maximum and minimum values, there are still an infinite number of possible values within that range. For example, the analog voltage coming out of your wall socket might be clamped between -120V and +120V, but, as you increase the resolution more and more, you discover an infinite number of values that the signal can actually be (like 64.4V, 64.42V, 64.424V, and infinite, increasingly precise values).

### Example Analog Signals
Video and audio transmissions are often transferred or recorded using analog signals. The [composite video](https://en.wikipedia.org/wiki/Composite_video) coming out of an old RCA jack, for example, is a coded analog signal usually ranging between 0 and 1.073V. Tiny changes in the signal have a huge effect on the color or location of the video.
![analog_digital_example](/assets/img/docs/analog_signal2.png)
Pure audio signals are also analog. The signal that comes out of a microphone is full of analog frequencies and harmonics, which combine to make beautiful music.
