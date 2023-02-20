0.25::second => dur beat;
beat / 4 => dur rest;
beat - rest => dur qn; // quarter note
beat * 2 - rest => dur hn; // half note
beat * 3 - rest => dur dhn; // dotted half note
beat / 2 - rest => dur en;
beat / 2  * 3 - rest => dur dqn;

// melody for sunshine
[
60,64,67,    67,67,       64,65,67,64, 60,60,
72,71,72,69, 67,69,67,64, 72,71,72,69, 67,69,67,64,
69,69,67,67, 64,64,67,67, 62,60,62,64, 60,60
] @=> int melody[];

SinOsc s1 => dac;
SinOsc s2 => dac;
SinOsc s3 => dac;
SinOsc s4 => dac;
[s1,s2,s3,s4] @=> SinOsc quartet[];


[48,51,55,60] @=> int C[];
[48,53,57,60] @=> int F[];
[50,53,55,59] @=> int G7[];

// chord for sunshine
[
C,C,C,    C,C,      C,C,C,C,      C,C,
F,F,F,F,  C,C,C,C,  F,F,F,F,      C,C,C,C,
F,F,C,C,  C,C,C,C,  G7,G7,G7,G7,  C,C
] @=> int chords[][];

// tempo for sunshine
[
dqn,en,hn,    hn,hn,       qn,qn,qn,qn,  hn,hn,
qn,qn,qn,qn,  qn,qn,qn,qn, qn,qn,qn,qn,  qn,qn,qn,qn,
qn,qn,qn,qn,  qn,qn,qn,qn, dqn,en,qn,qn, hn,hn
] @=> dur durs[];

fun void setMIDInote(Osc osc, int note, float vol) {
    if (0 <= note <= 127) {
        Std.mtof(note) => osc.freq;
        vol => osc.gain;
    } else
        0.0 => osc.gain;
}

fun void setChord(SinOsc osc[], int chord[], float vol) {

    for (0 => int i; i < osc.size(); i++){
        setMIDInote(osc[i], chord[i], vol/4);
    }
}

Wurley s => dac;

for (0 => int i; i < melody.size(); i++) {

    if (0 <= melody[i] <= 127) {
        Std.mtof(melody[i]) => s.freq;
        0.2 => s.gain;
    } else
        0.0 => s.gain;
    setChord(quartet, chords[i], 0.6);

    1 => s.noteOn;
    durs[i] => now;
    1 => s.noteOff;
    rest => now;


}