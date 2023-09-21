Synth(\Sine)

Synth(\Tri)
(
Pdef(\sec, Pbind(\instrument,\tri, \dur, Pseq([0.5,0.25, 0.25], inf),\amp,0.3,\frec, Pseq([300, 400, 800, 890], inf)
)).play
);

(
Pdef(\sec2, Pbind(\instrument,\Sine, \dur, Pseq([0.5,0.25, 0.25], inf),\amp,0.3,\frec, Pseq([300, 400, 800, 890], inf)
)).play
);