s.options.inDevice = "UMC202HD 192k";  // mac only?
s.reboot;

//////////////////////////////////// synth def and busses
~inputCount = 2;

// bus arrays, group per audio input
~meterBusses = Array.new;
~pitchBusses = Array.new;

~inputCount.do{|i|
	~meterBusses = ~meterBusses.add(Bus.control(s, 1));
	~pitchBusses = ~pitchBusses.add(Bus.control(s, 1));
};

SynthDef(\audioAnalyzer, {
	|in=0, meterOut=0, pitchOut=0|

	var input, amp, pitch, hasFreq, maxFreq;
	maxFreq = 800;
	input = SoundIn.ar(in);
	amp = Amplitude.kr(input, releaseTime: 0.1).lag;
	# pitch, hasFreq = Pitch.kr(input, minFreq:90, maxFreq:maxFreq, downSample:2, median:10);

	Out.kr(meterOut, amp);

	Out.kr(pitchOut, (pitch * hasFreq / maxFreq).lag(1));
}).add;

// Poll the value of a signal periodically, and send over the value via OSC.


(
~uiMachine = NetAddr.new("127.0.0.1", 12000);

SystemClock.sched(0.0,
	{
		~meterBusses[0].get({|val|
			~uiMachine.sendMsg("/audio/amplitude", val, 1.0);
		};);

		~pitchBusses[0].get({|val|
			~uiMachine.sendMsg("/audio/pitch", val, 1.0);
		};);
		0.01;
	};
);

~player1 = Synth(\audioAnalyzer, [\meterOut, ~meterBusses[0].index, \pitchOut, ~pitchBusses[0].index ] );

)





