(
(
~sec1 = Pdef(\sec, Pbind(\instrument, \pulse,
	\dur, Pseq([0.5, 0.25, 0.25, Pn(0.125, 4), 1], inf),
	\amp, 0.12,
	\frec, Pseq([300, 400, 800, 790, Pn(350, 4), Pseq([400, 800, 400, 450], 3)], inf),
	\rel, 0.09
))
);

(
~sec2 = Pdef(\sec2, Pbind(\instrument, \tri,
	\dur, Pseq([0.5, 0.125, 0.125, 0.5, Pn(0.25, 2)], inf),
	\amp, 0.2,
	\frec, Pseq([330, 430, 200, 400, 350, 700, 876, 234], inf),
	\rel, 0.1
))
);

(
~sec3 = Pdef(\sec3, Pbind(\instrument, \wnoise,
	\dur, 0.125,
	\amp, Pseq([0.01, 0.02, 0.15, 0.01, 0.03, 0.02, 0.15, 0.01, Pseq([0.1, 0.12, 0.01, 0.15], 2)], inf),
	\at, 0.001, \rel, 0.1
))
);

(
~sec4 = Pdef(\sec4, Pbind(\instrument, \sine,
	\dur, 0.5,
	\amp, 0.7,
	\frec, 300,
	\at, 0.01, \rel, 0.01
))
);
);

~sec1.play.quant(4);
~sec2.play.quant(4);
~sec3.play.quant(4);
~sec4.play.quant(4);

~sec1.stop;
~sec2.stop;
~sec3.stop;
~sec4.stop;

s.quit;