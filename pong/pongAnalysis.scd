// s.options.inDevice_("UMC202HD 192k");

s.waitForBoot({
	//////////////////////////////////// synth def and busses
	~inputCount = 2;

	Bus.clear;
	// bus arrays, group per audio input
	~meterBusses = Array.new;
	~pitchBusses = Array.new;

	~inputCount.do{|i|
		~meterBusses = ~meterBusses.add(Bus.control(s, 1));
		~pitchBusses = ~pitchBusses.add(Bus.control(s, 1));
	};

	// Analyze audio features and copy them in control busses
	SynthDef(\audioAnalyzer, {
		|in=0, meterOut=0, pitchOut=0|

		var input, amp, pitch, hasFreq, minFreq, maxFreq;
		minFreq = 90;
		maxFreq = 800;
		input = SoundIn.ar(in);
		amp = Amplitude.kr(input, releaseTime: 0.1).lag;
		# pitch, hasFreq = Pitch.kr(input, minFreq:minFreq, maxFreq:maxFreq, downSample:2, median:10);

		Out.kr(meterOut, amp);
		Out.kr(pitchOut, (pitch * hasFreq / maxFreq).lag(1));
	}).add;


	s.sync;


	// Poll the value of a signal periodically, and send over the value via OSC.

	~uiMachine = NetAddr.new("127.0.0.1", 12000);

	~pitches = Array.newClear(~inputCount);
	SystemClock.sched(0.0,
		{

			var doneGettingPitch = false;
			~inputCount.do({|i|
				~pitchBusses[i].get({|val|
					~pitches[i] = val;
					~uiMachine.sendMsg("/audio/pitch", ~pitches[0], ~pitches[1]);
				};
				);
			});

			~meterBusses[0].get({|val|
				~uiMachine.sendMsg("/audio/amplitude", val, 1.0);
			};);

			0.01;
		};
	);

	~player1 = Synth(\audioAnalyzer, [\in, 0, \meterOut, ~meterBusses[0].index, \pitchOut, ~pitchBusses[0].index ] );
	~player2 = Synth(\audioAnalyzer, [\in, 1, \meterOut, ~meterBusses[1].index, \pitchOut, ~pitchBusses[1].index ] );
};
);


/*
~pitchBusses
~pitchBusses[1]
*/

