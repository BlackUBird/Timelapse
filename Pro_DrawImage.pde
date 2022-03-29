


class Pro_DrawImage extends Pro_Data
{
  int DrawImage_Cnt;
  PImage DrawImage_PImage;
  
  int DrawImage_Data_Num;
  int DrawImage_Data_Num_Real;
  int DrawImage_Data_Num_First;
  
  boolean DrawImage_Flag_Stop;
  
  int[] DrawImage_Stop_Point = new int[1];
  int[] DrawImage_Stop_Length = new int[1];
  
  //Thinking:100F
  final int thinking = 100;
  
  //Constructor
  Pro_DrawImage()
  {
    //Call "Pro_Data"
    super();
    
    DrawImage_Initialize();
  }
  
  //Reset
  void DrawImage_Initialize()
  {
    //Initialize "Pro_Data"
    super.Data_Initialize();
    //Initialize
    DrawImage_Cnt = 0;
    DrawImage_Data_Num = super.Data_GetNum();  //index num of array = this - 1
    DrawImage_Data_Num_Real = super.Data_GetNum_Real();
    DrawImage_Data_Num_First = super.Data_GetNum_First();
    
    //Stop point
    int tmp_cnt = 0;
    while(tmp_cnt < DrawImage_Data_Num_Real)
    {
      if(super.Data_Num_Existed[tmp_cnt+1]-super.Data_Num_Existed[tmp_cnt] >= thinking)
      {
        DrawImage_Stop_Point = append(DrawImage_Stop_Point,super.Data_Num_Existed[tmp_cnt]);
        DrawImage_Stop_Length = append(DrawImage_Stop_Length,super.Data_Num_Existed[tmp_cnt+1]-super.Data_Num_Existed[tmp_cnt]);
      }
      
      tmp_cnt++;
    }
  }

  //Update
  void DrawImage_Update(int newCnt)
  {
    if( newCnt > (DrawImage_Data_Num - 1) )
    {
      DrawImage_Cnt = 0;
      DrawImage_PImage = loadImage("Time"+DrawImage_Data_Num_First+".png");
      return;
    }
    else
    {
      DrawImage_Cnt = newCnt;
    }
    
    //println(DrawImage_Cnt);
    
    //Update DrawImage_PImage
    int tmp_cnt = 1;
    while( super.Data_Num_Existed[tmp_cnt] < DrawImage_Cnt)
    {
      tmp_cnt += 1;
    }
    
    //if(super.Data_Num_Existed[tmp_cnt] != DrawImage_Cnt)
    //{
    //  DrawImage_Flag_Stop = true;
    //}
    //else
    //{ 
    //  DrawImage_Flag_Stop = false;
    //}
    
    if(super.Data_Num_Existed[tmp_cnt]-super.Data_Num_Existed[tmp_cnt-1] < thinking)
    {
      DrawImage_Flag_Stop = false;
    }
    else
    {
      DrawImage_Flag_Stop = true;
    }
    
    DrawImage_PImage = loadImage("Time"+super.Data_Num_Existed[tmp_cnt]+".png");
  }
  
  //Draw
  void DrawImage_Draw()
  {    
    //Draw image
    if(DrawImage_PImage != null)
    {//Image could be found
      //Resize
      DrawImage_PImage.resize(DrawImage_PImage.width/2,
                              DrawImage_PImage.height/2);
      //Draw now image
      image(DrawImage_PImage,0,0);
    }
    else
    {//Image could not be found
      //Draw before image
    }
  }
  
  //Get
  int DrawImage_GetCnt()
  {
    println("DrawImage_GetCnt() : complete");
    return DrawImage_Cnt;
  }
  int DrawImage_GetData_Num()
  {
    println("DrawImage_GetData_Num() : complete");
    return DrawImage_Data_Num;
  }
  int DrawImage_GetData_Num_Real()
  {
    println("DrawImage_GetData_Num_Real() : complete");
    return DrawImage_Data_Num_Real;
  }
  int DrawImage_GetData_Num_First()
  {
    println("DrawImage_GetData_Num_First() : complete");
    return DrawImage_Data_Num_First;
  }
  boolean DrawImage_GetFlag_Stop()
  {
    println("DrawImage_GetData_Num_First() : complete");
    return DrawImage_Flag_Stop;
  }
  int DrawImage_GetStop_Point(int Cnt)
  {
    if(Cnt < DrawImage_Stop_Point.length )
    {
      println("DrawImage_GetStop_Point(int Cnt) : complete :"+DrawImage_Stop_Point[Cnt]);
      return DrawImage_Stop_Point[Cnt];
    }
    else
    {
      println("DrawImage_GetStop_Point(int Cnt) : complete :"+-1);
      return -1;
    }
  }
  int DrawImage_GetStop_Length(int Cnt)
  {
    if(Cnt < DrawImage_Stop_Point.length )
    {
      println("DrawImage_GetStop_Length(int Cnt) : complete :"+DrawImage_Stop_Length[Cnt]);
      return DrawImage_Stop_Length[Cnt];
    }
    else
    {
      println("DrawImage_GetStop_Length(int Cnt) : complete :"+-1);
      return -1;
    }
  }
  
  //Set
  void DrawImage_SetCnt(int newCnt)
  {
    DrawImage_Cnt = newCnt;
    println("DrawImage_SetCnt() : complete");
  }
  void DrawImage_SetData_Num(int newData_Num)
  {
    DrawImage_Data_Num = newData_Num;
    println("DrawImage_SetData_Num() : complete");
  }
  void DrawImage_SetData_Num_Real(int newData_Num_Real)
  {
    DrawImage_Data_Num_Real = newData_Num_Real;
    println("DrawImage_SetData_Num_Real() : complete");
  }
  void DrawImage_SetData_Num_First(int newData_Num_First)
  {
    DrawImage_Data_Num_First = newData_Num_First;
    println("DrawImage_SetData_Num_First() : complete");
  }
  void DrawImage_SetFlag_Stop(boolean newFlag_Stop)
  {
    DrawImage_Flag_Stop = newFlag_Stop;
    println("DrawImage_GetData_Num_First() : complete");
  }
  void DrawImage_SetPimage(PImage newPImage)
  {
    DrawImage_PImage = newPImage;
    println("DrawImage_SetPImage() : complete");
  }
  
  //Finalize
  void DrawImage_Finalize()
  {
    super.Data_Finalize();
  }
}
