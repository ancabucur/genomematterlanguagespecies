import ddf.minim.*;
import javax.sound.sampled.*;


class SimpleSound {
  AudioSample sample;
  Mixer.Info[] mixerInfo;
  Minim minim;
  boolean isTriggered = false;
  public SimpleSound(PApplet parent, String path)
  {
      minim = new Minim(parent);
      mixerInfo = AudioSystem.getMixerInfo();
      Mixer mixer = AudioSystem.getMixer(mixerInfo[0]);
      minim.setOutputMixer(mixer);
      sample = minim.loadSample( path, 512);
  }
  
  void trigger()
  {
    sample.trigger();
  }
  
  void triggerOnce(){
    if (!isTriggered)
      sample.trigger();
    isTriggered = true;
  }

}