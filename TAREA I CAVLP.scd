a=Synth(\misinte,[\frec, rrand(540,800)]);
a.free;
SynthDef.help;
Env.help;
Env.new([0,1,0.5,0.5,0],[0.1,0.1,0.1,0.5]).plot;
(
~sec1=Pdef(\sec,
	Pbind(\instrument,\misinte,
		\dur,Pseq([0.12,0.24,0.36,0.48,0.28,0.28,0.28,0.28,0.48,0.36,0.24,0.12], inf),
		\frec,Pseq([240,360,480,600,800,800,800,800,600,480,360,240],inf),
		\amp,1
	)
);
)

~sec1.play;
~sec1.stop;