# Create_Random_ROIs
/*  Creates a number of randomly generated non overlapping ROIs with the width, height and distance set by the user.
 *  
 *  Macro Instructions:
 * Under User variables, change the width, height and min distance as desired
 *  
 * Macro tested with ImageJ 1.53g, Java 1.8.0_172 (64bit) Windows 10
 * Macro by Johnny Gan Chong email:behappyftw@g.ucla.edu 
 * January 2021
 */
 
 
 Min distance: distance between ROIs. Left 10, right 50:
 ![image](https://user-images.githubusercontent.com/74852180/112775593-2f19a700-8ff2-11eb-9801-234515643d5c.png)

Change size of ROI using ROI_height and ROI_width
![image](https://user-images.githubusercontent.com/74852180/112775622-4789c180-8ff2-11eb-9cc4-e7618d4ac9cc.png)

Change whether min distance is calculated from the center or from the border of ROI. Calculating from center may have overlapping ROIs if height/width is bigger than min distance.
Left: Use_BorderToBorder = false, right: Use_BorderToBorder = true
![image](https://user-images.githubusercontent.com/74852180/112775806-cf6fcb80-8ff2-11eb-9e69-ae0ba84de4bf.png)

Change max_try to however many iterations to run before giving up.

