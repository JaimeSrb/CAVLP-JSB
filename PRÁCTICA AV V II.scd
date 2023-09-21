(
~son1 = Pdef(\son1, Pbind(\instrument, \audio,
	\dur, Pseq([0.60, 0.40, 0.125], inf),
	\sus, Pseq([0.02, 0.02], inf),
	\rel, Pseq([0.2, 0.1, 0.01, 0.02], inf),
	\rate, Pseq([1, 1, 1, 1, 1], inf),
	\sp, Pseq([0, 0.5, 0.75, 0.1, Pn(0.2, 4)], inf),
	\amp, 0.8
))
);

~son1.play.quant(1);
~son1.stop;

s.quit;