import ddf.minim.*;

class SimpleSound {
  AudioSample sample;
  Minim minim;
  public SimpleSound(PApplet parent, String path)
  {
      minim = new Minim(parent);
      sample = minim.loadSample( path, 512);
  }
  
  void trigger()
  {
    sample.trigger();
  }


}