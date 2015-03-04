#include <stdio.h>
#include <string.h>
#include <dirent.h>
#include <stdlib.h>
#include <cv.h>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;

int main()
{
  Size t = Size(240,320);
  cv::VideoWriter writer;
  writer.open ( "test.avi", CV_FOURCC('P','I','M','1'), 25, cv::Size ( 320,240), 0 );
  struct dirent **namelist;
  Mat Mean = Mat::zeros(240, 320,CV_64F);
  Mat Deviation = Mat::zeros(240, 320,CV_64F);
  Mat tmp = Mat::zeros(240, 320,CV_64F);
  float alpha = 0.99;
  float beta = 3;
  //Mean calculation
  int n = scandir("./input", &namelist, 0, alphasort);
  if (n < 0)
    perror("scandir");
  else {
    for (int i = 2; i < 152; i++) {
      std::string buf("./input/");
      buf.append(namelist[i]->d_name);
      tmp = imread(buf,0);
      tmp.convertTo(tmp,CV_64F);
      accumulate(tmp,Mean);
    }   
  }

  free(namelist);
  Mean = Mean / 150;

  //Sd calculation
  n = scandir("./input", &namelist, 0, alphasort);
  if (n < 0)
    perror("scandir");
  else {
    for (int i = 2; i < 152; i++) {
      std::string buf("./input/");
      buf.append(namelist[i]->d_name);
      tmp = imread(buf,0);
      tmp.convertTo(tmp,CV_64F);
      tmp -= Mean;
      accumulateSquare(tmp,Deviation);
    }
  }
  free(namelist);

  Deviation = Deviation/(150);

  cv::sqrt(Deviation,Deviation);


  //Background substraction
  //Sd calculation
  n = scandir("./input", &namelist, 0, alphasort);
  if (n < 0)
    perror("scandir");
  else {
    for (int i = 2; i < 152; i++) {
      std::string buf("./input/");
      buf.append(namelist[i]->d_name);
      tmp = imread(buf,0);
      tmp.convertTo(tmp,CV_64F);
      tmp = abs(tmp-Mean) > alpha*(Deviation + beta);
      writer.write(tmp);
    }
  }
  free(namelist);
  Deviation.convertTo(Deviation,CV_8UC1);
  Mean.convertTo(Mean,CV_8UC1);

  imshow( "Display window", tmp );                   // Show our image inside it.

  waitKey(0);                                          // Wait for a keystroke in the window
  return 0;
} 