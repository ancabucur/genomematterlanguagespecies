class DNA3d extends Obj3d {

  WB_Plane[] planes;
  int numPlanes;
  HEM_MultiSliceSurface modifier;
  
  public DNA3d(PApplet parent, String pathToObj)
  {
      super(parent, pathToObj);
      smooth(8);
      render = new WB_Render3D(parent);
      createMesh(pathToObj);
      mesh.modify(new HEM_Shell().setThickness(40));
      
      global_x_pos = (width-40)/2;
      global_y_pos = height/2;
  
      numPlanes=7;
      modifier=new HEM_MultiSliceSurface();
      planes=new WB_Plane[numPlanes];
      for(int i=0;i<numPlanes;i++){
        planes[i] = new WB_Plane(0,0,random(-50,50),random(-1,1),random(-1,1),random(-1,1));
      } 
      modifier.setPlanes(planes); 
      modifier.setOffset(0);
      mesh.modify(modifier);
      current_scale = 13;
      mesh.scaleSelf(current_scale);
      render = new WB_Render(parent);
      rotate_x = radians(77);
      rotate_y = radians(77);
  }
  
 
   void update(float amplitude, int rotate){
      translate(global_x_pos, global_y_pos);
      directionalLight(255, 255, 255, 1, 1, -1);
      directionalLight(127, 127, 127, -1, -1, 1);
     
      if (rotate == 0)
        setNormalPosition();
      else
        rotateLeft(rotate);
      
      
      if (amplitude < 0)
        noFill();
      else
        fill(255);
            
      noStroke();
      render.drawFaces(mesh);
      if (!isHidden)
      { 
        fill(255,0,0);
        noStroke();
        render.drawFaces(modifier.cutFaces);
      
        noFill();
        stroke(0);
        
        render.drawEdges(mesh);
        strokeWeight(4);
        stroke(0,0,255);
       
        render.drawEdgesWithInternalLabel(1,mesh);
       
        strokeWeight(1);
        stroke(255,0,0);
        for(int i=0;i<numPlanes;i++){
          render.drawPlane(planes[i], 400);
        }   

      }
      else {
        noFill();
        noStroke();
        render.drawEdges(mesh);
        render.drawFaces(mesh);
      }
  }

}