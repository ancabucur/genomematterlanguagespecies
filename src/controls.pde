
import controlP5.*;
import processing.net.*;

public class Controls extends PApplet{

  ControlP5 cp5;
  Client client;
  int PORT = 4243;
  boolean isPlaying = false;
  
  int currentFilm;
  boolean videoEdges = false;
  boolean fx = false;
  
  int noiseAmount;
  
  int cbfCutOff;
  boolean delayEnable;
  
  float delayTime;
  float delayAmplitude;
  
  int bitRes;
  
  boolean objVisible = true;
  boolean objTransparent = false;
  boolean videoVisible = true;
  boolean barsVisible = false;
  boolean backgroundVisible = true;
  
  int objRotate = 0;
  int objTwist = 0;
  int objCurrent = 1;
  
  int W = 200;
  int H = 200;
  int P_X = 330;
  int P_Y = 200;
  int parent_width = 0;
  int parent_height = 0;

  Toggle videoVisibleToggle, objVisibleToggle, barsVisibleToggle, objTransparentToggle, backgroundVisibleToggle, videoEdgesToggle, fxToggle;
  RadioButton radioFilmRadioButton, radioRotateRadioButton, radioObjRadioButton, radioTwistRadioButton;

  public Controls ()
  {
    super();
    PApplet.runSketch(new String[] {this.getClass().getSimpleName()}, this);
    client = new Client(this, "127.0.0.1", PORT);
  }
  
  void setup() {
    noStroke();
    cp5 = new ControlP5(this);
  
    cp5.begin(cp5.addBackground(""));
    
    
     CColor soundColors = new CColor();
     soundColors.setForeground(ControlP5.LIME);
     
    videoVisibleToggle = cp5.addToggle("videoVisible");
    videoVisibleToggle.setCaptionLabel("VIDEO")
       .setPosition(10,20)
       .setSize(40,20)
       .setMode(Toggle.SWITCH)
       .setValue(true)
       ;
    
    objVisibleToggle = cp5.addToggle("objVisible");
    objVisibleToggle.setCaptionLabel("OBJECT")
       .setPosition(70,20)
       .setSize(40,20)
       .setMode(Toggle.SWITCH)
       .setValue(false)
       ;

     barsVisibleToggle = cp5.addToggle("barsVisible");
     barsVisibleToggle.setCaptionLabel("SND BAR")
       .setPosition(130,20)       
       .setSize(40,20)
       .setMode(Toggle.SWITCH)
       .setValue(true)
       ;  
       
     objTransparentToggle = cp5.addToggle("objTransparent");
     objTransparentToggle.setCaptionLabel("Grid")
       .setPosition(190,20)
       .setSize(40,20)
       .setMode(Toggle.SWITCH)
       .setValue(false)
       ;
       
     backgroundVisibleToggle = cp5.addToggle("backgroundVisible");
     backgroundVisibleToggle.setCaptionLabel("BKG")
       .setPosition(250,20)       
       .setSize(40,20)
       .setMode(Toggle.SWITCH)
       .setValue(true)
       ;  
       
      radioFilmRadioButton = cp5.addRadioButton("radioFilm");
      radioFilmRadioButton.setPosition(330,20)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(3)
         .setSpacingColumn(10)
         .addItem("0", 1)
         .addItem("1", 2)
         //.addItem("-1", 3)
         ;
         
     videoEdgesToggle = cp5.addToggle("videoEdges");
     videoEdgesToggle.setCaptionLabel("vedge")
       .setPosition(450,20)
       .setSize(50,20)
       .setMode(Toggle.SWITCH)
       .setValue(false)
       ;         

     fxToggle = cp5.addToggle("fx");
     fxToggle.setCaptionLabel("fx")
       .setPosition(520,20)
       .setSize(50,20)
       .setMode(Toggle.SWITCH)
       .setValue(false)
       ; 

     radioRotateRadioButton = cp5.addRadioButton("radioRotate");
     radioRotateRadioButton.setPosition(330,70)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(3)
         .setSpacingColumn(10)
         .addItem("L", 1)
         .addItem("N", 0)
         .addItem("R", -1)
         ;
     
     radioObjRadioButton = cp5.addRadioButton("radioObj");
     radioObjRadioButton.setPosition(330,100)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(3)
         .setSpacingColumn(30)
         .addItem("HEAD", 1)
         .addItem("DNA", 2)
         .addItem("DNA_C", 3)
         ;

     /*radioTwistRadioButton = cp5.addRadioButton("radioTwist");
     radioTwistRadioButton.setPosition(330,140)
         .setSize(40,20)
         .setColorForeground(color(120))
         .setColorActive(color(255))
         .setColorLabel(color(255))
         .setItemsPerRow(3)
         .setSpacingColumn(20)
         .addItem("TL", 1)
         .addItem("N", 0)
         .addItem("TR", -1)*/
         ;    
     
    cp5.addGroup("mouseScreen").setMoveable(false)
     .setLabel("Object morpher")
     .setPosition(P_X, P_Y)
     .setWidth(200)
     .addCanvas(new MouseScreen())
     ;
     
     cp5.addSlider("noiseAmount")
       .setPosition(10, 70)
       .setSize(200, 20)
       .setRange(0, 100)
       .setValue(0)
       ;

    cp5.addToggle("delayEnable")
       .setCaptionLabel("DELAY")
       .setColor(soundColors)
       .setPosition(10, 100)
       .setSize(50,20)
       .setMode(Toggle.SWITCH)
       .setValue(true)
       ;
 
     cp5.addSlider("cbfCutOff")
       .setColor(soundColors)
       .setPosition(10,150)
       .setSize(200, 20)
       .setRange(60, 21000)
       .setValue(6110)
       ;
 
     cp5.addSlider("delayTime")
       .setColor(soundColors)
       .setPosition(10, 180)
       .setSize(200, 20)
       .setRange(0, 100)
       .setValue(0)
       ;
     cp5.addSlider("delayAmplitude")
       .setColor(soundColors)
       .setPosition(10, 220)
       .setSize(200, 20)
       .setRange(0, 100)
       .setValue(0)
       ;
       
     cp5.addSlider("bitRes")
       .setColor(soundColors)
       .setPosition(10, 260)
       .setSize(200, 20)
       .setRange(3, 16)
       .setValue(16)
       ;       
       
    cp5.end();

  }  
 
  void setNoise(int value){
    cp5.getController("noiseAmount").setValue(value);
  }
  
  void radioRotate(int value) {
    objRotate = value;
  }
  
  void radioTwist(int value) {
    objTwist = value;
  }
  
  void radioFilm(int whichOne) {
    currentFilm = whichOne;
  }
  
  void radioObj(int whichOne) {
    objCurrent = whichOne;
  }
  
  boolean mouseInBox()
  {
    return (mouseX > P_X && mouseX < P_X + W && mouseY > P_Y && mouseY < P_Y + H);
  }
  
  // !!! these three functions are outside the scope of this class !!!
  
  void scaleAll(float current_scale)
  {
        if (!mouseInBox())
          return;
        if (controls.objCurrent == 1 && !objHead.isHidden)
          objHead.scale(current_scale);
        else if(controls.objCurrent == 2 && !objDNA.isHidden)
          objDNA.scale(current_scale);
        else if (!objDNA_C.isHidden)
          objDNA_C.scale(current_scale);  
  }
  void mouseWheel(MouseEvent event) {
    if (!mouseInBox())
      return;
    
    float e = event.getCount();
    float current_scale = e < 0 ? 1.05 : 0.95;
    
    if (controls.objCurrent == 1 && !objHead.isHidden)
      objHead.scale(current_scale);
    else if(controls.objCurrent == 2 && !objDNA.isHidden)
      objDNA.scale(current_scale);
    else if (!objDNA_C.isHidden)
      objDNA_C.scale(current_scale);
  }
  
  int getRelativePositionOnParentScreenX(int current_x)
  {
    current_x = current_x - P_X;
    return parent_width * current_x / W;
  }
  
  int getRelativePositionOnParentScreenY(int current_y)
  {
    current_y = current_y - P_Y;
    return parent_height * current_y / H;  
  }
  
  void mouseClicked(MouseEvent evt){
    if (!mouseInBox())
      return;    
    if (evt.getCount() == 1)
      return;
    int mx = getRelativePositionOnParentScreenX(mouseX);
    int my = getRelativePositionOnParentScreenY(mouseY);

    if(controls.objCurrent == 2 && !objDNA.isHidden)
      objDNA.translat(mx, my);
    else if(controls.objCurrent == 3 && !objDNA_C.isHidden)
      objDNA_C.translat(mx, my);
  }
  
  void mouseDragged()
  {
    if (!mouseInBox())
      return;
    int mx = getRelativePositionOnParentScreenX(mouseX);
    int my = getRelativePositionOnParentScreenY(mouseY);
  
    if(controls.objCurrent == 2 && !objDNA.isHidden)
      objDNA.setRotation(mx*1.0f/width*TWO_PI, my*1.0f/height*TWO_PI);
    else if(controls.objCurrent == 3 && !objDNA_C.isHidden)
      objDNA_C.setRotation(mx*1.0f/width*TWO_PI, my*1.0f/height*TWO_PI);
  }
  
  void rotateAll()
  {
    if (!mouseInBox())
      return;
    int mx = getRelativePositionOnParentScreenX(mouseX);
    int my = getRelativePositionOnParentScreenY(mouseY);
  
    if(controls.objCurrent == 2 && !objDNA.isHidden)
      objDNA.setRotation(mx*1.0f/width*TWO_PI, my*1.0f/height*TWO_PI);
    else if(controls.objCurrent == 3 && !objDNA_C.isHidden)
      objDNA_C.setRotation(mx*1.0f/width*TWO_PI, my*1.0f/height*TWO_PI);  
  }
  // !!! these three functions are outside the scope of this class !!!
  
  class MouseScreen extends Canvas {
   public void draw(PGraphics pg) {
      pg.fill(255,150);
      pg.rect(0,0,W,H);
      pg.fill(255,150);
    }
  }
  
  void settings() {
    size(600, 400);  
  }

  // neural net
  void section1()
  {
    videoVisibleToggle.setValue(false);
    videoVisible = false;
    
    objVisibleToggle.setValue(false);
    objVisible = false;
    
    objTransparentToggle.setValue(false);
    objTransparent = false;
    
    fxToggle.setValue(false);
    fx = false;
    
    videoEdgesToggle.setValue(false);
    videoEdges = false;
    
    radioRotateRadioButton.setValue(0);
    radioRotate(0);
    
    barsVisibleToggle.setValue(true);
    barsVisible = true;
  
    cp5.getController("noiseAmount").setValue(0);
    noiseAmount = 0;
    
    backgroundVisibleToggle.setValue(true);
    backgroundVisible = true;
  }
  
  // voi cei ce intrati aici
  void section2()
  {
    videoVisibleToggle.setValue(false);
    videoVisible = false;
    
    fxToggle.setValue(false);
    fx = false;
    
    videoEdgesToggle.setValue(false);
    videoEdges = false;
    
    radioRotateRadioButton.setValue(0);
    radioRotate(0);
    
    objTransparentToggle.setValue(true);
    objTransparent = true;
    
    objVisibleToggle.setValue(true);
    objVisible = true;
    
    barsVisibleToggle.setValue(true);
    barsVisible = true;
    
    radioObjRadioButton.setValue(1);
    radioObj(1);
  
    cp5.getController("noiseAmount").setValue(0);
    noiseAmount = 0;

    backgroundVisibleToggle.setValue(true);
    backgroundVisible = true;
  }
  
  // dna talk
  void section3()
  {
    videoVisibleToggle.setValue(false);
    videoVisible = false;
    
    fxToggle.setValue(false);
    fx = false;
    
    videoEdgesToggle.setValue(false);
    videoEdges = false;
    
    objTransparentToggle.setValue(false);
    objTransparent = false;
    
    radioRotateRadioButton.setValue(-1);
    radioRotate(-1);
    
    objVisibleToggle.setValue(true);
    objVisible = true;
    
    barsVisibleToggle.setValue(false);
    barsVisible = false;
    
    radioObjRadioButton.setValue(2); 
    radioObj(2);

    cp5.getController("noiseAmount").setValue(0);
    noiseAmount = 0;

    backgroundVisibleToggle.setValue(true);
    backgroundVisible = true;

  }
  
  // text fain / fapt de 99
  void section4()
  {
    videoEdgesToggle.setValue(false);
    videoEdges = false;
    filmHead.edgesEnabled = true;
    filmHead.disableEdges();
    
    videoVisibleToggle.setValue(true);
    videoVisible = true;
    
    fxToggle.setValue(false);
    fx = false;
    
    radioFilmRadioButton.setValue(1);
    radioFilm(1);
    
    objTransparentToggle.setValue(false);
    objTransparent = false;
    
    radioRotateRadioButton.setValue(0);
    radioRotate(0);
    
    objVisibleToggle.setValue(true);
    objVisible = true;
    
    barsVisibleToggle.setValue(false);
    barsVisible = false;
    
    radioObjRadioButton.setValue(1); 
    radioObj(1);
    objHead.reset();
    
    cp5.getController("noiseAmount").setValue(0);
    noiseAmount = 0;

    backgroundVisibleToggle.setValue(true);
    backgroundVisible = true;

  }
  
  // cambia si anatait / sintetice masini sociale / 
  void section5()
  {
    videoVisibleToggle.setValue(true);
    videoVisible = true;
    
    radioFilmRadioButton.setValue(2);
    radioFilm(2);
    
    fxToggle.setValue(false);
    fx = false;
    
    videoEdgesToggle.setValue(true);
    videoEdges = true;
    
    objTransparentToggle.setValue(true);
    objTransparent = true;
    
    radioRotateRadioButton.setValue(1);
    radioRotate(1);
    
    objVisibleToggle.setValue(true);
    objVisible = true;
    
    barsVisibleToggle.setValue(false);
    barsVisible = false;
    
    radioObjRadioButton.setValue(1);
    radioObj(1);

    cp5.getController("noiseAmount").setValue(0);
    noiseAmount = 0;

    backgroundVisibleToggle.setValue(true);
    backgroundVisible = true;

  }
  
  //esperanto noise
  void section6()
  {
    videoVisibleToggle.setValue(true);
    videoVisible = true;
    filmHead.edgesEnabled = true;
    filmHead.disableEdges();
    
    radioFilmRadioButton.setValue(1);
    radioFilm(1);
    
    fxToggle.setValue(false);
    fx = false;
    
    videoEdgesToggle.setValue(false);
    videoEdges = false;
    
    objTransparentToggle.setValue(false);
    objTransparent = false;
    
    radioRotateRadioButton.setValue(0);
    radioRotate(0);
    
    objVisibleToggle.setValue(true);
    objVisible = true;
    
    barsVisibleToggle.setValue(false);
    barsVisible = false;
    
    radioObjRadioButton.setValue(1);
    radioObj(1);
    
    objHead.reset();
  
    
    cp5.getController("noiseAmount").setValue(0);
    noiseAmount = 0;
    
    backgroundVisibleToggle.setValue(true);
    backgroundVisible = true;
  
  }
  
  // uniti-va
  void section7()
  {
    videoVisibleToggle.setValue(false);
    videoVisible = false;
    
    fxToggle.setValue(false);
    fx = false;
    
    videoEdgesToggle.setValue(false);
    videoEdges = false;
    
    objTransparentToggle.setValue(true);
    objTransparent = true;
    
    radioRotateRadioButton.setValue(0);
    radioRotate(0);
    
    objVisibleToggle.setValue(true);
    objVisible = true;
    
    barsVisibleToggle.setValue(true);
    barsVisible = true;
    
    radioObjRadioButton.setValue(1);
    radioObj(1);  

    cp5.getController("noiseAmount").setValue(0);
    noiseAmount = 0;
  
    backgroundVisibleToggle.setValue(true);
    backgroundVisible = true;

    
  }
  
  void next(){
     println("Next");
     client.write("next" +"\r\n");
     client.clear();
  }
  
  void play(){
     println("Play");
     client.write("play" +"\r\n");
     client.clear();
     isPlaying = true;
  }
  
  void keyPressed()
  {
     if (key == '1')
      {
        section1();
        play();
      }
     if (key == '2')
     {
        section2();
        next();
     }
     if (key == '3')
     {
        section3();
        next();
     }
     if (key == '4')
     {
        section4();
        next();
     }
     if (key == '5')
     {
        section5();
        next();
     }
     if (key == '6')
     {
        section6();
        next();
     }
     if (key == '7')
     {
        section7();
        next();
     }
     if (key == 'l')
     {
      println("Play");
       client.write("play" +"\r\n");
       client.clear();
     }  
     if (key == 'p')
     {
       if (isPlaying)
       {
         println("Pause");
         client.write("pause" +"\r\n");
         client.clear();
         isPlaying = false;
       }
       else
       {
        play();
       }
     }   
     if (key == 's')
     {
       println("Stop");
       client.write("stop" +"\r\n");
       client.clear();
     }       
     if (key == CODED)
     {
       if (keyCode == UP)
       {
         scaleAll(1.05);
         println("here up");
       }
       if (keyCode == DOWN)
       {
         scaleAll(0.95);
       }
       if (keyCode == LEFT)
       {
         println("Previous");
         client.write("prev" +"\r\n");
         client.clear();
       }
       if (keyCode == RIGHT)
       {
         next();
       }
     }

     
     
  }

  void draw() {
    background(0);

  }

} 