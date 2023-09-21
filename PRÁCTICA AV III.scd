// Creación audiovisual con lenguajes de programación sesión 3

// prendemos supercollider
s.boot;
// apagamos supercollider
s.quit;

// medidores
s.meter;
s.scope;
s.freqscope;

// SynthDef

(
SynthDef(\misinte,{|frec=440, amp=0.5|
	var sen, env;
	sen=SinOsc.ar(frec, 0, amp);
	env=EnvGen.kr(Env.new([0,1,0],[0.1,0.1]),doneAction:2);
	Out.ar(0, sen*env)
}).add
);

// Llamar a un SynthDef
a=Synth(\misinte,[\frec, rrand(540,800)]);

// liberar un Synth
a.free;

// ayuda de SynthDef
SynthDef.help;

// envolvente

// Pdef o definicón de patrón

//Envolventes
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


































