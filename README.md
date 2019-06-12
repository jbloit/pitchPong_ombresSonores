# Pitch Pong & Audio Shadows

Interactive installation, showing animation of vocal features. It consists of 2 games, displayed alternatively after a fixed time interval.

- Pitch Pong: the classiv Pong game, where each pad is controlled with the voice pitch.
- Audio Shadows: display the user shadow and replace the head with an animation that changes either with Loudness or Timbral features (voiced factor).

## System setup for the exhibition

- Install Processing v3

- Disable Visual Effects on windows 7: Press start, and in the search box, type "SystemPropertiesPerformance". Then unselect all the option.

- Install [Kinect for Windows SDK v1.8](https://www.microsoft.com/en-us/download/details.aspx?id=40278)


## Scripts to run on startup

- processing: ./pongShadows/Main/Main.pde
  this script has both games in it, and switches from one to the other after some time.
- supercollider: ./pong/pongAnalysis.scd
  this is the audio analysis script




