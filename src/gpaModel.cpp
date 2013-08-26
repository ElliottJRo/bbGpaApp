#include "gpaModel.h"

float computeCGPA(float currentGpa, float unitsNumberPassed, QVariantList  grades , QVariantList courseUnits , int size){
	float totalUnits(0) , totalGradePoints(0) , termGPA(0) , cGPA(0);


	for (int i=0 ; i<size ; i++){
		totalUnits += courseUnits[i].toFloat();  // ADDITION OF TOTAL UNITS OF  EACH COURSE TAKEN
		totalGradePoints += (computeGradePoints(grades[i]) * courseUnits[i].toFloat()) ;	// TOTAL GRADEPOINTS WILL BE ADDED ONE BY ONE
	}
	termGPA = totalGradePoints / totalUnits ; // WILL GIVE THE GPA OF CURRENT SEMESTER oF ALL THE COURSE THAT ARE ON THE GRADELIST
	cGPA =(	(currentGpa*unitsNumberPassed)+(totalGradePoints) ) / (totalUnits + unitsNumberPassed ) ; // (PREVIOUSGRADEPOINTS + CURRENTGRADEPOINTS) / TOTAL UNITS ALL TOGETHER

	return cGPA ;

}

float computeGradePoints(QVariant c){
	float gradePoint(0) ;

	if (c=="A+" || c=="a+"){
		gradePoint = 4.33 ;
	}
	else if(c=="A" || c=="a"){
		gradePoint = 4.00 ;
	}
	else if (c=="A-" || c=="a-"){
		gradePoint = 3.7 ;
	}
	else if (c=="B+" || c=="b+"){
		gradePoint = 3.33 ;
	}
	else if (c=="B" || c=="b"){
		gradePoint = 3.00 ;
	}
	else if (c=="B-"|| c=="b-"){
		gradePoint = 2.7 ;
	}
	else if (c=="C+" || c=="c+"){
		gradePoint = 2.30 ;
	}
	else if (c=="C" || c=="c"){
		gradePoint = 2.00 ;
	}
	else if (c=="C-" || c=="c-"){
		gradePoint = 1.70 ;
	}
	else if (c=="D" || c=="d"){
		gradePoint = 1.00 ;
	}
	else if (c=="F" || c=="f") {					// FAIL
		gradePoint = 0.00 ;
	}

	return gradePoint ;

}
