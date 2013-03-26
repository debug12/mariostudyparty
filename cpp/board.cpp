#include <iostream>
#include <stdlib.h>
#include <fstream>
using namespace std;

// Author: Prateek Sachdeva
// Team Members: Deepak Kumar, Andrew Thorwall, Michael Pasquale
// ENGINEERING 100: Microprocessor and Toys, Section 250

// PURPOSE:
// Creates a board based on the input size of the board.
// Chances of having coins on a square are 60% and chances of having a star is 20%.
// You can only have a star or a coin on a square, but not both.
// If a star is possible (because of the rand() function), the star has a bigger priority even if a coin can be there as well.

// DETAILS:
// The board has 0's for regular squares.
// If the square value > 0, then there are that many number of coins on that square (coin values are in between 1 and 20).
// If the square has a value of -1, then there is a star there and it costs 20 coins to buy it.
// THE STARTING SQUARE FOR EVERY PLAYER is TOP LEFT --- i.e. (0, 0).

int main() {
  
  int size = 0, hasCoins = 0, numCoins = 0, hasStars = 0;
  cout << "There is absolutely no error checking. Input must be an integer\n" << endl;
  
  cout << "Please enter the size of the board: ";
  cin >> size;
  
  ofstream outfile("board.txt");
  
  for(int i = 0; i < size; i++) {
    for(int j = 0; j < size; j++) {
      
      hasCoins = rand() % 10 + 1;
      hasStars = rand() % 10 + 1;
      numCoins = rand() % 20 + 1;
      
      if(hasStars > 8)
	      outfile << "-1\t";
      else if(hasCoins > 4)
        outfile << numCoins << "\t";
      else
        outfile << "0\t";
    }
    
    outfile << endl;
  }
  
  outfile.close();
  cout << "The board was created and saved in a file called board.txt" << endl;
  
  return(1);
}
