import java.io.File;
import java.util.Arrays;



class Pro_Data
{
  //Files of graphics
  File[] Data_Files;
  //Filter
  PngFileFilter Data_Filter;
  //Number of data
  int Data_Num = 0;
  int Data_Num_Real = 0;  //=Number of files
  int Data_Num_First = 0;
  //Number of existed file
  int[] Data_Num_Existed = new int[1];
  
  //Constructor
  Pro_Data()
  {
    Data_Initialize();
    println("Constructor Pro_Data() : complete");
  }
  
  //Initializer
  void Data_Initialize()
  {
    //Load files at "data"
    Data_LoadFile();
    
    //Set number of data
    Data_Num_Real = Data_GetFileRealNum();
    Data_Num_First = Data_GetFileFirstNum();
    Data_Num = Data_GetFileNum();
    
    //Set existed file numbers
    Data_SetNum_Existed();
    
    println("Data_Initialize() : complete");
  }
  
  //Load image files
  void Data_LoadFile()
  {
    //Make new filter
    Data_Filter = new PngFileFilter();
    //Load files
    Data_Files = new File(dataPath("")).listFiles(Data_Filter);
    
    println("Data_LoadFile() : complete");
  }
  
  //Return real number of files at "F:/souzou/processing/Pro_4_211216a/data"
  int Data_GetFileRealNum()
  {
    int cnt = 0;  //Number of files
    //Count
    for(File file : Data_Files)
    {
      cnt++;
    }
      
    //Return number of files
    println("Data_GetFileRealNum() : complete : return = "+cnt);
    return cnt;
  }
  
  //Return number of files
  int Data_GetFileNum()
  {
    //Counter
    int cnt = 0;
    int existcnt = 0;
    
    //File num
    int filenum;
    filenum = Data_GetFileRealNum();
    
    //File name
    String fname1;
    String fname2;
    
    //Count
    while(existcnt != filenum)
    {
      fname1 = new String("Time"+cnt+".png");
      
      for(File file : Data_Files)
      {
        fname2 = file.getName();
        
        //Compare
        if( fname1.equals(fname2) )
        {//true
          existcnt += 1;
        }
        else
        {
        }
      }
      
      cnt += 1;
    }
    
    println("Data_GetFileNum() : complete : return = "+cnt);
    return cnt;  //Return number of files(Index num of array = cnt - 1)
  }
  
  //Return number of first files
  int Data_GetFileFirstNum()
  {
    int cnt = 0;
    boolean endflag = true;
    
    //File name
    String fname1;
    String fname2;
    
    //Count
    while(endflag)
    {
      fname1 = new String("Time"+cnt+".png");
      
      for(File file : Data_Files)
      {
        fname2 = file.getName();
        
        //Compare
        if( fname1.equals(fname2) )
        {//true
          endflag = false;
        }
        else
        {
        }
      }
      
      if(endflag)
      {
        cnt += 1;
      }
    }
    
    println("Data_GetFileFirstNum() : complete : return = "+cnt);
    return cnt;  //Return first number of files
  }
  
  //Get
  int Data_GetNum()
  {
    println("Data_GetNum() : complete");
    return Data_Num;
  }
  int Data_GetNum_Real()
  {
    println("Data_GetNum_Real() : complete");
    return Data_Num_Real;
  }
  int Data_GetNum_First()
  {
    println("Data_GetNum_First() : complete");
    return Data_Num_First;
  }
  int Data_GetNum_Existed(int index)
  {
    println("Data_GetNum_Existed() : complete");
    return Data_Num_Existed[index];
  }
  
  //Set
  void Data_SetNum(int newNum)
  {
    println("Data_SetNum() : complete");
    Data_Num = newNum;
  }
  void Data_SetNum_Real(int newNum_Real)
  {
    println("Data_SetNum_Real() : complete");
    Data_Num_Real = newNum_Real;
  }
  void Data_SetNum_First(int newNum_First)
  {
    println("Data_SetNum_First() : complete");
    Data_Num_First = newNum_First;
  }
  void Data_SetNum_Existed()
  {
    //Counter
    int cnt = 0;
    int existcnt = 0;
    
    //File num
    int filenum;
    filenum = Data_GetFileRealNum();
    
    //Count
    while(existcnt != filenum)
    {
      //Target name
      String fname1 = new String("Time"+cnt+".png");
      
      for(File file : Data_Files)
      {
        //Tempolrry
        String fname2 = file.getName();
        
        //Compare
        if( fname1.equals(fname2) )
        {//true
          Data_Num_Existed = append(Data_Num_Existed,cnt);
          existcnt += 1;
        }
        else
        {
        }
      }
      
      cnt += 1;
    }
    
    println("Data_SetNum_Existed() : complete");
  }
  
  //Print
  void Data_PrintNum()
  {
    println("Data_Num : "+Data_Num);
    println("Data_PrintNum() : complete");
  }
  void Data_PrintNum_Real()
  {
    println("Data_Num_Real : "+Data_Num_Real);
    println("Data_PrintNum_Real() : complete");
  }
  void Data_PrintNum_First()
  {
    println("Data_Num_First : "+Data_Num_First);
    println("Data_PrintNum_First() : complete");
  }
  void Data_PrintNum_Existed(int index)
  {
    println("Data_Num_Existed["+index+"] : "+Data_Num_Existed[index]);
    println("Data_PrintNum_Existed() : complete");
  }
  void Data_PrintNum_Existed_ALL()
  {
    for(int index = 0 ; index < Data_Num_Existed.length ; index++)
    {
      println("Data_Num_Existed["+index+"] : "+Data_Num_Existed[index]);
    }
    println("Data_PrintNum_Existed_ALL() : complete");
  }
  
  
  //Finalize
  void Data_Finalize()
  {
    //Delete file
    for(File file : Data_Files)
    {
      if(file.delete())
      {
        println(file.getName()+" is deleted.");
      }
      else
      {
        println(file.getName()+" is not deleted."); 
      }
    }
  }
}
