
//import
import controlP5.*;
import java.io.File;
import java.util.Arrays;

import processing.video.*;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.Robot;
import java.awt.Rectangle;
import java.awt.image.*;
import java.applet.*;
//import java.awt.*;
import java.awt.event.*;

//---def---
ControlP5 cp5_B;  //Button
ControlP5 cp5_T;  //Toggle
ControlP5 CP5_S;  //Slider
Capture video;
//---def---End

//---Hensuu---
int b1=0;
boolean   isUnVisible;    
int T=1;
int w=640;
int h=360;
color[] exColor=new color[w*h];
float x,y;
int sumX,sumY;
int pixelNum;
boolean movement=false;
int tolerance=100;
int start=0,stop=0,timelapuse=0;
int sliderValue;
PImage img;
PImage A;
boolean START_FLAG = true;
//---Hensuu---End

//---Animation---
//---DrawImage---
Pro_DrawImage _DrawImage;
//---DrawImage---End
//---draw---
int draw_Cnt;
int draw_oldCnt;
int draw_newCnt;
int draw_Speed;
//---draw---End
//---CP5---
ControlP5 CP5_Button;
ControlP5 CP5_Slider;
boolean Flag_Stop;
boolean Flag_Reset;

Button Stop;
Button Reset;
int CP5_Button_Size;
int CP5_Button_PosX;
int CP5_Button_PosY;
int CP5_Button_Space;

Slider Seekbar;
int CP5_Slider_SizeX;
int CP5_Slider_SizeY;
int CP5_Slider_PosX;
int CP5_Slider_PosY;
int CP5_Slider_Space;
float CP5_Slider_nowValue;
//---CP5---End
//---Re:setup---
boolean Seekbar_ReInit = true;
//---Re:setup---End
//---Animation---End

//---setup---
void setup()
{
  //fixed window's size
  size(960,540);  

  //Color of background = black
  background(0,255,0);

  //Print message
  //Print sketch's path
  println(sketchPath());
  //Print data's path
  println(dataPath(""));
  
  ////---Camera(module)---
  //String[] cameras = Capture.list();
  //while(cameras.length == 0)
  //{
  //  cameras = Capture.list();
  //}
  ////---Camera(module)---End
  
  
  //---GeneralGUI---
  cp5_B = new ControlP5(this);
  cp5_B.addButton("Close")
      .setPosition(900,500)
      .setSize(35,20);
  CP5_S = new ControlP5(this);
  CP5_S.addSlider("sliderValue")
    .setRange(1, 3)   //from 0 to 100
    .setValue(1)       //initial value
    .setPosition(650, 40)//position
    .setSize(200, 20)   //size
    .setSliderMode(Slider.FIX)//shape:Slider.FLEXIBLE is reversed triangle
    .setNumberOfTickMarks(3);
   CP5_S.getController("sliderValue")
    .getValueLabel()
    .align(ControlP5.RIGHT, ControlP5.BOTTOM_OUTSIDE) //right side
    .setPaddingX(-0);                   //padding from right side
  //---GeneralGUI---End
    
  //---draw---
  draw_Cnt = 0;
  draw_newCnt = 0;
  draw_oldCnt = 0;
  draw_Speed = 5;
  //---draw---End
  
  //---CP5---
  //Set const
  CP5_Button_Size = 30;
  CP5_Button_PosX = 10;
  CP5_Button_PosY = height-40;
  CP5_Button_Space = 5;
  CP5_Slider_SizeX = width;
  CP5_Slider_SizeY = 10;
  CP5_Slider_PosX = 0;
  CP5_Slider_PosY = CP5_Button_PosY - 10 - 2;
  //Button
  CP5_Button = new ControlP5(this);
  //Start and stop
  Stop =  CP5_Button.addButton("StartAndStop")
                    .setLabel("STOP")
                    .setColorBackground(color(255,0,0))
                    .setSize(CP5_Button_Size,CP5_Button_Size)
                    .setPosition(CP5_Button_PosX,CP5_Button_PosY);
  Flag_Stop = true;
  //Reset
  Reset = CP5_Button.addButton("Reset")
                    .setLabel("Reset")
                    .setSize(CP5_Button_Size,CP5_Button_Size)
                    .setPosition(CP5_Button_PosX+CP5_Button_Size+CP5_Button_Space,CP5_Button_PosY);
  Flag_Reset = false;
  
  Seekbar_ReInit = true;
  //---CP5---End
  
  //---Camera(module)---
  String[] cameras = Capture.list();
  //while(cameras.length == 0)
  //{
  //  cameras = Capture.list();
  //}
  while(true)
  {
    cameras = Capture.list();
    if(cameras.length == 0)
    {
      println("Camera is not found.");
    }
    else
    {
      for(String c : cameras)
      {
        println(c);
      }
      break;
    }
  }
  //---Camera(module)---End
  
  //---SecondApplet---
  String[] args = {"--location=-1000,-1000","SecondApplet","-present"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);
  video = new Capture(this, w,h,cameras[0]);
  video.start();
  noStroke();
  //---SecondApplet---End
}
//---setup---End

//---draw---
void draw()
{
  //Conditional branch by CP5_S's sliderValue
  if(sliderValue==3)
  {//Slider = 3
    //ReInitialize
    if(Seekbar_ReInit == true)
    {
      //---DrawImage---
      _DrawImage = new Pro_DrawImage();
      //---DrawImage---End
      
      //Stop
      Flag_Stop = true;
      
      //Reset
      Flag_Reset = false;
      
      //Seekbar
      CP5_Slider = new ControlP5(this);
      Seekbar = CP5_Slider.addSlider("SeekBar")
                          .setRange(0,_DrawImage.DrawImage_Data_Num-1)
                          .setValue(0)
                          .setPosition(CP5_Slider_PosX,CP5_Slider_PosY)
                          .setSize(CP5_Slider_SizeX,CP5_Slider_SizeY)
                          .setNumberOfTickMarks(_DrawImage.DrawImage_Data_Num)
                          .showTickMarks(false);
      Seekbar_ReInit = false;
      
      ////Update draw_Speed
      //draw_Speed = _DrawImage.DrawImage_GetData_Num() / 900;
    }
    //---Animation---
    //Update
    _DrawImage.DrawImage_Update(draw_Cnt);
    
    //Draw
    _DrawImage.DrawImage_Draw();
    
    //Update Flag_Stop
    CP5_Update_StartAndStop();
    
    //Conditional branch by Flag_Reset
    if( Flag_Reset == true )
    {
      draw_Cnt = 0;
      draw_newCnt = 0;
      draw_oldCnt = 0;    
      
      //"Reset" is not executable
      Flag_Reset = false;
    }
    else
    {
      //Set oldCnt
      draw_oldCnt = draw_Cnt;
      
      //Get now "Seekbar's" value
      CP5_Slider_nowValue = CP5_Slider.getController("SeekBar")
                              .getValue();
                              
      println("oldCnt"+draw_oldCnt+"nowValue"+CP5_Slider_nowValue);
      
      //Check "Seekbar" and Update "draw_Cnt"
      if( CP5_Slider_nowValue < (float)draw_oldCnt+0.5 &&
          CP5_Slider_nowValue > (float)draw_oldCnt-0.5  )
      {//"Seekbar" is not changed by user
        draw_newCnt = draw_oldCnt + draw_Speed;
      }
      else
      {//"Seekbar" is changed by user
        draw_newCnt = (int)CP5_Slider_nowValue;
      }
      //Conditional branch by Flag_Stop
      if( Flag_Stop == false )
      {//Don't stop(Running)      
        if(draw_newCnt < _DrawImage.Data_Num)
        {
          if(_DrawImage.Data_Num-draw_newCnt < draw_Speed)
          {
            draw_newCnt = _DrawImage.Data_Num - 1;
          }
          
          draw_Cnt = draw_newCnt;
        }
        else
        {
          //"Stop" is executable
          Flag_Stop = true;
        }
      }
      else
      {//Stop
        if( CP5_Slider_nowValue < (float)draw_oldCnt+0.5 &&
          CP5_Slider_nowValue > (float)draw_oldCnt-0.5  )
        {//"Seekbar" is not changed by user
        }
        else
        {
          draw_Cnt = draw_newCnt;
        }
      }
    }
    
    println("Cnt"+draw_Cnt);
    Seekbar.setValue((float)draw_Cnt);
    
    //Thinking-bar
    int tmp_point;
    int tmp_length;
    int tmp_cnt = 0;
    while( (tmp_point = _DrawImage.DrawImage_GetStop_Point(tmp_cnt)) != -1 &&
           (tmp_length = _DrawImage.DrawImage_GetStop_Length(tmp_cnt)) != -1) 
    {
      fill(255,128,0);
      rect(tmp_point*width/_DrawImage.DrawImage_Data_Num,
           CP5_Slider_PosY-2,
           tmp_length*width/_DrawImage.DrawImage_Data_Num,
           CP5_Slider_SizeY+4);
      tmp_cnt++; 
    }
    //---Animation---End
  }
  else
  {//Slider = 1 or 2
    //"Seekbar_ReInit" flag -> true
    Seekbar_ReInit = true;
    
    
    if(video.available())
    {
      background(100);
      video.read();
      set(0,0,video);
      loadPixels();
      movement=false;
      for(int i=0;i<w*h;i++)
      {     
        float difRed=abs(red(exColor[i])-red(video.pixels[i]));
        float difGreen=abs(green(exColor[i])-green(video.pixels[i]));
        float difBlue=abs(blue(exColor[i])-blue(video.pixels[i]));
          if(difRed>tolerance && difGreen>tolerance && difBlue>tolerance)
          {
            movement=true;
            //pixels[i]=color(0,0,255);
            sumX+=i%w;
            sumY+=i/w;
            pixelNum++;
          }
          exColor[i]=video.pixels[i];
      }
      updatePixels();
      if(movement==true)
      {
        x=sumX/pixelNum;
        y=sumY/pixelNum;     
        sumX=0;
        sumY=0;
        pixelNum=0;
      }
    } 
  }
}
//---draw---End




//---ScreenShot---
PImage screenshot() {
  try {
    Robot robot = new Robot();
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
    BufferedImage img = robot.createScreenCapture(new Rectangle(screenSize));
    return b2p(img);
  }
  catch(Exception e) {
  }
  return null;
}
PImage b2p(BufferedImage img1) {
  PImage img2 = createImage(img1.getWidth(), img1.getHeight(), ARGB);
 
  for (int i = 0; i < img2.width; i++) {
    for (int j = 0; j < img2.height; j++) {
      
      img2.pixels[i + j * img2.width] = img1.getRGB(i, j);
    }
  }
  img2.save("data/Time"+T+".png");
  //_DrawImage.Data_Initialize();
  return img2;
}
public void Close()
{
  _DrawImage.DrawImage_Finalize();
  exit();
}
//---ScreenShot---End 
  


//---Animation---
//---CP5_Button---
//Start and stop
//Action
void StartAndStop()
{
  Flag_Stop = !Flag_Stop;
  println("Flag_Stop is changed:"+Flag_Stop);
}
//Update
void CP5_Update_StartAndStop()
{
  if( Flag_Stop == false )
  {
    Stop.setCaptionLabel("STOP");
    Stop.setColorBackground(color(255,0,0));
  }
  else
  {
    Stop.setCaptionLabel("START");
    Stop.setColorBackground(color(0,0,255));    
  }
}

//Reset
//Action
void Reset()
{
  Flag_Reset = !Flag_Reset;
}
//Update
void CP5_Update_Reset()
{
}
//---CP5_Button---End
//---Animation---End
