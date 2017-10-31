import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
import ddf.minim.analysis.*;
import javax.sound.sampled.*;

class Sound {

  Minim minim;
  Mixer.Info[] mixerInfo;
  AudioOutput output;
  FilePlayer sound;
  BeatDetect beat;
  BeatDetect beat_bar;

  LowPassFS cbf;
  Delay delay;
  BitCrush bitCrush;


  float cutoffFreq = 6110;
  float ripplePercent = 0;
  float eRadius;
  float amplitude;
  float kickSize, snareSize, hatSize;
  boolean changeSound = false;

  class BeatListener implements AudioListener
  {
    private BeatDetect beat;
    private AudioOutput source;
    
    BeatListener(BeatDetect beat, AudioOutput source)
    {
      this.source = source;
      this.source.addListener(this);
      this.beat = beat;
    }
    
    void samples(float[] samps)
    {
      beat.detect(source.mix);
    }
    
    void samples(float[] sampsL, float[] sampsR)
    {
      beat.detect(source.mix);
    }
  }
  BeatListener bl;


  public Sound(PApplet parent)
  {
    this(parent, SOUND);
  }

  public Sound(PApplet parent, String pathToSoundFile)
  {
    minim = new Minim(parent);
    kickSize = snareSize = hatSize = 16;
    beat = new BeatDetect();

    mixerInfo = AudioSystem.getMixerInfo();
    Mixer mixer = AudioSystem.getMixer(mixerInfo[0]);
    minim.setOutputMixer(mixer);
    
    output = minim.getLineOut();
    beat_bar = new BeatDetect(output.bufferSize(), output.sampleRate());
    beat_bar.setSensitivity(300);  
    eRadius = 20;
    
   
    sound = new FilePlayer( minim.loadFileStream(pathToSoundFile) );
    cbf = new LowPassFS(100, output.sampleRate());
    delay = new Delay( 0.4, 0.5, true, true );
    bitCrush = new BitCrush(16, output.sampleRate());
    
    //sound.patch(cbf).patch(output);
    //sound.patch(output);
    sound.patch(delay).patch(bitCrush).patch(cbf).patch(output);
    sound.loop();
    
    bl = new BeatListener(beat_bar, output);  
  }
  
  void changeSound(String pathToSoundFile)
  {
    if(!changeSound){
      sound.pause();
      sound.unpatch(output);     
      sound = new FilePlayer( minim.loadFileStream(pathToSoundFile) ); 
      cbf = new LowPassFS(100, output.sampleRate());
      delay = new Delay( 0.4, 0.5, true, true );
      bitCrush = new BitCrush(16, output.sampleRate());
      sound.patch(delay).patch(bitCrush).patch(cbf).patch(output);
      //sound.patch(output);
      sound.loop();
    }
    changeSound = true;
  }
  
  void updateDelay(float time, float amplitude)
  {
    delay.setDelTime(time);
    delay.setDelAmp(amplitude);
  }
  
  void updateBitCrush(float bitRes){
    bitCrush.setBitRes(bitRes);
  }

  void updateCBF(float cutoff)
  {
    cbf.setFreq(cutoff);
  }

  void update()
  {
    beat.detect(output.mix);
    amplitude = map(eRadius, 20, 80, 60, 255);
    if ( beat.isOnset() ) 
      eRadius = 80;
    eRadius *= 0.955;
    if ( eRadius < 20 ) 
      eRadius = 20;
  }
  
  //TODO; move the rendering in another class, this one should only handle sound
  void updateBeat()
  {
    beat_bar.detect(output.mix);
    float rectW = width / beat_bar.detectSize();
    for(int i = 0; i < beat_bar.detectSize(); ++i)
    {
      if ( beat_bar.isOnset(i) )
      {
        fill(255,0,0);
        rect( i*rectW, 0, rectW, height);
      }
    }
    
    int lowBand = 5;
    int highBand = 15;
    int numberOfOnsetsThreshold = 4;
    if ( beat_bar.isRange(lowBand, highBand, numberOfOnsetsThreshold) )
    {
      fill(232,179,2,200);
      rect(rectW*lowBand, 0, (highBand-lowBand)*rectW, height);
    }
    
    if ( beat_bar.isKick() ) kickSize = 32;
    if ( beat_bar.isSnare() ) snareSize = 32;
    if ( beat_bar.isHat() ) hatSize = 32;
    
    fill(255);
     
    kickSize = constrain(kickSize * 0.95, 16, 32);
    snareSize = constrain(snareSize * 0.95, 16, 32);
    hatSize = constrain(hatSize * 0.95, 16, 32);
  }

}