  String HEAD = "../data/head.obj";
  String DNA = "../data/dna.obj";
  String FILM = "../data/video/red_close.mp4";
  String FILM_RETINA = "../data/video/retina.mp4";
  String SOUND = "../data/sound/rec_impro3.wav";
  int PROJECTOR = 2;
  Film filmHead;
  Film filmRetina;
  Sound sound;
  
  Obj3d objHead;
  Obj3d objDNA;
  Obj3d objDNA_C;
  
  Postfx fx;
  
  Controls controls;
 
  void setup() {
    sound = new Sound(this);
    
    filmHead = new Film(this);
    filmRetina = new Film(this, FILM_RETINA);
    
    objHead = new Obj3d(this);
    objDNA = new Obj3d(this, DNA);
    objDNA_C = new DNA3d(this, DNA);
    //objDNA_C =new Obj3d(this, DNA);
    controls = new Controls();
    controls.parent_height = height;
    controls.parent_width = width;
    
    fx = new Postfx(this);
  }
  
  void settings(){
    fullScreen(P3D, PROJECTOR);
    //size(1280, 800, P3D);
    //size(1920, 1080, P3D);
    smooth(8);
  }
  
  void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    float current_scale = e < 0 ? 1.1 : 0.9;
    
    if (controls.objCurrent == 1 && !objHead.isHidden)
      objHead.scale(current_scale);
    else if(controls.objCurrent == 2 && !objDNA.isHidden)
      objDNA.scale(current_scale);
    else if (!objDNA_C.isHidden && !objDNA_C.isHidden)
      objDNA_C.scale(current_scale);
  }
  
  void mouseClicked(MouseEvent evt){
    if (evt.getCount() == 1)
      return;
    if(controls.objCurrent == 2 && !objDNA.isHidden)
      objDNA.translat(mouseX, mouseY);
    else if(controls.objCurrent == 3  && !objDNA_C.isHidden)
      objDNA_C.translat(mouseX, mouseY);
  }
  
  void mouseDragged()
  {
    if(controls.objCurrent == 2 && !objDNA.isHidden)
      objDNA.setRotation(mouseX*1.0f/width*TWO_PI, mouseY*1.0f/height*TWO_PI);
    else if(controls.objCurrent == 3 && !objDNA_C.isHidden)
      objDNA_C.setRotation(mouseX*1.0f/width*TWO_PI, mouseY*1.0f/height*TWO_PI);
  }


  void twistObj(Obj3d object)
  {
     if (controls.objTwist == 0)
     {
         object.reset();
     }
     else
        object.twist(sound.amplitude, controls.objTwist);
  }
  void displayObj(Obj3d object)
  {
        object.show();
        if (controls.objTransparent)
        {
          object.update(-1, controls.objRotate);
        }  
        else
        {
          object.update(sound.amplitude, controls.objRotate);
          object.updateNoise(controls.noiseAmount);
         }
  }
  
  void hideObj(Obj3d object)
  {
      //object.update(-1, controls.objRotate);
      object.hide();  
  }
  
  void updateSound(){

    sound.updateCBF(controls.cbfCutOff);    
    if(controls.delayEnable){
      sound.updateDelay((float)controls.delayTime/100, (float)controls.delayAmplitude/100);
      sound.updateBitCrush(controls.bitRes);
      if (controls.bitRes == 5 )
        controls.setNoise(5);
    }
    else
    {
      sound.updateDelay(0, 0);
      sound.updateBitCrush(16);
    }
    sound.update();
    
  }

  void draw() {
    try {
      if (controls.backgroundVisible)
        background(0);
      
      if (controls.videoVisible)
      {
        if (controls.currentFilm == 1)
        {
          filmHead.update(controls.videoEdges);
        }
        else if (controls.currentFilm == 2)
        {
          filmRetina.play();
          filmRetina.update(controls.videoEdges);
        }
       }
      else 
      {
        filmRetina.pause();    
      }
      
      
      if (controls.barsVisible)
        sound.updateBeat();
      
      updateSound();
      
      if (controls.objVisible)
      { 
        if (controls.objCurrent == 1)
        {
          displayObj(objHead);
          //twistObj(objHead);
        }
        else if(controls.objCurrent == 2)
        {  
          displayObj(objDNA);
          //twistObj(objDNA);
        }
        else if(controls.objCurrent == 3)
          displayObj(objDNA_C);
      }
      else{
        if (controls.objCurrent == 1)
          hideObj(objHead);
        else if(controls.objCurrent == 2)
          hideObj(objDNA);
        else if(controls.objCurrent == 3)
          hideObj(objDNA_C);    
      }
      if (controls.fx)
      {
        fx.update();
      }
    }
    catch (Exception e)
    {
      println("Exceptie");
    }
  }