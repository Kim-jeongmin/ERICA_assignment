// guitar.ck 
MidiIn min; 
MidiMsg msg; 
0 => int port; 
if (!min.open(port)) { 
    <<< "Error: MIDI port did not open on port: ", port >>>; 
    me.exit(); 
} 
Mandolin guitar => dac; 
int note; 
float volume; 
while (true) { 
    min => now; 
    while (min.recv(msg)) { // noteOn = 144, noteOff = 128 
        if (msg.data1 == 144) { 
            Std.mtof(msg.data2) => guitar.freq; 
            msg.data3 / 127.0 => guitar.gain; 
            1 => guitar.noteOn; 
        } 
        else
            1 => guitar.noteOff; 
        
    }
}