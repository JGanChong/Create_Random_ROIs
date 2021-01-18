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
ROI_height = 100; //Height of desired ROI in Pixels
ROI_width = 100; //Width of desidred ROI in Pixels
min_distance = 125; //Minimum distance between ROI in Pixels
number_of_ROI = 50; //Number of ROIs to create
Use_BorderToBorder = true; //Set true if you want the minimum distance be calculated border-border instead of center to center
max_try = 500; //How many iterations to go over before deciding its too much

//chanage calculation if border to border is true
if (Use_BorderToBorder == true) {
	min_distance = min_distance + ((sqrt(pow(ROI_height,2)+pow(ROI_width,2)))/2);
}

//get image dimensions
getDimensions(width, height, channels, slices, frames);

//set new max width and height so ROIs are not outside image
nMaxWidth = width - (2*ROI_width);
nMaxHeight = height - (2*ROI_height);

//Create Array to store good ROI centers
goodx = newArray;
goody = newArray;

//create first point
randx = (random*nMaxWidth)+ROI_width;
randy = (random*nMaxHeight)+ROI_height;
randx = round(randx);
randy = round(randy);
goodx[0] = randx;
goody[0] = randy;


//Iterate to find other points that match user settings
for (i = 1; i < number_of_ROI; i++) {
	pass = 0;
	count = 0;
	try = 0;

	//Loop over randomly generated X and Y
	while (pass == 0) {
		try++;
		randx = (random*nMaxWidth)+ROI_width;
		randy = (random*nMaxHeight)+ROI_height;
		
		randx = round(randx);
		randy = round(randy);

		//Check that randomly generated (x,y) satisfy distance
		for (x = 0; x < goodx.length; x++) {
			
			distance = sqrt( pow(randx-goodx[x],2) + pow(randy-goody[x],2) );


			if (distance > min_distance) {
				count++;				
			}
			
			
		}
		
		if (count == goodx.length) {
			goodx[i] = randx;
			goody[i] = randy;
			
			pass = 1;
		}
		else {
			count = 0;
		}

		//exit if iterations exceed user set value
		if (try == max_try) {
			exit("No arrangement found to accomodate user settings after "+try+" trials." );	
		}
	}
	

	
}

//Add ROIs to manager
roiManager("reset")
run("ROI Manager...");
for (i = 0; i < goodx.length; i++) {
	makeRectangle(goodx[i]-(ROI_width/2), goody[i]-(ROI_height/2), ROI_width, ROI_height);
	roiManager("Add");
}
//Rename ROIs for easy selection of ROIs
for (i = 0; i < goodx.length; i++) {
	roiManager("Select", i);
	roiManager("Rename", i+1);
}
roiManager("Show All with labels");

