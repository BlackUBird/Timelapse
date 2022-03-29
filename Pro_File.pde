import java.io.File;
import java.io.FilenameFilter;



public class PngFileFilter implements FilenameFilter
{
   @Override
   //determine : png or not
   public boolean accept(File directory, String fileName)
   {
    if(fileName.endsWith(".png"))
    {
      return true;
    }
    return false;
  }
}
