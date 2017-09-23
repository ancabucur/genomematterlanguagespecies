import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

class Postfx {

  PostFX fx;
  
  public Postfx(PApplet parent)
  {
    fx = new PostFX(parent);
  }
  
  public void update()
  {
    fx.render()
    .sobel()
    .bloom(0.5, 20, 30)
    .compose();
  }

}