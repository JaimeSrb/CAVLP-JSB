s.boot;

b = Buffer.read(s, "/Users/jaime/Downloads/18.wav");

(
SynthDef(\audio, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(1, b.bufnum, rate, 1, sp * b.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * b.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

Synth(\audio, [\rate,1, \sp, 0.2, \sus, 0.04]);

//RATE ES LA VELOCIDAD DE REPRODUCCIÓN
//SP ES LA PARTE DE LA CANCIÓN
//SUS ES LA DURACIÓN