public class SecondApplet extends PApplet
{
    void setting()
    {
       size(640, 360);
    }
    void setup()
    { 
      surface.setVisible( false );
      isUnVisible = true;
    }
    void draw()
    {
      if(sliderValue==2 ||
         START_FLAG == true)
      {
        if(START_FLAG == true)
        {
          movement = true;
        }
        
        if(movement == true)
        {
          PImage img = screenshot();
          image(img,0,0,width,height);
          T++;
          Seekbar_ReInit = true;
        }
        else
        {
          T++;
        }
        
        if(START_FLAG == true)
        {
          movement = false;
          START_FLAG = false;
        }
      }
      //if(movement==true&&sliderValue==2)
      //{
      //  PImage img=screenshot();
      //  image(img,0,0,width,height);
      //  T++;
      //  Seekbar_ReInit=true;
      //}
      //else if(movement==false&&sliderValue==2)
      //{
      //  T++;
      //}
    }
}
