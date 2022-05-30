#ifndef FUNC_H
#define FUNC_H

double twd_to_usd(double twd)		{return twd*0.033791;}
double twd_to_jpy(double twd)		{return twd*3.62;}

// Calculate factorial
double factorial(double n) 
{
	double x; double f=1;
	
	for (x=1; x<=n; x++) { 
		f *= x; 
	}
	
	return f;
}

// Calculate modulus
int modulo(double x, double y) 
{
	return (int)x % (int)y;
}

#endif