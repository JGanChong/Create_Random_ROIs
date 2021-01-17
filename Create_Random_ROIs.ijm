/*  Creates a number of randomly generated non overlapping ROIs with the width, height and distance set by the user.
 *  
 *  Macro Instructions:
 * Under User variables, change the width, height and min distance as desired
 *  
 * Macro tested with ImageJ 1.53g, Java 1.8.0_172 (64bit) Windows 10
 * Macro by Johnny Gan Chong email:behappyftw@g.ucla.edu 
 * January 2021
 */

//User Variables:
ROI_height = 50; //Height of desired ROI
ROI_width = 100; //Width of desidred ROI
min_distance = 50; //Minimum distance between ROI
number_of_ROI = 50; //Number of ROIs to create


//get width and height of original image
getDimensions(width, height, channels, slices, frames);

//get name of the original image
title=getTitle();

//set batchmode on
setBatchMode(true);

//create Array to store the ROIs
goodx = newArray;
goody = newArray;

//Create dummy image
newImage("ROI_img",  "8-bit black", width, height, 1);
setOption("BlackBackground", true);
setBackgroundColor(0, 0, 0);
setForegroundColor(255, 255,255);

//Create padding for the image so ROIs are not outside boundary
makeRectangle(ROI_width, ROI_height, width-(2*ROI_width), height-(2*ROI_height));
run("Fill", "slice");
run("Select None");
run("Auto Threshold", "method=Default white");
run("Create Selection");

//create pseudo ROIs width and height
nwidth = (2*ROI_width)+min_distance;
nheight = (2*ROI_height)+min_distance;


//Iterate to create the ROIs
for (i = 0; i < number_of_ROI; i++) {
	
	//Error message if the macro couldnt fit the ROis in the image
	if(selectionType == -1){
		close("ROI_img");
		exit("This random iteration did not find a way to fit all ROIs."+"\n"+"Please decrease ROI size/Minimum distance."+"\n"+"If you believe they should fit, rerun macro again until it finds the correct combination.");
	}

	//get list of available X and Y points
	Roi.getContainedPoints(xpoints, ypoints);	

	//Randomly selects a point
	rand = random*xpoints.length;
	rand = round(rand);
	
	randx = xpoints[rand];
	randy = ypoints[rand];

	//Add those points to array to create ROIs
	goodx[i] = randx;
	goody[i] = randy;

	x = randx-(nwidth)/2;
	y = randy-(nheight)/2;

	//Create pseudo ROI
	makeRectangle(x, y,nwidth ,nheight );

	//Remove from avaialbe points
	run("Clear", "slice");	
	run("Select None");
	run("Create Selection");

	
}


//Closes dummy image
close("ROI_img");
//Exits Batch mode
setBatchMode("exit and display");


//Runs the Roi Manager and resets it
run("ROI Manager...");
roiManager("reset")

//Creates the ROIs in the original image
selectImage(title);

for (i = 0; i < goodx.length; i++) {

	x = goodx[i]-(ROI_width/2);
	y = goody[i]-(ROI_height/2);
	
	makeRectangle(x, y, ROI_width, ROI_height);
	roiManager("Add");

}
//Rename ROIs for easy selection of ROIs
for (i = 0; i < goodx.length; i++) {
	roiManager("Select", i);
	roiManager("Rename", i+1);
}

roiManager("Show All without labels");
roiManager("Show All with labels");
