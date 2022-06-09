- Uses Angel SWI operations.
- Test code is in main.s
- It uses Stage1.s, Stage2.s, Stage3.s and io.s
- Courtesy Ramanuj Goel for io.s


- Size of list should be less than 40
- Total space alloted to store full list is 512	


- Input/Output samples

Input:

Enter size of list
5
Enter elements of list
load store
move
compare
global
loading
Enter 1 for case sensitive, else it will be case insensitive 
1
Enter 1 to remove duplicate else it will not remove duplicate
2

Output:

Sorted list:
compare
global
load store
loading
move

********************************************************************************

Input:

Enter size of list
5
Enter elements of list
fr
de
fr
efc
fr
Enter 1 for case sensitive, else it will be case insensitive 
1
Enter 1 to remove duplicate else it will not remove duplicate
1

Output:

de
efc
fr

********************************************************************************

Input:

Enter size of list
10
Enter elements of list
India
singapore
UK
china
india
madagascar
argentina
uk
france
mexico
Enter 1 for case sensitive, else it will be case insensitive 
2
Enter 1 to remove duplicate else it will not remove duplicate
1

Output:

Sorted list:
argentina
china
france
india
madagascar
mexico
singapore
uk


********************************************************************************

Input:

Enter size of list
10
Enter elements of list
India
singapore
UK
columbia
india
uK
nigeria
Indonesia
Uk
guatemala
Enter 1 for case sensitive, else it will be case insensitive 
1
Enter 1 to remove duplicate else it will not remove duplicate
1

Output:

Sorted list:
India
Indonesia
UK
Uk
columbia
guatemala
india
nigeria
singapore
uK

********************************************************************************

Input:

Enter size of list
15
Enter elements of list
sinaloa
Suriname
chILE
Chile
luxemborg
guinea
wilson
el paso
castle
snow
sNow
Matt murdock
Starkov
general
kirigan
Enter 1 for case sensitive, else it will be case insensitive 
2
Enter 1 to remove duplicate else it will not remove duplicate
1

Output:

Sorted list:
castle
Chile
el paso
general
guinea
kirigan
luxemborg
Matt murdock
sinaloa
sNow
Starkov
Suriname
wilson

********************************************************************************

Input:

Enter size of list
5
Enter elements of list
nivtr bt
ihf frtg
oi frih fro
oi frih fro
oi frih fronfrb frb
Enter 1 for case sensitive, else it will be case insensitive 
2
Enter 1 to remove duplicate else it will not remove duplicate
1

Output:

Sorted list:
ihf frtg
nivtr bt
oi frih fro
oi frih fronfrb frb

********************************************************************************

Input:

Enter size of list
6
Enter elements of list
abc
Abc
ABC
aBc
deg
DEG
Enter 1 for case sensitive, else it will be case insensitive 
2
Enter 1 to remove duplicate else it will not remove duplicate
1

Output:

Sorted list:
Abc
DEG
