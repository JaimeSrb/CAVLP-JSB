
s.boot;

(

// --- Onda sinuidal (sine)
(
SynthDef(\sine, {|freq=440, pan=0, at=0.01, rel=0.1, amp=0.5, out=0|
	var sen, paneo, env;
	sen=SinOsc.ar(freq, 0, amp);
	paneo=Pan2.ar(sen, pan);
	env=EnvGen.kr(Env.new([0,1,0], [at, rel]), doneAction:2);
	Out.ar(out, paneo * env)
}).add
);

// --- Onda triangular (tri)
(
SynthDef(\tri, {|freq=440, pan=0, at=0.01, rel=0.1, amp=0.5, out=0|
	var sen, paneo, env;
	sen=LFTri.ar(freq, 0, amp);
	paneo=Pan2.ar(sen, pan);
	env=EnvGen.kr(Env.new([0,1,0], [at, rel]), doneAction:2);
	Out.ar(out, paneo * env)
}).add
);

// --- Onda cuadrada (pulse)
(
SynthDef(\pulse, {|freq=440, pw=0.5, pan=0, at=0.01, rel=0.1, amp=0.5, out=0|
	var sen, paneo, env;
	sen=Pulse.ar(freq, pw, amp);
	paneo=Pan2.ar(sen, pan);
	env=EnvGen.kr(Env.new([0,1,0], [at, rel]), doneAction:2);
	Out.ar(out, paneo * env)
}).add
);

// --- Onda diente de sierra (saw)
(
SynthDef(\saw, {|freq=440, pan=0, at=0.01, rel=0.1, amp=0.5, out=0|
	var sen, paneo, env;
	sen=Saw.ar(freq, amp);
	paneo=Pan2.ar(sen, pan);
	env=EnvGen.kr(Env.new([0,1,0], [at, rel]), doneAction:2);
	Out.ar(out, paneo * env)
}).add
);

// --- ruido blanco (white noise)
(
SynthDef(\wnoise, {|pan=0, at=0.01, rel=0.1, amp=0.5, out=0|
	var sen, paneo, env;
	sen=WhiteNoise.ar(amp);
	paneo=Pan2.ar(sen, pan);
	env=EnvGen.kr(Env.new([0,1,0], [at, rel]), doneAction:2);
	Out.ar(out, paneo * env)
}).add
);

// --- onda sinuidal con envolvente de frecuencia
(
SynthDef(\sine2, {|frec=440, pan=0, at=0.01, rel=0.1, amp=0.5, out=0|
	var sen, paneo, env;
	sen=EnvGen.kr(Env.new([frec, frec * 1.02, frec * 1.12, frec], [0.1, 0.1, 3]), doneAction:0);
	sen=SinOsc.ar(sen, 0, amp);
	paneo=Pan2.ar(sen, pan);
	env=EnvGen.kr(Env.new([0,1,0], [at, rel]), doneAction:2);
	Out.ar(out, paneo * env)
}).add
);

// Procesamineto de señal y efectos =======

// --- Reverberación - bus 9
(
SynthDef(\rev, {|in = 9, mix = 0.4, room = 0.9, damp = 0.1, amp = 1, gate = 1, out = 0|
	var sen, env;
	sen = FreeVerb.ar(InFeedback.ar(in, 2), mix, room, damp, amp);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.1), gate, doneAction: 0);
	Out.ar(out, sen * env);
}).add
);

// --- Delay - bus 11, mdt = maxdelayTime, dt = delayTime, dct = decayTime
(
SynthDef(\dly, {|in = 11, mdt = 0.3, dt = 0.25, dct = 2, gate = 1, out = 0|
var del, env;
	del = CombL.ar(InFeedback.ar(in, 2), mdt, dt, dct);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, del * env);
}).add
);

// --- Filtro pasa bajos (lpf) - bus 13
(
SynthDef(\lpf, {|in = 13, cfl = 100, gate = 1,  out = 0|
	var lpf, env;
	lpf = LPF.ar(InFeedback.ar(in, 2), cfl, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, lpf * env);
}).add
);

// --- Filtro pasa altos (hpf) - bus 15
(
SynthDef(\hpf, {|in = 15, cfh = 1000, gate = 1, out = 0|
	var hpf, env;
	hpf = HPF.ar(InFeedback.ar(in, 2), cfh, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, hpf * env);
}).add
);

// --- Filtro pasa banda (bpf) - bus 17
(
SynthDef(\bpf, {|in = 17, cfb = 1000, rq = 1, gate = 1, out = 0|
	var bpf, env;
	bpf = BPF.ar(InFeedback.ar(in, 2), cfb, rq, 1);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.01), gate, doneAction: 0);
	Out.ar(out, bpf * env);
}).add
);

);

// EFECTOS
(
~rev=Synth(\rev); // 9 Reverberación
~dly=Synth(\dly); // 11 Delay
~lpf=Synth(\lpf); // 13 Low Pass Filter
~hpf=Synth(\hpf); // 15 High Pass Filter
~bpf=Synth(\bpf); // 17 Band Pass Filter
);


//SINTES
b = Buffer.read(s, "/Users/jaime/OneDrive/Escritorio/E.wav");

(
SynthDef(\E, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(1, b.bufnum, rate, 1, sp * b.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * b.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

Synth(\E);



//SECUENCIAS
TempoClock.tempo=60/60;

(// puede comentar esta línea depués de declarar las secuencias para declarar individualmente
(
~sec1 = Pdef(\sec, Pbind(\instrument, \pulse,
	\dur, Pseq([0.28, 0.28, 0.34, 0.48, 0.60, 0.80, 0.80, 0.88, Pn(0.125, 4), 1], inf),
	\amp, 0.10,
	\freq, Pseq([400, 400, 600, 600, 800, 800, Pn(350, 4), Pseq([800, 800, 600, 600, 400, 400], 4)], inf),
	\rel, 0.09,
	\out, 0
))
);

(
~sec2 = Pdef(\sec2, Pbind(\instrument, \tri,
	\dur, Pseq([0.5, 0.125, 0.125, 0.5, Pn(0.25, 2)], inf),
	\amp, 0.8,
	\freq, Pseq([320, 320, 380, 400, 420, 460, 800, 800], inf),
	\rel, 0.1,
	\out, 0
))
);

(
~sec3 = Pdef(\sec3, Pbind(\instrument, \wnoise,
	\dur, 0.125,
	\amp, Pseq([0.01, 0.02, 0.15, 0.01, 0.03, 0.02, 0.15, 0.01, Pseq([0.1, 0.12, 0.01, 0.15], 2)], inf),
	\at, 0.001, \rel, 0.1,
	\out, 0
))
);

(
~sec4 = Pdef(\sec4, Pbind(\instrument, \sine,
	\dur, 0.6,
	\amp, 0.1,
	\freq, 600,
	\at, 0.12, \rel, 0.12,
	\out, 0
))
);

(
~son1 = Pdef(\son1, Pbind(\instrument, \E,
	\dur, Pseq([0.25, 0.125, 0.125], inf),
	\sus, Pseq([0.048, 0.028], inf),
	\rel, Pseq([0.2, 0.1, 0.1, 0.02], inf),
	\rate, Pseq([1, 1, 1.48, 1.6, 1.8, 1], inf),
	\sp, Pseq([0.4, 0.6, 0.8, 0.1, Pn(0.2, 4)], inf),
	\amp, 0.6,
	\out, 0
))
);
);

~sec1.play.quant(4);
~sec2.play.quant(4);
~sec3.play.quant(4);
~sec4.play.quant(4);
~son1.play.quant(4);

Pbindef(\sec, \freq, Pseq([280, 400, 1000, 400, Pn(340, 8), Pseq([600, 400, 480, 800], 4)].pyramid, inf));
Pbindef(\sec4, \dur, Pseq([0.400, 0.128, 0.4, 0.6, 0.8], inf), \freq, Pseq([300, 375, Pn(400, 4)], inf));

// modificación de efectos
~rev.set(\mix, 0.12, \room, 0.8, \damp, 0.8);
~dly.set(\dt, 0.28, \dct, 18, \out, 0);
~lpf.set(\cfl,840);
~hpf.set(\cfh, 1000);
~bpf.set(\cfb,800);

~sec1.stop;
~sec2.stop;
~sec3.stop;
~sec4.stop;
~son1.stop;

s.quit;