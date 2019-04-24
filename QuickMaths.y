
%{
	#include <stdio.h>
	#include <stdlib.h>
	int yylex();

	int value[10];
	char * name[10];
	int counter;


int main(int argc, char *argv[])
{
	FILE *fp;
	extern FILE *yyin;
	extern int yyparse();


	if(argc>1)
	{
		if((fp = fopen(argv[1],"r")) == 0)
			fprintf(stderr, "Cannot oepn file %s\n", argv[1]);
		else 
		{
			yyin = fp;
			yyparse();
			fprintf(stdout, "finished parse\n");
		}
	}
	else 
		fprintf(stderr, "Usage %s <filename>\n",argv[0]);		
}

int yyerror(const char *err)
{
	fprintf(stderr,"Error: %s\n",err);
}

%}
%union
{
	char *string;
	int value;
	int name[10];
}
%token <string>VAR 
%token <value>NUM 
%token EQUALS 
%token PLUS
%token MINUS 
%token FLOAT
%token IS
%token DIVIDED
%token TIMES

%%	
	statements:			statements statement	
					|
					statement	
					;

	statement:			EQUALS VAR			{//fprintf(stdout,"Var print\n");
									for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										//fprintf(stdout,"%s = %d\n", $2,value[i]);
									}
									fprintf(stdout,"name: %s value: %d\n", name[i],value[i]);
								}
							}
					|
					EQUALS NUM			{fprintf(stdout, "Answer: %d\n",$2);}
					|
					EQUALS NUM PLUS NUM		{fprintf(stdout, "Answer: %d\n", $2 + $4);}
					|
					EQUALS NUM PLUS VAR		{for(int i = 0;i<counter;i++){
									if(strcmp($4,name[i])== 0){
										fprintf(stdout,"Answer: %d\n", value[i]+$2);
									}
								}
							}
					|
					EQUALS VAR PLUS NUM		{for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										fprintf(stdout,"Answer: %d\n", value[i]+$4);
									}
								}
							}
					|
					EQUALS VAR PLUS VAR		{int temp;int temp2;
									for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										 temp = i;
										}	
									if(strcmp($4,name[i])== 0){
											 temp2 = i;
											
										}
									}	
									fprintf(stdout,"Answer: %d\n", value[temp2]+value[temp]);
								}
							
					|
					EQUALS NUM MINUS NUM		{fprintf(stdout, "Answer: %d\n", $2 - $4);}
					|
					EQUALS NUM MINUS VAR		{for(int i = 0;i<counter;i++){
									if(strcmp($4,name[i])== 0){
										fprintf(stdout,"Answer: %d\n", value[i]-$2);
									}
								}
							}
					|
					EQUALS VAR MINUS NUM		{for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										fprintf(stdout,"Answer: %d\n", value[i]-$4);
									}
								}
							}
					|
					EQUALS VAR MINUS VAR		{for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										int temp = i;
										
										if(strcmp($4,name[i])== 0){
											fprintf(stdout,"Answer: %d\n", value[i]-value[temp]);
										}
									}
								}
							}
					|
					EQUALS NUM TIMES NUM		{fprintf(stdout, "Answer: %d\n", $2 * $4);}
					|
					EQUALS NUM TIMES VAR		{for(int i = 0;i<counter;i++){
									if(strcmp($4,name[i])== 0){
										fprintf(stdout,"Answer: %d\n", value[i]+$2);
									}
								}
							}
					|
					EQUALS VAR TIMES NUM		{for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										fprintf(stdout,"Answer: %d\n", value[i]*$4);
									}
								}
							}
					|
					EQUALS VAR TIMES VAR		{for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										int temp = i;
										
										if(strcmp($4,name[i])== 0){
											fprintf(stdout,"Answer: %d\n", value[i]*value[temp]);
										}
									}
								}
							}
					
					|
					EQUALS NUM DIVIDED NUM		{fprintf(stdout, "Answer: %f\n", $2 / $4);}
					|
					EQUALS NUM DIVIDED VAR		{for(int i = 0;i<10;i++){
									if(strcmp($4,name[i])== 0){
										fprintf(stdout,"Answer: %f\n", value[i]/$2);
									}
								}
							}
					|
					EQUALS VAR DIVIDED NUM		{for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										fprintf(stdout,"Answer: %f\n", value[i]/$4);
									}
								}
							}
					|
					EQUALS VAR DIVIDED VAR		{for(int i = 0;i<counter;i++){
									if(strcmp($2,name[i])== 0){
										int temp = i;
										
										if(strcmp($4,name[i])== 0){
											fprintf(stdout,"Answer: %f\n", value[i]/value[temp]);
										}
									}
								}
							}
					|
					VAR IS VAR	{
								int temp = 1;
								int index;
								for(int i = 0;i<counter;i++){
									if(strcmp($1,name[i])== 0)
									{
										index = i;
										temp = 0;
									}
									if(strcmp($3,name[i])== 0)
									{
										value[index] = value[i];
										
									}
								}
								if(temp == 1){
									name[counter] = $1;
									value[counter] = $3;
									counter++;
									fprintf(stdout,"Var: %s, num: %d\n", $1, $3);
								}
							fprintf(stdout,"var: %s \n",$1);
							}
					|
					VAR IS NUM			{//fprintf(stdout,"Var is num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){
fprintf(stdout,"Var isdfsdfs num\n");	
										if(strcmp($1,name[i])== 0){
fprintf(stdout,"Var is numqqfffeef\n");
											value[i]=$3;
											temp = 0;
												}
										
											}
									if(temp == 1){
										
											name[counter] = $1;
											value[counter] = $3;
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3);
										}
									}
					|	
					VAR IS NUM PLUS NUM		{fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											value[i]=$3 + $5;
											temp = 0;
												}
										
											}
									if(temp == 1){
										
											name[counter] = $1;
											value[counter] = $3 + $5;
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
										}
									}
					|
					VAR IS NUM PLUS VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($5,name[i])== 0){
												value[index]=$3 + value[i];	
												temp = 0;
													}
											
											
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = $3 + value[i];
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
											}
										}
									}
					|
					VAR IS VAR PLUS VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if($3==name[i]){
												int temp= i;	
												
													}
											if(strcmp($5,name[i])== 0){
												value[index]= value[temp]+ value[i];
													}
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if($3==name[i]){
											
											temp = i;
											}
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = value[temp] + value[i];
											counter++;
											}
										}
										
										
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
									}
					|
					VAR IS VAR PLUS NUM		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									fprintf(stdout,"temp1: %d\n", temp);
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($3,name[i])== 0){
												value[index]=$5 + value[i];	
												temp = 0;
													}
												}
												//fprintf(stdout,"temp1: %d\n", temp);
										
											}
									//fprintf(stdout,"temp1: %d\n", temp);
									if(temp == 1){
										
										for(int i = 0;i<counter;i++){
											//fprintf(stdout,"temp3: %d\n", temp);
											if(strcmp($3,name[i])== 0){
											//fprintf(stdout,"temp4: %d\n", temp);
											int blub = value[i];
											value[counter] = $5 + blub;
											name[counter] = $1;
											counter++;
											//fprintf(stdout,"Var: %s, num: %d, counter: %d\n", $1, value[counter], counter);
												}
											}
										}
									}
					|
					VAR IS NUM MINUS NUM		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											value[i]=$3 - $5;
											temp = 0;
												}
										
											}
									if(temp == 1){
										
											name[counter] = $1;
											value[counter] = $3 + $5;
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 - $5);
										}
									}
					|
					VAR IS NUM MINUS VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($5,name[i])== 0){
												value[index]=$3 - value[i];	
												temp = 0;
													}
											
											
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = $3 + value[i];
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 - $5);
												}
											}
										}
									}
					|
					VAR IS VAR MINUS VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($3,name[i])== 0){
												int temp= i;	
												
													}
											if(strcmp($5,name[i])== 0){
												value[index]= value[temp] - value[i];
													}
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($3,name[i])== 0){
											
											temp = i;
											}
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = value[temp] - value[i];
											counter++;
											}
										}
										
										
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
									}
					|
					VAR IS VAR MINUS NUM		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($3,name[i])== 0){
												value[index]=$5 - value[i];	
												temp = 0;
													}
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($3,name[i])== 0){
											name[counter] = $1;
											value[counter] = $5 - value[i];
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
											}
										}
									}
					|
					VAR IS NUM TIMES NUM		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											value[i]=$3 * $5;
											temp = 0;
												}
										
											}
									if(temp == 1){
										
											name[counter] = $1;
											value[counter] = $3 * $5;
											counter++;
											fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
										}
									}
					|
					VAR IS NUM TIMES VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($5,name[i])== 0){
												value[index]=$3 * value[i];	
												temp = 0;
													}
											
											
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = $3 * value[i];
											counter++;
											fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
											}
										}
									}
					|
					VAR IS VAR TIMES VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($3,name[i])== 0){
												int temp= i;	
												
													}
											if(strcmp($5,name[i])== 0){
												value[index]= value[temp] * value[i];
													}
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($3,name[i])== 0){
											
											temp = i;
											}
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = value[temp] * value[i];
											counter++;
											}
										}
										
										
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 / $5);
												}
									}
					|
					VAR IS VAR TIMES NUM		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($3,name[i])== 0){
												value[index]=$5 * value[i];	
												temp = 0;
													}
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($3,name[i])== 0){
											name[counter] = $1;
											value[counter] = $5 * value[i];
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 / $5);
												}
											}
										}
									}
					|
					VAR IS NUM DIVIDED NUM		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											value[i]=$3 / $5;
											temp = 0;
												}
										
											}
									if(temp == 1){
										
											name[counter] = $1;
											value[counter] = $3 + $5;
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 / $5);
										}
									}
					|
					VAR IS NUM DIVIDED VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($5,name[i])== 0){
												value[index]=$3 / value[i];	
												temp = 0;
													}
											
											
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = $3 / value[i];
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
											}
										}
									}
					|
					VAR IS VAR DIVIDED VAR		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($3,name[i])== 0){
												int temp= i;	
												
													}
											if(strcmp($5,name[i])== 0){
												value[index]= value[temp] / value[i];
													}
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($3,name[i])== 0){
											
											temp = i;
											}
											if(strcmp($5,name[i])== 0){
											name[counter] = $1;
											value[counter] = value[temp] / value[i];
											counter++;
											}
										}
										
										
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
									}
					|
					VAR IS VAR DIVIDED NUM		{//fprintf(stdout,"Var is num plus num\n");
									int temp = 1;
									for(int i = 0;i<counter;i++){	
										if(strcmp($1,name[i])== 0){
											int index = i;
											if(strcmp($3,name[i])== 0){
												value[index]=$5 / value[i];	
												temp = 0;
													}
												}
										
											}
									if(temp == 1){
										for(int i = 0;i<counter;i++){
											if(strcmp($3,name[i])== 0){
											name[counter] = $1;
											value[counter] = $5 / value[i];
											counter++;
											//fprintf(stdout,"Var: %s, num: %d\n", $1, $3 + $5);
												}
											}
										}
									}





					;



%%
