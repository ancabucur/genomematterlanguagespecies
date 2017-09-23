import wblut.core.*;
import wblut.geom.*;
import wblut.hemesh.*;
import wblut.math.*;
import wblut.processing.*;

class Obj3d {

  public HE_Mesh mesh, noiseMesh;
  WB_Render3D render;
  HEM_Twist modifier;
  WB_Line L;
  float current_scale = 16;
  boolean enableNoise = true;
  boolean init = false;
  boolean isHidden = true;
  boolean enableTwist = false;
  int global_x_pos = 0;
  int global_y_pos = 0;
  float rotate_x = radians(175);
  float rotate_y = radians(180);
  String path = "";
  
  public Obj3d(PApplet parent)
  {
      render = new WB_Render3D(parent);
      this.path = HEAD;
      createMesh(HEAD);
      applyNoise(20);
      mesh.scaleSelf(current_scale);
      noiseMesh.scaleSelf(current_scale);
      //initTwist();
      global_x_pos = (width-40)/2;
      global_y_pos = height/2;
   }

  public Obj3d(PApplet parent, String pathToObj)
  {
      render = new WB_Render3D(parent);
      this.path = pathToObj;
      createMesh(pathToObj);
      //initTwist();
      global_x_pos = (width-40)/2;
      global_y_pos = height/2;
  }

  void initTwist()
  {
      modifier=new HEM_Twist();
      L=new WB_Line(0,0,0,1,1,0);
      modifier.setTwistAxis(L);// Twist axis
      //you can also pass the line as two points:  modifier.setTwistAxisFromPoints(new WB_Point(0,0,-200),new WB_Point(1,0,-200))
      //or as a point and a direction :  modifier.setTwistAxis(new WB_Point(0,0,-200),new WB_Vector(0,0,1))
      modifier.setAngleFactor(.51);
  }
  
  void applyNoise(float amount){
    HEM_Noise modifier=new HEM_Noise();
    noiseMesh = mesh.get();
    //modifier.setDistance(mouseY/20);
    modifier.setDistance(amount);
    noiseMesh.modify(modifier);
  }

  void createMesh(String pathToObj){
    HEC_FromOBJFile creator = new HEC_FromOBJFile(pathToObj);
    mesh = new HE_Mesh(creator); 
    noiseMesh = mesh.get();
  }
  
  void scale(float val){
    mesh.scaleSelf(val);
    noiseMesh.scaleSelf(val);
  }
  
  void hide(){
    isHidden = true;
  }
  
  void show(){
    isHidden = false;
  }
  
  void setNormalPosition(){
    //rotateX(radians(175));
    //rotateY(radians(180));
    rotateX(rotate_x);
    rotateY(rotate_y);
  }
  
  void setRotation(float x, float y)
  {
    rotate_x = x;
    rotate_y = y;
  }
  
  void rotateLeft(int direction)
  {
    //rotateX(radians(175));
    rotateX(rotate_x);
    //int direction = left == true ? 1 : -1;
    rotateY(radians(direction * frameCount));
  }
  
  void translat(int x, int y)
  {
    global_x_pos = x;
    global_y_pos = y;
  }
  
  
  
  void twist(float value, int direction)
  {
    try {
          modifier.setTwistAxis(L);
          modifier.setAngleFactor(value*direction*0.00001);
          mesh.modify(modifier);
        }
        catch(Exception e)
        {}
    enableTwist = true;
  }
  
  void reset()
  {
//   if(enableTwist)
    {
        createMesh(this.path);
        if (this.path.contains("head.obj"))
        { 
          this.scale(18);
          global_x_pos = (width-40)/2;
          global_y_pos = height/2;
      
        }  
    }
  //enableTwist = false;
  }
  
  void update(float amplitude, int rotate){
    translate(global_x_pos, global_y_pos);
    directionalLight(255, 255, 255, 1, 1, -1);
    directionalLight(127, 127, 127, -1, -1, 1);
    
    //pointLight(204, 204, 204, 1000, 1000, 1000);
    if (rotate == 0)
      setNormalPosition();
    else
      rotateLeft(rotate);
    
    if (!isHidden)
    {
      noFill();
      stroke(255, 0, 0);
      render.drawEdges(mesh);
      if (amplitude < 0 || isHidden)
        noFill();
      else
        fill(amplitude);
      
      noStroke();
      render.drawFaces(mesh);
    }
    else {
      noFill();
      noStroke();
      render.drawEdges(mesh);
      render.drawFaces(mesh);
    }
    //fill(mouseX);
    //println(mouseX);    
  }
  
  void updateNoise(float amount){
     if (!enableNoise || amount < 5)
       return;
     //applyNoise(mouseY/20);
     applyNoise(amount);
     fill(255);
     noStroke();
     render.drawFaces(noiseMesh);
  }

}